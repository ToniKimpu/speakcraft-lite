import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../config/pmp_colors.dart';

/// Colour tokens for the auth screens, mirroring the CSS variables in
/// `design/auth_mock.html` exactly so the Flutter screens match the mock pixel
/// for pixel in both dark and light mode.
class AuthTokens {
  const AuthTokens({
    required this.text,
    required this.dim,
    required this.mm,
    required this.field,
    required this.fieldBd,
    required this.fieldFocus,
    required this.focusGlow,
    required this.chip,
    required this.chipBd,
    required this.onCyan,
    required this.cyanBright,
    required this.danger,
    required this.gradient,
  });

  final Color text;
  final Color dim;
  final Color mm;
  final Color field;
  final Color fieldBd;
  final Color fieldFocus;
  final Color focusGlow;
  final Color chip;
  final Color chipBd;
  final Color onCyan;
  final Color cyanBright;
  final Color danger;
  final List<Color> gradient;

  static AuthTokens of(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return dark ? _dark : _light;
  }

  static const _dark = AuthTokens(
    text: Color(0xFFEAF1F7),
    dim: Color(0xFF90A4B8),
    mm: Color(0xFFA9C7D6),
    field: Color(0x0DFFFFFF), // white @ .05
    fieldBd: Color(0x21FFFFFF), // white @ .13
    fieldFocus: Color(0x8C28BBE6), // cyanBright @ .55
    focusGlow: Color(0x2428BBE6), // cyanBright @ .14
    chip: Color(0x12FFFFFF), // white @ .07
    chipBd: Color(0x2EFFFFFF), // white @ .18
    onCyan: Color(0xFF04212C),
    cyanBright: Color(0xFF28BBE6),
    danger: Color(0xFFFF6B6B),
    gradient: [Color(0xFF28BBE6), Color(0xFF03789F)],
  );

  static const _light = AuthTokens(
    text: Color(0xFF0F2C3A),
    dim: Color(0xFF5C7585),
    mm: Color(0xFF2E6072),
    field: Color(0xCCFFFFFF), // white @ .80
    fieldBd: Color(0x240D3147), // 0D3147 @ .14
    fieldFocus: Color(0x8C0496C7), // cyan @ .55
    focusGlow: Color(0x1F0496C7), // cyan @ .12
    chip: Color(0x0B0D3147), // 0D3147 @ .045
    chipBd: Color(0x1F0D3147), // 0D3147 @ .12
    onCyan: Color(0xFFFFFFFF),
    cyanBright: Color(0xFF0A9BCC),
    danger: Color(0xFFD7263D),
    gradient: [Color(0xFF0A9BCC), Color(0xFF03789F)],
  );
}

/// Burmese (Padauk) text — the mock's `.mm` lines. Padauk has the Myanmar
/// glyphs that Plus Jakarta Sans lacks.
Text burmeseText(
  String text, {
  required Color color,
  double size = 14,
  FontWeight weight = FontWeight.w400,
  TextAlign align = TextAlign.center,
}) {
  return Text(
    text,
    textAlign: align,
    style: GoogleFonts.padauk(
      color: color,
      fontSize: size,
      fontWeight: weight,
      height: 1.4,
    ),
  );
}

/// Circular glass back button used at the top of Sign Up / OTP (mock `.back`).
class AuthBackButton extends StatelessWidget {
  const AuthBackButton({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final t = AuthTokens.of(context);
    return Material(
      color: t.chip,
      shape: CircleBorder(side: BorderSide(color: t.chipBd)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap ?? () => Navigator.of(context).maybePop(),
        child: SizedBox(
          width: 40,
          height: 40,
          child: Icon(Symbols.arrow_back, size: 22, color: t.text),
        ),
      ),
    );
  }
}

/// Rounded brand/feature glyph in a tinted cyan square (mock `.logo`) or circle
/// (mock `.otp-icon`).
class AuthGlyph extends StatelessWidget {
  const AuthGlyph({
    super.key,
    required this.icon,
    this.size = 84,
    this.iconSize = 42,
    this.circle = false,
  });

  final IconData icon;
  final double size;
  final double iconSize;
  final bool circle;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: circle ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: circle ? null : BorderRadius.circular(26),
        gradient: LinearGradient(
          begin: const Alignment(-0.6, -1),
          end: const Alignment(0.6, 1),
          colors: [
            PmpColors.brandCyanBright.withValues(alpha: dark ? 0.22 : 0.16),
            PmpColors.brandCyan.withValues(alpha: dark ? 0.06 : 0.04),
          ],
        ),
        border: Border.all(
          color: PmpColors.brandCyanBright.withValues(alpha: dark ? 0.30 : 0.28),
        ),
        boxShadow: circle
            ? null
            : [
                BoxShadow(
                  color: PmpColors.brandCyan.withValues(alpha: 0.25),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                ),
              ],
      ),
      child: Icon(icon, size: iconSize, color: PmpColors.brandCyanBright),
    );
  }
}

/// Labelled glass text field with a leading icon and an optional password eye
/// toggle. The border brightens + gains a soft glow ring on focus — mock
/// `.field` / `.field.focus`.
class GlassField extends StatefulWidget {
  const GlassField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.hint,
    this.isPassword = false,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.onChanged,
    this.onSubmitted,
    this.autofillHints,
    this.errorText,
  });

  final TextEditingController controller;
  final String label;
  final IconData icon;
  final String? hint;
  final bool isPassword;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final Iterable<String>? autofillHints;

  /// When non-null, shows a red message under the field and tints its border.
  final String? errorText;

  @override
  State<GlassField> createState() => _GlassFieldState();
}

class _GlassFieldState extends State<GlassField> {
  final _focusNode = FocusNode();
  bool _focused = false;
  late bool _obscure = widget.isPassword;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus != _focused) {
        setState(() => _focused = _focusNode.hasFocus);
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AuthTokens.of(context);
    final hasError = widget.errorText != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 2, bottom: 7),
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: t.text,
            ),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          height: 58,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: t.field,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: hasError
                  ? t.danger
                  : (_focused ? t.fieldFocus : t.fieldBd),
            ),
            boxShadow: (_focused && !hasError)
                ? [
                    BoxShadow(
                      color: t.focusGlow,
                      blurRadius: 0,
                      spreadRadius: 3,
                    ),
                  ]
                : null,
          ),
          child: Row(
            children: [
              Icon(widget.icon, size: 21, color: t.dim),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  focusNode: _focusNode,
                  textAlignVertical: TextAlignVertical.center,
                  obscureText: _obscure,
                  keyboardType: widget.keyboardType,
                  textInputAction: widget.textInputAction,
                  textCapitalization: widget.textCapitalization,
                  onChanged: widget.onChanged,
                  onSubmitted: widget.onSubmitted,
                  autofillHints: widget.autofillHints,
                  cursorColor: t.cyanBright,
                  style: TextStyle(
                    color: t.text,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    // The app's global inputDecorationTheme sets filled:true with
                    // a fillColor — without this it paints a second filled pill
                    // inside our glass box. Turn it off so only our Container is
                    // the field.
                    filled: false,
                    isCollapsed: true,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: widget.hint,
                    hintStyle: TextStyle(
                      color: t.dim,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              if (widget.isPassword)
                GestureDetector(
                  onTap: () => setState(() => _obscure = !_obscure),
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 6),
                    child: Icon(
                      _obscure ? Symbols.visibility_off : Symbols.visibility,
                      size: 21,
                      color: t.dim,
                    ),
                  ),
                ),
            ],
          ),
        ),
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(left: 4, top: 6),
            child: Text(
              widget.errorText!,
              style: TextStyle(
                color: t.danger,
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }
}

/// Full-width cyan gradient button (mock `.btn`). Shows a spinner when
/// [loading]; dims when disabled.
class AuthPrimaryButton extends StatelessWidget {
  const AuthPrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.leadingIcon,
    this.trailingIcon,
    this.loading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final t = AuthTokens.of(context);
    final enabled = onPressed != null && !loading;
    final r = BorderRadius.circular(16);
    return Opacity(
      opacity: enabled ? 1 : 0.5,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: r,
          boxShadow: [
            BoxShadow(
              color: PmpColors.brandCyan.withValues(alpha: 0.40),
              blurRadius: 26,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: r,
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: enabled ? onPressed : null,
            child: Ink(
              height: 54,
              decoration: BoxDecoration(
                borderRadius: r,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: t.gradient,
                ),
              ),
              child: Center(
                child: loading
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(t.onCyan),
                        ),
                      )
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (leadingIcon != null) ...[
                            Icon(leadingIcon, size: 20, color: t.onCyan),
                            const SizedBox(width: 9),
                          ],
                          Text(
                            label,
                            style: TextStyle(
                              color: t.onCyan,
                              fontSize: 15.5,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          if (trailingIcon != null) ...[
                            const SizedBox(width: 9),
                            Icon(trailingIcon, size: 20, color: t.onCyan),
                          ],
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Full-width neutral "chip" button used for Continue with Google (mock
/// `.btn-ghost`).
class AuthGhostButton extends StatelessWidget {
  const AuthGhostButton({
    super.key,
    required this.label,
    this.onPressed,
    this.leading,
    this.loading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final Widget? leading;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final t = AuthTokens.of(context);
    final enabled = onPressed != null && !loading;
    final r = BorderRadius.circular(16);
    return Opacity(
      opacity: enabled ? 1 : 0.6,
      child: Material(
        color: t.chip,
        borderRadius: r,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: enabled ? onPressed : null,
          child: Ink(
            height: 54,
            decoration: BoxDecoration(
              borderRadius: r,
              border: Border.all(color: t.chipBd),
            ),
            child: Center(
              child: loading
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(t.text),
                      ),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (leading != null) ...[
                          leading!,
                          const SizedBox(width: 11),
                        ],
                        Text(
                          label,
                          style: TextStyle(
                            color: t.text,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

/// "OR" divider with a hairline on each side (mock `.divider`).
class AuthOrDivider extends StatelessWidget {
  const AuthOrDivider({super.key, this.label = 'OR'});

  final String label;

  @override
  Widget build(BuildContext context) {
    final t = AuthTokens.of(context);
    return Row(
      children: [
        Expanded(child: Container(height: 1, color: t.chipBd)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: t.dim,
            ),
          ),
        ),
        Expanded(child: Container(height: 1, color: t.chipBd)),
      ],
    );
  }
}

/// "Don't have an account? Sign up" style footer row (mock `.foot`).
class AuthFootLink extends StatelessWidget {
  const AuthFootLink({
    super.key,
    required this.prompt,
    required this.action,
    required this.onTap,
  });

  final String prompt;
  final String action;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = AuthTokens.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          prompt,
          style: TextStyle(fontSize: 13.5, color: t.dim),
        ),
        TextButton(
          onPressed: onTap,
          style: TextButton.styleFrom(
            minimumSize: Size.zero,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            action,
            style: TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
              color: t.cyanBright,
            ),
          ),
        ),
      ],
    );
  }
}

/// Inline cyan text link, e.g. "Forgot password?" (mock `.link`).
class AuthTextLink extends StatelessWidget {
  const AuthTextLink({super.key, required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = AuthTokens.of(context);
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        minimumSize: Size.zero,
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: t.cyanBright,
        ),
      ),
    );
  }
}

/// Two-pill step indicator with a trailing label (mock `.steps`).
class AuthStepIndicator extends StatelessWidget {
  const AuthStepIndicator({
    super.key,
    required this.current,
    required this.total,
    required this.label,
  });

  final int current; // 1-based
  final int total;
  final String label;

  @override
  Widget build(BuildContext context) {
    final t = AuthTokens.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 1; i <= total; i++) ...[
          if (i > 1) const SizedBox(width: 8),
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            height: 6,
            width: i == current ? 34 : 22,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              gradient: i == current
                  ? const LinearGradient(
                      colors: [
                        PmpColors.brandCyanBright,
                        PmpColors.brandCyan,
                      ],
                    )
                  : null,
              color: i == current ? null : t.chipBd,
            ),
          ),
        ],
        const SizedBox(width: 10),
        Text(
          label,
          style: TextStyle(
            fontSize: 11.5,
            fontWeight: FontWeight.w700,
            color: t.dim,
          ),
        ),
      ],
    );
  }
}
