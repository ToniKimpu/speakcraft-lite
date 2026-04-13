import 'package:flutter/material.dart';
import 'package:pmp_english/config/pmp_text_styles.dart';

class SignUpProfile extends StatefulWidget {
  const SignUpProfile({
    super.key,
    required this.onProfileSelected,
  });

  final Function(String profile) onProfileSelected;

  @override
  State<SignUpProfile> createState() => _SignUpProfileState();
}

class _SignUpProfileState extends State<SignUpProfile> {
  final _maleProfiles = [
    'Boy_01.png',
    'Boy_02.png',
    'Boy_03.png',
    'Boy_04.png',
    'Boy_05.png',
    'Boy_06.png',
    'Boy_07.png',
    'Boy_08.png',
    'Boy_09.png',
    'Boy_10.png',
  ];

  final _femaleProfiles = [
    'Girl_01.png',
    'Girl_02.png',
    'Girl_03.png',
    'Girl_04.png',
    'Girl_05.png',
    'Girl_06.png',
    'Girl_07.png',
    'Girl_08.png',
    'Girl_09.png',
    'Girl_10.png',
  ];

  late final ValueNotifier<String?> _selectedProfileNotifier;

  @override
  void initState() {
    super.initState();
    _selectedProfileNotifier = ValueNotifier<String?>(null);
  }

  @override
  void dispose() {
    super.dispose();
    _selectedProfileNotifier.dispose();
  }

  Widget _buildProfileGrid(List<String> profiles) {
    final colorScheme = Theme.of(context).colorScheme;
    return GridView.builder(
      itemCount: profiles.length,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
      ),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            _selectedProfileNotifier.value = profiles[index];
            widget.onProfileSelected(profiles[index]);
          },
          child: ValueListenableBuilder<String?>(
            valueListenable: _selectedProfileNotifier,
            builder: (context, selectedProfile, _) {
              final selected = selectedProfile == profiles[index];
              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.all(selected ? 4 : 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    width: selected ? 2 : 0,
                    color: selected ? colorScheme.primary : Colors.transparent,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/images/profiles/${profiles[index]}',
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 60),
          Align(
            alignment: Alignment.center,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(9999),
              child: ValueListenableBuilder<String?>(
                valueListenable: _selectedProfileNotifier,
                builder: (context, selectedProfile, child) {
                  return SizedBox(
                    width: 110,
                    height: 110,
                    child: selectedProfile != null
                        ? Image.asset(
                            'assets/images/profiles/$selectedProfile',
                            fit: BoxFit.cover,
                          )
                        : Icon(
                            Icons.account_circle,
                            size: 110,
                            color: colorScheme.onSurfaceVariant,
                          ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildSection('Male', _maleProfiles),
          const SizedBox(height: 20),
          _buildSection('Female', _femaleProfiles),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<String> profiles) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                title,
                style: PmpTextStyles.body1Semi.copyWith(
                  color: colorScheme.onSurface,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 8),
            _buildProfileGrid(profiles),
          ],
        ),
      ),
    );
  }
}
