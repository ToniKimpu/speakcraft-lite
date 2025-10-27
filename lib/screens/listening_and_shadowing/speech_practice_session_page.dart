import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pmp_english/model/listening/listening.dart';
import 'package:pmp_english/screens/days/spoken_pattern/widgets/footer_widget.dart';
import 'package:pmp_english/screens/listening_and_shadowing/shadowing_widgets/shadowing_player.dart';
import 'package:pmp_english/shared_widgets/main_scaffold.dart';
import 'package:record/record.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'model/subtitle_line.dart';

class SpeechPracticeSessionPage extends StatefulWidget {
  const SpeechPracticeSessionPage({
    super.key,
    required this.listening,
  });

  final Listening listening;

  @override
  State<SpeechPracticeSessionPage> createState() =>
      _SpeechPracticeSessionPageState();
}

class _SpeechPracticeSessionPageState extends State<SpeechPracticeSessionPage> {
  late YoutubePlayerController _controller;
  Duration _position = Duration.zero;

  List<SubtitleLine> _subtitles = [];
  bool _backPressed = false;

  @override
  void initState() {
    super.initState();

    loadSubtitles().then((data) {
      setState(() => _subtitles = data);
    });

    _controller = YoutubePlayerController(
      initialVideoId: "H14bBuluwB8",
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        hideThumbnail: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: false,
        hideControls: true,
      ),
    )..addListener(() {
        if (mounted) {
          setState(() {
            _position = _controller.value.position;
          });
        }
      });
  }

  Future<List<SubtitleLine>> loadSubtitles() async {
    final jsonString =
        await rootBundle.loadString("assets/subtitles/audio.json");
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((e) => SubtitleLine.fromJson(e)).toList();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onRecordingStopped(String path) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Recording saved at:\n$path")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;

        Future.delayed(const Duration(milliseconds: 300), () {
          if (context.mounted) Navigator.of(context).pop();
        });
        setState(() {
          _backPressed = true;
        });
      },
      child: YoutubePlayerBuilder(
        player: YoutubePlayer(controller: _controller),
        builder: (context, player) {
          return _backPressed
              ? const MainScaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : MainScaffold(
                  appBar: AppBar(
                    backgroundColor: const Color(0xFF0F2027),
                    title: const Text(
                      "Speech Practice Session",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  body: Column(
                    children: [
                      ShadowingPlayer(
                        listening: widget.listening,
                        controller: _controller,
                        player: player,
                        position: _position,
                        totalDuration: Duration(seconds: widget.listening.end),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 120,
                        child: PageView.builder(
                          itemCount: 10,
                          controller: PageController(initialPage: 0),
                          onPageChanged: (index) {
                            // _controller.load(_subtitles[index].videoId);
                          },
                          itemBuilder: (context, index) {
                            return const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                "When I was 27 years old, I left a very demanding job, for a job that is even more demanding — Teaching.",
                                style: TextStyle(
                                  fontSize: 16,
                                  height: 1.4,
                                  color: Colors.white,
                                  fontFamily: "ArchivoBlack Regular",
                                ),
                                maxLines: 5,
                              ),
                            );
                          },
                        ),
                      ),
                      Recorder(
                        onStop: _onRecordingStopped,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 1,
                                color: Colors.white.withValues(alpha: 0.2),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 16),
                              ),
                            ),
                            const Text(
                              "Records",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontFamily: "ArchivoBlack Regular",
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 1,
                                color: Colors.white.withValues(alpha: 0.2),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      FooterWidget(
                        totalPage: 10,
                        currentPage: 1,
                        onPageChanged: (index) {},
                        nextEnabled: true,
                      )
                    ],
                  ),
                );
        },
      ),
    );
  }
}

/// Recorder Widget (from official record GitHub example, simplified)
class Recorder extends StatefulWidget {
  final void Function(String path) onStop;
  const Recorder({super.key, required this.onStop});

  @override
  State<Recorder> createState() => _RecorderState();
}

class _RecorderState extends State<Recorder> {
  int _recordDuration = 0;
  Timer? _timer;
  late final AudioRecorder _audioRecorder;
  RecordState _recordState = RecordState.stop;
  StreamSubscription<RecordState>? _recordSub;
  StreamSubscription<Amplitude>? _amplitudeSub;
  Amplitude? _amplitude;

  @override
  void initState() {
    super.initState();
    _audioRecorder = AudioRecorder();

    _recordSub = _audioRecorder.onStateChanged().listen((recordState) {
      setState(() => _recordState = recordState);
      if (recordState == RecordState.record) {
        _startTimer();
      } else if (recordState == RecordState.stop) {
        _timer?.cancel();
        _recordDuration = 0;
      } else if (recordState == RecordState.pause) {
        _timer?.cancel();
      }
    });

    _amplitudeSub = _audioRecorder
        .onAmplitudeChanged(const Duration(milliseconds: 300))
        .listen((amp) {
      setState(() => _amplitude = amp);
    });
  }

  Future<void> _start() async {
    try {
      // Step 1: Explicitly request mic permission
      final micGranted = await requestMicPermission();
      if (!micGranted) {
        debugPrint("Microphone permission not granted.");
        return;
      }

      // Step 2: Double-check with record package
      if (await _audioRecorder.hasPermission()) {
        const config = RecordConfig(
          encoder: AudioEncoder.aacLc,
          numChannels: 1,
          bitRate: 128000,
        );

        // Step 3: Use your local app directory instead of temp
        final dir = await getApplicationDocumentsDirectory();
        final filePath =
            '${dir.path}/speech_practice_${DateTime.now().millisecondsSinceEpoch}.m4a';

        debugPrint('Recording to: $filePath');
        await _audioRecorder.start(config, path: filePath);
      }
    } catch (e) {
      debugPrint("Error starting recording: $e");
    }
  }

  Future<void> _stop() async {
    final path = await _audioRecorder.stop();
    if (path != null) widget.onStop(path);
  }

  Future<void> _pause() async => _audioRecorder.pause();
  Future<void> _resume() async => _audioRecorder.resume();

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() => _recordDuration++);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _recordSub?.cancel();
    _amplitudeSub?.cancel();
    _audioRecorder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final minutes = _format(_recordDuration ~/ 60);
    final seconds = _format(_recordDuration % 60);
    final isRecording = _recordState == RecordState.record;
    final isPaused = _recordState == RecordState.pause;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: _recordState != RecordState.stop
                ? null
                : () {
                    _start();
                  },
            child: Ink(
              width: double.infinity,
              height: 52,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white.withValues(alpha: 0.04),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.2),
                  width: 1.5,
                ),
              ),
              child: _recordState == RecordState.stop
                  ? const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.mic,
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          "Tap to record",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // const SizedBox(width: 18),
                        // if (_recordState != RecordState.stop)
                        // _buildCircleButton(
                        //   icon: isPaused ? Icons.play_arrow : Icons.pause,
                        //   color: Colors.orange,
                        //   iconColor: Colors.white,
                        //   onTap: () => isPaused ? _resume() : _pause(),
                        // ),
                        InkWell(
                          borderRadius: BorderRadius.circular(100),
                          onTap: () => _stop(),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Ink(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(4),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.2),
                                    spreadRadius: 3,
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(100),
                          onTap: () => isPaused ? _resume() : _pause(),
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: Icon(
                              isPaused ? Icons.play_arrow : Icons.pause,
                              size: 32,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "$minutes:$seconds",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            letterSpacing: 0.5,
                            fontFamily: "ArchivoBlack Regular",
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCircleButton({
    required IconData icon,
    required Color color,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, color: iconColor, size: 26),
      ),
    );
  }

  String _format(int n) => n.toString().padLeft(2, '0');

  Future<bool> requestMicPermission() async {
    final status = await Permission.microphone.request();
    if (status.isGranted) return true;

    if (status.isPermanentlyDenied) {
      await openAppSettings();
    }
    return false;
  }

  Future<File> getLocalRecordingFile() async {
    final dir = await getApplicationDocumentsDirectory();
    final path =
        '${dir.path}/my_recording_${DateTime.now().millisecondsSinceEpoch}.m4a';
    return File(path);
  }
}
