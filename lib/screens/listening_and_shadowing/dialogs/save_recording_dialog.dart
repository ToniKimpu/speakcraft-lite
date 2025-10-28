import 'package:flutter/material.dart';
import 'package:pmp_english/config/pmp_text_styles.dart';

import '../../../shared_widgets/practice_text_field.dart';

class SaveRecordingDialog extends StatefulWidget {
  const SaveRecordingDialog({
    super.key,
  });

  @override
  State<SaveRecordingDialog> createState() => _SaveRecordingDialogState();
}

class _SaveRecordingDialogState extends State<SaveRecordingDialog> {
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: "Voice_001");
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      backgroundColor: Colors.transparent, // removes white edges
      child: Container(
        clipBehavior: Clip.antiAlias,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF203A43), Color(0xFF2C5364)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(width: 1.5, color: Colors.white),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Title
            Text(
              "Save your recording?",
              textAlign: TextAlign.center,
              style: PmpTextStyles.body1Regular.copyWith(
                color: Colors.white,
                fontFamily: 'ArchivoBlack Regular',
                fontSize: 20,
                letterSpacing: 0.5,
              ),
            ),

            const SizedBox(height: 16),

            // Text Field Label
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Recording name",
                style: PmpTextStyles.body2Regular.copyWith(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ),

            const SizedBox(height: 8),

            // Text Field
            PracticeTextField(
              controller: _nameController,
              englishOnly: true,
            ),

            const SizedBox(height: 24),

            // Divider
            Divider(
              color: Colors.white.withOpacity(0.3),
              thickness: 1,
              height: 1,
            ),

            const SizedBox(height: 16),

            // Action buttons
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white70,
                      overlayColor: Colors.white12,
                    ),
                    child: const Text("Cancel"),
                  ),
                ),
                Container(
                  width: 1,
                  height: 24,
                  color: Colors.white.withOpacity(0.2),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      // discard logic
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.orangeAccent,
                      overlayColor: Colors.white12,
                    ),
                    child: const Text("Discard"),
                  ),
                ),
                Container(
                  width: 1,
                  height: 24,
                  color: Colors.white.withOpacity(0.2),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      // save logic
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.lightGreenAccent,
                      overlayColor: Colors.white12,
                    ),
                    child: const Text("Save"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
