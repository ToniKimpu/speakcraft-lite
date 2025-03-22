import 'package:flutter/material.dart';
import 'package:pmp_english/config/pmp_text_styles.dart';
import 'package:pmp_english/global_app_state.dart';
import 'package:pmp_english/shared_widgets/main_scaffold.dart';

import '../../shared_widgets/default_profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appUser = GlobalAppState().currentUser;
    return MainScaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: Center(
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 24),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              border: Border.all(
                color: Colors.blue.withOpacity(0.5),
                width: 4,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                if (appUser.profilePath != null)
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.6),
                          blurRadius: 18,
                          spreadRadius: 4,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(9999),
                      child: Image.asset(
                        'assets/images/profiles/${appUser.profilePath}',
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                if (appUser.profilePath == null) const DefaultProfile(),
                const SizedBox(height: 12),
                Text(
                  appUser.name,
                  style: PmpTextStyles.body2Semi.copyWith(
                    color: Colors.black.withOpacity(0.95),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    shadows: [
                      Shadow(
                        color: Colors.blue.withOpacity(0.4),
                        blurRadius: 12,
                      ),
                    ],
                  ),
                ),
                Text(
                  '(${appUser.email})',
                  style: PmpTextStyles.label2Regular.copyWith(
                    color: Colors.black.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.orange.withOpacity(0.8),
                            blurRadius: 15,
                            spreadRadius: 5,
                          ),
                        ],
                        gradient: const LinearGradient(
                          colors: [Colors.amber, Colors.deepOrange],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      appUser.accountId,
                      style: PmpTextStyles.body2Semi.copyWith(
                        color: Colors.black.withOpacity(0.95),
                        fontSize: 15,
                        shadows: [
                          Shadow(
                            color: Colors.orange.withOpacity(0.3),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
