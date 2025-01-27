import 'package:flutter/material.dart';
import 'package:pmp_english/config/pmp_text_styles.dart';
import 'package:pmp_english/global_app_state.dart';
import 'package:pmp_english/model/app_user/app_user.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final AppUser _appUser;

  @override
  void initState() {
    super.initState();
    _appUser = GlobalAppState().currentUser;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image.asset(
                  'assets/images/profiles/${_appUser.profilePath}',
                  width: 80,
                  height: 80,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                _appUser.name,
                style: PmpTextStyles.body1Semi.copyWith(
                  color: Colors.black,
                ),
              ),
              Text(
                '[ ${_appUser.email} ]',
                style: PmpTextStyles.body2Semi.copyWith(
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                'ID : ${_appUser.accountId}',
                style: PmpTextStyles.body2Semi.copyWith(
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
