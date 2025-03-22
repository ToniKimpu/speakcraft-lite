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
import 'package:pmp_english/config/pmp_text_styles.dart';
import 'package:pmp_english/global_app_state.dart';
import 'package:pmp_english/shared_widgets/default_profile.dart';
import 'package:pmp_english/shared_widgets/main_scaffold.dart';

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
    return MainScaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RepaintBoundary(
              key: _globalKey,
              child: 
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.blue.withOpacity(0.5),
                    width: 4,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    if (appUser.profilePath != null)
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.6),
                              blurRadius: 18,
                              spreadRadius: 4,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(9999),
                          child: Image.asset(
                            'assets/images/profiles/${appUser.profilePath}',
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    if (appUser.profilePath == null) const DefaultProfile(),
                    const SizedBox(height: 12),
                    Text(
                      appUser.name,
                      style: PmpTextStyles.body2Semi.copyWith(
                        color: Colors.black.withOpacity(0.95),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        shadows: [
                          Shadow(
                            color: Colors.blue.withOpacity(0.4),
                            blurRadius: 12,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '(${appUser.email})',
                      style: PmpTextStyles.label2Regular.copyWith(
                        color: Colors.black.withOpacity(0.8),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.orange.withOpacity(0.8),
                                blurRadius: 15,
                                spreadRadius: 5,
                              ),
                            ],
                            gradient: const LinearGradient(
                              colors: [Colors.amber, Colors.deepOrange],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          appUser.accountId,
                          style: PmpTextStyles.body2Semi.copyWith(
                            color: Colors.black.withOpacity(0.95),
                            fontSize: 15,
                            shadows: [
                              Shadow(
                                color: Colors.orange.withOpacity(0.3),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => _saveImage(),
              child: Ink(
                height: 48,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF00C6FF), Color(0xFF0072FF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.3),
                      blurRadius: 6,
                      spreadRadius: 1,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'Save Image',
                    style: PmpTextStyles.body1Semi.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.8,
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
