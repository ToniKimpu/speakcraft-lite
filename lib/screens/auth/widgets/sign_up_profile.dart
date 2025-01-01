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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(9999),
              child: ValueListenableBuilder<String?>(
                valueListenable: _selectedProfileNotifier,
                builder: (context, selectedProfile, child) {
                  if (selectedProfile != null) {
                    return Image.asset(
                      'assets/images/profiles/$selectedProfile',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    );
                  }
                  return const Icon(
                    Icons.account_circle,
                    size: 100,
                    color: Colors.grey,
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Male',
            style: PmpTextStyles.body1Semi.copyWith(color: Colors.black),
          ),
          const SizedBox(height: 8),
          GridView.builder(
            itemCount: _maleProfiles.length,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
            ),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return InkWell(
                borderRadius: BorderRadius.circular(9999),
                onTap: () {
                  _selectedProfileNotifier.value = _maleProfiles[index];
                  widget.onProfileSelected(_maleProfiles[index]);
                },
                child: ValueListenableBuilder<String?>(
                    valueListenable: _selectedProfileNotifier,
                    builder: (context, selectedProfile, _) {
                      final selected = selectedProfile != null &&
                          selectedProfile == _maleProfiles[index];
                      return Ink(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9999),
                          border: Border.all(
                            width: selected ? 2 : 0,
                            color: selected ? Colors.green : Colors.transparent,
                          ),
                        ),
                        padding: EdgeInsets.zero,
                        child: Image.asset(
                          'assets/images/profiles/${_maleProfiles[index]}',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      );
                    }),
              );
            },
          ),
          const SizedBox(height: 12),
          Text(
            'Female',
            style: PmpTextStyles.body1Semi.copyWith(color: Colors.black),
          ),
          const SizedBox(height: 8),
          GridView.builder(
            itemCount: _femaleProfiles.length,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
            ),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return InkWell(
                borderRadius: BorderRadius.circular(9999),
                onTap: () {
                  _selectedProfileNotifier.value = _femaleProfiles[index];
                  widget.onProfileSelected(_femaleProfiles[index]);
                },
                child: ValueListenableBuilder<String?>(
                    valueListenable: _selectedProfileNotifier,
                    builder: (context, selectedProfile, _) {
                      final selected = selectedProfile != null &&
                          selectedProfile == _femaleProfiles[index];
                      return Ink(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9999),
                          border: Border.all(
                            width: selected ? 2 : 0,
                            color: selected ? Colors.green : Colors.transparent,
                          ),
                        ),
                        padding: EdgeInsets.zero,
                        child: Image.asset(
                          'assets/images/profiles/${_femaleProfiles[index]}',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      );
                    }),
              );
            },
          ),
        ],
      ),
    );
  }
}
