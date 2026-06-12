import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speakcraft/config/pmp_text_styles.dart';
import 'package:speakcraft/l10n/generated/l10n.dart';

/// Shared copy/edit helpers for the learner's guided paragraph, used by both
/// the wizard's "This is yours" step and the record page's script card.

/// Upper bound on the editable paragraph — generous for a ~2-minute monologue
/// (~120 words) but caps spam / accidental wall-of-text pastes.
const int kGuidedParagraphMaxChars = 800;

/// Copies [paragraph] to the clipboard and confirms with a snackbar.
void copyParagraphToClipboard(BuildContext context, String paragraph) {
  Clipboard.setData(ClipboardData(text: paragraph));
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context).txtDsGuidedCopied),
        duration: const Duration(seconds: 2),
      ),
    );
}

/// Opens a bottom sheet to edit [initial]; resolves to the trimmed new text, or
/// null if cancelled. The sheet owns its [TextEditingController] so it's only
/// disposed once the sheet has fully closed — disposing it inline right after
/// `showModalBottomSheet` returns touches it during the dismiss animation and
/// throws "A TextEditingController was used after being disposed".
Future<String?> showEditParagraphSheet(BuildContext context, String initial) {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (_) => _ParagraphEditSheet(initial: initial),
  );
}

class _ParagraphEditSheet extends StatefulWidget {
  const _ParagraphEditSheet({required this.initial});
  final String initial;

  @override
  State<_ParagraphEditSheet> createState() => _ParagraphEditSheetState();
}

class _ParagraphEditSheetState extends State<_ParagraphEditSheet> {
  late final TextEditingController _controller =
      TextEditingController(text: widget.initial);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 4,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.txtDsGuidedEditTitle,
            style: PmpTextStyles.body1Semi.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _controller,
            autofocus: true,
            minLines: 4,
            maxLines: 8,
            maxLength: kGuidedParagraphMaxChars,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(border: OutlineInputBorder()),
          ),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: () => Navigator.pop(context, _controller.text.trim()),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(l10n.txtDsGuidedEditSave),
            ),
          ),
        ],
      ),
    );
  }
}
