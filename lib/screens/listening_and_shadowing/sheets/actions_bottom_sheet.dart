import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pmp_english/config/pmp_routes.dart';

import '../../../config/pmp_text_styles.dart';
import '../../../l10n/generated/l10n.dart';
import '../../../model/listening/listening.dart';

class ActionsBottomSheet extends StatelessWidget {
  const ActionsBottomSheet({
    super.key,
    required this.listening,
  });

  final Listening listening;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 4,
                width: 32,
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: colorScheme.onSurfaceVariant,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const SizedBox(height: 12),
            _buildHeader(context),
            const SizedBox(height: 24),
            if (listening.subtitlePath.trim().isNotEmpty)
              _ActionItem(
                icon: Icons.play_circle_outline,
                label: 'Watch',
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(
                    context,
                    PmpRoutes.youtubeVideoPage,
                    arguments: {
                      "listening": listening,
                    },
                  );
                },
              ),
            Divider(height: 1, color: colorScheme.outlineVariant),
            _ActionItem(
              icon: Icons.lightbulb_outline,
              label: AppLocalizations.of(context).txtViewExplanation,
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, PmpRoutes.sentenceExplanationList,
                    arguments: {
                      "listening": listening,
                    });
              },
            ),
            if (listening.shadowingPath.trim().isNotEmpty)
              Divider(height: 1, color: colorScheme.outlineVariant),
            if (listening.shadowingPath.trim().isNotEmpty)
              _ActionItem(
                icon: Icons.headphones,
                label: 'Shadowing',
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(
                    context,
                    PmpRoutes.shadowingPage,
                    arguments: {
                      "listening": listening,
                    },
                  );
                },
              ),
            if (listening.recordSubtitlePath.trim().isNotEmpty)
              Divider(height: 1, color: colorScheme.outlineVariant),
            if (listening.recordSubtitlePath.trim().isNotEmpty)
              _ActionItem(
                icon: Icons.record_voice_over,
                label: 'Record & Compare',
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(
                    context,
                    PmpRoutes.speechPracticeSessionPage,
                    arguments: {
                      "listening": listening,
                    },
                  );
                },
              ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 80,
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: listening.thumbnail,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: colorScheme.surfaceContainerHighest,
                    child: const Center(
                      child: SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: colorScheme.surfaceContainerHighest,
                    child: Icon(
                      Icons.broken_image,
                      size: 20,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              listening.title,
              style: PmpTextStyles.body2Semi
                  .copyWith(color: colorScheme.onSurface),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionItem extends StatelessWidget {
  const _ActionItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 48,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Icon(icon, color: colorScheme.onSurface, size: 20),
                const SizedBox(width: 12),
                Text(
                  label,
                  style: PmpTextStyles.body2Semi
                      .copyWith(color: colorScheme.onSurface),
                ),
                const Spacer(),
                Icon(Icons.chevron_right,
                    color: colorScheme.onSurfaceVariant, size: 18),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
