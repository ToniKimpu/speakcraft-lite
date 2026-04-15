import 'package:flutter/material.dart';
import 'package:pmp_english/config/pmp_text_styles.dart';

class ProfileItemRow extends StatelessWidget {
  const ProfileItemRow({
    super.key,
    required this.label,
    required this.icon,
    this.accountId,
    required this.onTap,
    this.switchValue = false,
    this.first = false,
    this.last = false,
  });
  final String label;
  final String icon;
  final String? accountId;
  final bool switchValue;
  final VoidCallback onTap;
  final bool first, last;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final borderRadius = first
        ? const BorderRadius.only(
            topLeft: Radius.circular(8), topRight: Radius.circular(8))
        : last
            ? const BorderRadius.only(
                bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8))
            : null;
    // White PNG icons need a consistently dark tile so they stay legible in
    // both themes — use inverseSurface (white→black flip).
    final iconTileColor = colorScheme.inverseSurface;
    return Material(
      color: Colors.transparent,
      borderRadius: borderRadius,
      child: InkWell(
        onTap: accountId != null ? null : () => onTap(),
        borderRadius: borderRadius,
        child: Ink(
          padding: const EdgeInsets.all(6),
          height: 44,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: Colors.transparent,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 36,
                width: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: iconTileColor,
                ),
                child: Center(
                  child: Image.asset(
                    icon,
                    width: 20,
                    height: 20,
                    color: colorScheme.onInverseSurface,
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                label,
                style: PmpTextStyles.body2Medium.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),
              const Spacer(),
              if (accountId == null)
                Icon(
                  Icons.chevron_right,
                  size: 24,
                  color: colorScheme.onSurfaceVariant,
                ),
              if (accountId != null)
                Text(
                  accountId!,
                  style: PmpTextStyles.body2Regular,
                ),
              if (accountId != null)
                const SizedBox(
                  width: 4,
                ),
              if (accountId != null)
                InkWell(
                  borderRadius: BorderRadius.circular(200),
                  onTap: () => onTap(),
                  child: Ink(
                    width: 30,
                    height: 30,
                    padding: const EdgeInsets.all(6),
                    child: Image.asset(
                      "assets/images/ic_copy.png",
                      width: 18,
                      height: 18,
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
