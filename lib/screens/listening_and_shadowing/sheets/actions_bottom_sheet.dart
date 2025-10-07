import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pmp_english/config/pmp_routes.dart';

import '../../../config/pmp_text_styles.dart';
import '../../../model/listening/listening.dart';

class ActionsBottomSheet extends StatelessWidget {
  const ActionsBottomSheet({
    super.key,
    required this.listening,
  });

  final Listening listening;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 30, 71, 86),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
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
                margin: const EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const SizedBox(height: 12),
            _buildHeader(context),
            const SizedBox(height: 24),
            _ActionItem(
              icon: Icons.music_note_sharp,
              label: 'Play Now',
              onTap: () {
                // TODO: Implement Play Now action
              },
            ),
            Divider(
              height: 1,
              color: Colors.white.withValues(alpha: 0.2),
            ),
            _ActionItem(
              icon: Icons.lightbulb_outline,
              label: 'Learn Vocabularies',
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(
                  context,
                  PmpRoutes.vocabularyListeningPage,
                  arguments: {
                    "listening": listening,
                  },
                );
              },
            ),
            Divider(
              height: 1,
              color: Colors.white.withValues(alpha: 0.2),
            ),
            _ActionItem(
              icon: Icons.check_circle_outline,
              label: 'Practice Now',
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(
                  context,
                  PmpRoutes.listeningSentencePracticeList,
                  arguments: {
                    "listening": listening,
                  },
                );
              },
            ),
            Divider(
              height: 1,
              color: Colors.white.withValues(alpha: 0.2),
            ),
            _ActionItem(
              icon: Icons.mic_none,
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
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
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
                    color: const Color(0xFF203A43),
                    child: const Center(
                      child: SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: const Color(0xFF203A43),
                    child: const Icon(
                      Icons.broken_image,
                      size: 20,
                      color: Colors.white,
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
              style: PmpTextStyles.body2Semi.copyWith(color: Colors.white),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // const Icon(
          //   Icons.chevron_right,
          //   color: Colors.white,
          // ),
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
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 42,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: PmpTextStyles.body2Semi.copyWith(color: Colors.white),
                ),
                const Spacer(),
                const Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
