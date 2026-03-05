import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmp_english/bloc/user_bloc/user_bloc.dart';
import 'package:pmp_english/config/common_extensions.dart';
import 'package:pmp_english/core/di/service_locator.dart';
import 'package:pmp_english/model/app_user/app_user.dart';

import '../../config/pmp_colors.dart';
import '../../config/pmp_text_styles.dart';
import '../../shared_widgets/main_scaffold.dart';
import '../auth/widgets/auth_text_field.dart';

class UpdateNamePage extends StatefulWidget {
  const UpdateNamePage({super.key});

  @override
  State<UpdateNamePage> createState() => _UpdateNamePageState();
}

class _UpdateNamePageState extends State<UpdateNamePage> {
  late final TextEditingController _nameController;
  bool isComplete = true;
  @override
  void initState() {
    super.initState();
    _nameController =
        TextEditingController(text: sl<ValueNotifier<AppUser>>().value.name);
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(),
      child: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          state.maybeWhen(
            onSuccess: () {
              Navigator.pop(context, true);
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          final isLoading = state.maybeWhen(
            loading: () => true,
            orElse: () => false,
          );
          return MainScaffold(
              appBar: AppBar(
                title: const Text('Update Name'),
              ),
              body: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    AuthTextField(
                      controller: _nameController,
                      labelText: 'Name',
                      textCapitalization: TextCapitalization.words,
                      textInputAction: TextInputAction.next,
                      fillColor: const Color(0xFF203A43),
                      textColor: Colors.white,
                      cursorColor: Colors.white,
                      onChanged: (value) => {
                        setState(() {
                          isComplete = value.isNotEmpty;
                        })
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Name is required';
                        }
                        if (value.length < 2) {
                          return 'Name must be at least 2 characters';
                        }
                        return null;
                      },
                    ),
                    const Spacer(),
                    InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {
                        if (_nameController.text.isEmpty) {
                          showErrorSnackbar('Name is required');
                          return;
                        }
                        if (_nameController.text ==
                            sl<ValueNotifier<AppUser>>().value.name) {
                          showErrorSnackbar('Name is not changed');
                          return;
                        }
                        context.read<UserBloc>().add(
                            UserEvent.updateUserName(_nameController.text));
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      child: Container(
                        width: double.infinity,
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: isComplete
                              ? const LinearGradient(
                                  colors: [
                                    Color(0xFF00C6FF),
                                    Color(0xFF0072FF)
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                )
                              : LinearGradient(
                                  colors: [
                                    PmpColors.primary400.withValues(alpha: 0.6),
                                    PmpColors.primary400.withValues(alpha: 0.4),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                          boxShadow: isComplete
                              ? [
                                  BoxShadow(
                                    color: Colors.blue.withValues(alpha: 0.3),
                                    blurRadius: 6,
                                    spreadRadius: 1,
                                    offset: const Offset(0, 3),
                                  )
                                ]
                              : [],
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
                  ],
                ),
              ));
        },
      ),
    );
  }
}
