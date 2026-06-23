import 'package:flutter/material.dart';
import 'package:speakcraft/shared_widgets/glass.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speakcraft/bloc/user_bloc/user_bloc.dart';
import 'package:speakcraft/config/common_extensions.dart';
import 'package:speakcraft/core/di/service_locator.dart';
import 'package:speakcraft/model/app_user/app_user.dart';

import '../auth/widgets/auth_text_field.dart';

class UpdateNamePage extends StatefulWidget {
  const UpdateNamePage({super.key});

  @override
  State<UpdateNamePage> createState() => _UpdateNamePageState();
}

class _UpdateNamePageState extends State<UpdateNamePage> {
  late final TextEditingController _nameController;

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
          return Scaffold(
            appBar: AppBar(
              leading: const Padding(
                  padding: EdgeInsets.only(left: 8), child: GlassBackButton()),
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
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: FilledButton(
                      onPressed: isLoading
                          ? null
                          : () {
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
                                  UserEvent.updateUserName(
                                      _nameController.text));
                              FocusManager.instance.primaryFocus?.unfocus();
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
