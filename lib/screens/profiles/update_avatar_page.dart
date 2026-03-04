import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:pmp_english/bloc/user_bloc/user_bloc.dart';
import 'package:pmp_english/config/common_extensions.dart';
import 'package:pmp_english/config/pmp_text_styles.dart';
import 'package:pmp_english/core/di/service_locator.dart';
import 'package:pmp_english/model/app_user/app_user.dart';
import 'package:pmp_english/shared_widgets/main_scaffold.dart';

class UpdateAvatarPage extends StatefulWidget {
  const UpdateAvatarPage({
    super.key,
  });

  @override
  State<UpdateAvatarPage> createState() => _UpdateAvatarPageState();
}

class _UpdateAvatarPageState extends State<UpdateAvatarPage> {
  final _userBloc = UserBloc();
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

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildProfileGrid(List<String> profiles) {
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
            padding: EdgeInsets.all(selected ? 6 : 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                width: selected ? 2 : 0,
                color: selected ? Colors.greenAccent : Colors.transparent,
              ),
              boxShadow: selected
                  ? [
                      BoxShadow(
                        color: Colors.greenAccent.withOpacity(0.4),
                        blurRadius: 8,
                        spreadRadius: 2,
                      )
                    ]
                  : [],
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
    return BlocProvider(
      create: (context) => _userBloc,
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
          return MainScaffold(
            body: Stack(
              children: [
                Positioned.fill(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(
                        left: 16, top: 16, right: 16, bottom: 80),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 60),
                        Align(
                          alignment: Alignment.center,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(9999),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: 110,
                              height: 110,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: _selectedProfile != null
                                    ? [
                                        BoxShadow(
                                          color: Colors.greenAccent
                                              .withOpacity(0.5),
                                          blurRadius: 12,
                                          spreadRadius: 3,
                                        )
                                      ]
                                    : [],
                              ),
                              child: _selectedProfile != null
                                  ? Image.asset(
                                      'assets/images/profiles/$_selectedProfile',
                                      fit: BoxFit.cover,
                                    )
                                  : const Icon(
                                      Icons.account_circle,
                                      size: 110,
                                      color: Colors.grey,
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
                    color: Colors.white,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Positioned(
                  left: 16,
                  right: 16,
                  bottom: 20,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      if (_selectedProfile == null) {
                        showErrorSnackbar("Please select a profile");
                        return;
                      }
                      if (_selectedProfile ==
                          sl<ValueNotifier<AppUser>>().value.profilePath) {
                        showErrorSnackbar("Please select a different profile");
                        return;
                      }
                      _userBloc.add(
                        UserEvent.updateUserAvatar(_selectedProfile!),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
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
                          )
                        ],
                      ),
                      child: Center(
                        child: isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              )
                            : Text(
                                "Save Changes",
                                style: PmpTextStyles.body1Regular.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.8,
                                ),
                              ),
                      ),
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
    return Card(
      color: Colors.white.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                title,
                style: PmpTextStyles.body1Semi
                    .copyWith(color: Colors.white, fontSize: 18),
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
