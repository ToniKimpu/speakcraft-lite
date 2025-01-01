import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gal/gal.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pmp_english/config/common_extensions.dart';
import 'package:pmp_english/config/pmp_colors.dart';
import 'package:pmp_english/config/pmp_text_styles.dart';
import 'package:pmp_english/global_app_state.dart';
import 'package:pmp_english/shared_widgets/default_profile.dart';

class FreeUserScreen extends StatefulWidget {
  const FreeUserScreen({super.key});

  @override
  State<FreeUserScreen> createState() => _FreeUserScreenState();
}

class _FreeUserScreenState extends State<FreeUserScreen> {
  final _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final appUser = GlobalAppState().currentUser;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RepaintBoundary(
              key: _globalKey,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    if (appUser.profilePath != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(9999),
                        child: Image.asset(
                          'assets/images/profiles/${appUser.profilePath}',
                          width: 60,
                          height: 60,
                        ),
                      ),
                    if (appUser.profilePath == null) const DefaultProfile(),
                    Text(
                      appUser.name,
                      style:
                          PmpTextStyles.body2Semi.copyWith(color: Colors.black),
                    ),
                    Text(
                      '(${appUser.email})',
                      style: PmpTextStyles.label2Regular
                          .copyWith(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9999),
                            color: PmpColors.primary400,
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          appUser.accountId,
                          style: PmpTextStyles.body2Semi
                              .copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Material(
              borderRadius: BorderRadius.circular(12),
              color: PmpColors.primary400,
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  _saveImage();
                },
                child: SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      'Save Image',
                      style:
                          PmpTextStyles.body1Semi.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveImage() async {
    try {
      bool permissionGranted = false;

      final plugin = DeviceInfoPlugin();
      AndroidDeviceInfo android = await plugin.androidInfo;

      PermissionStatus permissionStatus;
      if (android.version.sdkInt < 33) {
        permissionStatus = await Permission.storage.request();
      } else {
        permissionStatus = await Permission.photos.request();
      }
      if (permissionStatus.isGranted) {
        permissionGranted = true;
      } else if (permissionStatus.isPermanentlyDenied) {
        await openAppSettings();
        return;
      } else if (permissionStatus.isDenied) {
        permissionGranted = false;
      }

      if (permissionGranted) {
        try {
          RenderRepaintBoundary boundary = _globalKey.currentContext!
              .findRenderObject() as RenderRepaintBoundary;
          ui.Image image = await boundary.toImage(pixelRatio: 3.0);
          ByteData? byteData =
              await image.toByteData(format: ui.ImageByteFormat.png);
          Uint8List pngBytes = byteData!.buffer.asUint8List();

          final directory = (await getApplicationDocumentsDirectory()).path;
          final String filePath =
              '$directory/${GlobalAppState().currentUser.accountId.toLowerCase()}.png';
          final File file = File(filePath);
          await file.writeAsBytes(pngBytes);

          await Gal.requestAccess();
          await Gal.putImage(file.path);
          showSuccessSnackbar('Saved photo successfully!');
        } catch (e) {
          showErrorSnackbar('Failed to save the image. Please try again.');
        }
      } else {
        showErrorSnackbar('Permission is required to save images.');
      }
    } catch (e) {
      debugPrint('CaptureData: ${e.toString()}');
    }
  }
}
