import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speakcraft/bloc/listening/listening_bloc.dart';
import 'package:speakcraft/config/pmp_routes.dart';
import 'package:speakcraft/config/pmp_text_styles.dart';
import 'package:speakcraft/model/listening/listening.dart';

import '../../l10n/generated/l10n.dart';

class ListeningListPage extends StatefulWidget {
  const ListeningListPage({super.key});

  @override
  State<ListeningListPage> createState() => _ListeningListPageState();
}

class _ListeningListPageState extends State<ListeningListPage> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BlocProvider(
      create: (context) =>
          ListeningBloc()..add(const ListeningEvent.loadListenings()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Listening And Shadowing'),
        ),
        body: BlocBuilder<ListeningBloc, ListeningState>(
          builder: (context, state) {
            return state.maybeWhen(
              loading: () => const Center(
                child: SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(),
                ),
              ),
              loaded: (listenings) {
                if (listenings.isEmpty) {
                  return Center(
                    child: Text(
                      AppLocalizations.of(context).txtWillUploadSoon,
                      style: PmpTextStyles.body2Semi
                          .copyWith(color: colorScheme.onSurface),
                    ),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: listenings.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 14),
                  itemBuilder: (context, index) {
                    return _ListeningCard(listening: listenings[index]);
                  },
                );
              },
              orElse: () => Container(),
            );
          },
        ),
      ),
    );
  }
}

class _ListeningCard extends StatelessWidget {
  const _ListeningCard({required this.listening});

  final Listening listening;

  int get _stepCount {
    var n = 1; // "Study the patterns" step is always present in the hub.
    if (listening.subtitlePath.trim().isNotEmpty) n++;
    if (listening.shadowingPath.trim().isNotEmpty) n++;
    if (listening.recordSubtitlePath.trim().isNotEmpty) n++;
    return n;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Material(
      color: colorScheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            PmpRoutes.listeningHub,
            arguments: {'listening': listening},
          );
        },
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: colorScheme.outline),
          ),
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _Thumbnail(
                imageUrl: listening.thumbnail,
                durationSeconds: listening.end - listening.start,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      listening.title,
                      style: PmpTextStyles.body1Semi
                          .copyWith(color: colorScheme.onSurface),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(
                          Icons.school_outlined,
                          size: 14,
                          color: colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '$_stepCount-step lesson',
                          style: PmpTextStyles.labelMedium.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.chevron_right,
                color: colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Thumbnail extends StatelessWidget {
  const _Thumbnail({required this.imageUrl, required this.durationSeconds});

  final String imageUrl;
  final int durationSeconds;

  static const double _width = 112;
  static const double _height = 72; // 16:9

  String _formatDuration(int seconds) {
    if (seconds <= 0) return '';
    final h = seconds ~/ 3600;
    final m = (seconds % 3600) ~/ 60;
    final s = seconds % 60;
    final ss = s.toString().padLeft(2, '0');
    if (h > 0) {
      final mm = m.toString().padLeft(2, '0');
      return '$h:$mm:$ss';
    }
    return '$m:$ss';
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        alignment: Alignment.center,
        children: [
          CachedNetworkImage(
            imageUrl: imageUrl,
            width: _width,
            height: _height,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              width: _width,
              height: _height,
              color: colorScheme.surface,
              child: const Center(
                child: SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            ),
            errorWidget: (context, url, error) => Container(
              width: _width,
              height: _height,
              color: colorScheme.surface,
              child: Icon(
                Icons.broken_image,
                size: 20,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          // Subtle dark scrim so the play icon stays legible over any thumbnail.
          Container(
            width: _width,
            height: _height,
            color: Colors.black.withValues(alpha: 0.25),
          ),
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.95),
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.play_arrow_rounded,
              size: 20,
              color: Colors.black,
            ),
          ),
          if (durationSeconds > 0)
            Positioned(
              right: 4,
              bottom: 4,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.75),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  _formatDuration(durationSeconds),
                  style: PmpTextStyles.subBold.copyWith(color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
