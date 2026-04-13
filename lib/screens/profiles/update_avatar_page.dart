import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmp_english/bloc/user_bloc/user_bloc.dart';
import 'package:pmp_english/config/common_extensions.dart';
import 'package:pmp_english/config/pmp_text_styles.dart';
import 'package:pmp_english/core/di/service_locator.dart';
import 'package:pmp_english/model/app_user/app_user.dart';

class UpdateAvatarPage extends StatefulWidget {
  const UpdateAvatarPage({
    super.key,
  });

  @override
  State<UpdateAvatarPage> createState() => _UpdateAvatarPageState();
}

class _UpdateAvatarPageState extends State<UpdateAvatarPage> {
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

  String? _selectedProfile;

  @override
  void initState() {
    super.initState();
    _selectedProfile = sl<ValueNotifier<AppUser>>().value.profilePath;
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
        final selected = _selectedProfile == profiles[index];
        return InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            setState(() {
              _selectedProfile = profiles[index];
            });
          },
          child: AnimatedContainer(
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
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BlocProvider(
      create: (context) => UserBloc(),
      child: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          state.maybeWhen(
            onSuccess: () {
              Navigator.pop(context, true);
            },
            orElse: () => -1,
          );
        },
        builder: (context, state) {
          final isLoading = state.maybeWhen(
            loading: () => true,
            orElse: () => false,
          );
          return Scaffold(
            body: Stack(
              children: [
                Positioned.fill(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(
                        left: 16, top: 16, right: 16, bottom: 96),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 60),
                        Align(
                          alignment: Alignment.center,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(9999),
                            child: SizedBox(
                              width: 110,
                              height: 110,
                              child: _selectedProfile != null
                                  ? Image.asset(
                                      'assets/images/profiles/$_selectedProfile',
                                      fit: BoxFit.cover,
                                    )
                                  : Icon(
                                      Icons.account_circle,
                                      size: 110,
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildSection('Male', _maleProfiles),
                        const SizedBox(height: 20),
                        _buildSection('Female', _femaleProfiles),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 30,
                  left: 20,
                  child: BackButton(
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Positioned(
                  left: 16,
                  right: 16,
                  bottom: 20,
                  child: SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: FilledButton(
                      onPressed: isLoading
                          ? null
                          : () {
                              if (_selectedProfile == null) {
                                showErrorSnackbar('Please select a profile');
                                return;
                              }
                              if (_selectedProfile ==
                                  sl<ValueNotifier<AppUser>>().value.profilePath) {
                                showErrorSnackbar(
                                    'Please select a different profile');
                                return;
                              }
                              context.read<UserBloc>().add(
                                    UserEvent.updateUserAvatar(
                                        _selectedProfile!),
                                  );
                            },
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Save Changes'),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
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
