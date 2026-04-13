import 'package:flutter/material.dart';

class DeviceFailedScreen extends StatelessWidget {
  const DeviceFailedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.warning_amber_rounded,
                size: 80,
                color: Colors.redAccent,
              ),
              const SizedBox(height: 24),
              Text(
                'Device Not Authorized',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              Text(
                'You are logged in from a different device than the one registered. For your account\'s safety, access is restricted.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white70,
                    ),
              ),
              const SizedBox(height: 32),
              // ElevatedButton.icon(
              //   onPressed: () {
              //     Navigator.pop(context);
              //   },
              //   icon: const Icon(
              //     Icons.logout,
              //     color: Colors.white,
              //   ),
              //   label: Text(
              //     'Back',
              //     style: PmpTextStyles.body2Semi.copyWith(color: Colors.white),
              //   ),
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Colors.redAccent,
              //     foregroundColor: Colors.white,
              //     padding: const EdgeInsets.symmetric(
              //       vertical: 12,
              //       horizontal: 24,
              //     ),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(12),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
