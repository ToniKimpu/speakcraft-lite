import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pmp_english/core/logger/app_logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

class Recorder extends StatefulWidget {
  const Recorder({
    super.key,
    required this.onStart,
    required this.onStop,
    required this.recordDuration,
    required this.recordState,
    required this.audioRecorder,
  });
  final AudioRecorder audioRecorder;
  final int recordDuration;
  final RecordState recordState;
  final VoidCallback onStart;
  final VoidCallback onStop;

  @override
  State<Recorder> createState() => _RecorderState();
}

class _RecorderState extends State<Recorder> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> _start() async {
    try {
      // Step 1: Explicitly request mic permission
      final micGranted = await requestMicPermission();
      if (!micGranted) {
        AppLogger.instance.debug("Microphone permission not granted.");
        return;
      }

      // Step 2: Double-check with record package
      if (await widget.audioRecorder.hasPermission()) {
        widget.onStart.call();
        const config = RecordConfig(
          encoder: AudioEncoder.aacLc,
          numChannels: 1,
          bitRate: 128000,
        );

        // Step 3: Use your local app directory instead of temp
        final dir = await getApplicationDocumentsDirectory();
        final filePath =
            '${dir.path}/speech_practice_${DateTime.now().millisecondsSinceEpoch}.m4a';

        AppLogger.instance.debug('Recording to: $filePath');
        await widget.audioRecorder.start(config, path: filePath);
      }
    } catch (e) {
      AppLogger.instance.error("Error starting recording: $e", error: e);
    }
  }

  Future<void> _stop() async {
    // final path = await widget.audioRecorder.stop();
    // if (path != null) widget.onStop(path);
    widget.audioRecorder.pause();
    widget.onStop.call();
  }

  Future<void> _pause() async => widget.audioRecorder.pause();
  Future<void> _resume() async => widget.audioRecorder.resume();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final minutes = _format(widget.recordDuration ~/ 60);
    final seconds = _format(widget.recordDuration % 60);
    // final isRecording = widget.recordState == RecordState.record;
    final isPaused = widget.recordState == RecordState.pause;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: widget.recordState != RecordState.stop
                ? null
                : () {
                    _start();
                    // widget.onStop.call(widget.audioRecorder);
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
              child: widget.recordState == RecordState.stop
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
                        // if (widget.recordState != RecordState.stop)
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
