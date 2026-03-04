// import 'package:flutter/material.dart';
// import 'package:shorebird_code_push/shorebird_code_push.dart';

// import '../../config/pmp_text_styles.dart';
// import '../../shared_widgets/main_scaffold.dart';

// class NewPathScreen extends StatefulWidget {
//   const NewPathScreen({super.key});

//   @override
//   State<NewPathScreen> createState() => _NewPathScreenState();
// }

// class _NewPathScreenState extends State<NewPathScreen> {
//   final _updater = ShorebirdUpdater();
//   bool _isUpdating = false;
//   String? _error;

//   Future<void> _downloadAndInstall() async {
//     setState(() {
//       _isUpdating = true;
//       _error = null;
//     });

//     try {
//       await _updater.update();
//       if (!mounted) return;
//       _isUpdating = false;
//     } catch (e) {
//       setState(() {
//         _error = "Update failed: $e";
//         _isUpdating = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MainScaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(24.0),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Icon(Icons.system_update, color: Colors.white, size: 80),
//               const SizedBox(height: 20),
//               Text(
//                 'A new update is ready to download!',
//                 style: PmpTextStyles.body1Regular.copyWith(color: Colors.white),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 20),
//               if (_error != null)
//                 Text(
//                   _error!,
//                   style: const TextStyle(color: Colors.redAccent),
//                   textAlign: TextAlign.center,
//                 ),
//               const SizedBox(height: 30),
//               _isUpdating
//                   ? const CircularProgressIndicator()
//                   : ElevatedButton.icon(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.white,
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 24,
//                           vertical: 12,
//                         ),
//                       ),
//                       onPressed: _downloadAndInstall,
//                       icon: const Icon(Icons.download),
//                       label: Text(
//                         "Download & Restart",
//                         style: PmpTextStyles.body2Semi,
//                       ),
//                     ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
