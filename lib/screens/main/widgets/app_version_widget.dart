import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pmp_english/config/pmp_colors.dart';
import 'package:pmp_english/config/pmp_text_styles.dart';

class AppVersionWidget extends StatelessWidget {
  const AppVersionWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
                color: PmpColors.neutral100,
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
