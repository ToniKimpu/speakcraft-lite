import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pmp_english/config/pmp_text_styles.dart';

class AppVersionWidget extends StatelessWidget {
  const AppVersionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Align(
      alignment: Alignment.center,
      child: FutureBuilder<PackageInfo>(
        future: PackageInfo.fromPlatform(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            String version = snapshot.data!.version.replaceAll('.dev', '');
            return Text(
              'version - $version',
              style: PmpTextStyles.labelSemi.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
