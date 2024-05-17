import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joylink/model/bloc/authBloc/bloc/auth_bloc.dart';
import 'package:joylink/model/bloc/themeBloc/theme_bloc.dart';
import 'package:joylink/utils/colors.dart';
import 'package:joylink/view/screens/authScreen/mainLoginScreen/login_screen.dart';
import 'package:joylink/view/screens/settingsScreen/custom_settings_widget.dart';
import 'package:joylink/view/screens/widgets/custom_alert_dialog.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  // final bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final themeBloc = BlocProvider.of<ThemeBloc>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10,right: 20,left: 20),
          child: Column(
            children: [
              SettingsItem(
                  icon: Icons.privacy_tip_outlined,
                  text: 'Terms and conditions',
                  onTap: () {}),
              const SizedBox(height: 15),
              SettingsItem(
                  icon: Icons.private_connectivity,
                  text: 'Privacy and policy',
                  onTap: () {}),
              const SizedBox(height: 15),
              SettingsItem(icon: Icons.info, text: 'Info', onTap: () {}),
              const SizedBox(height: 15),
              SettingsItem(icon: Icons.share, text: 'Share', onTap: () {}),
              const SizedBox(height: 10),
              BlocBuilder<ThemeBloc, ThemeState>(
                builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      state.isSwitched
                          ? const Text(
                              'Change to dark mode',
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'ABeeZee',
                              ),
                            )
                          : const Text(
                              'Change to light mode',
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'ABeeZee',
                              ),
                            ),
                      Switch.adaptive(
                          activeColor: AppColors.primaryColor,
                          value: state.isSwitched,
                          onChanged: (bool value) {
                            if (value) {
                              themeBloc.add(DarkThemeEvent(isSwitched: value));
                            } else {
                              themeBloc.add(LightThemeEvent(isSwitched: value));
                            }
                          }),
                    ],
                  );
                },
              ),
              SettingsItem(
                  icon: Icons.logout,
                  text: 'Log out',
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => CustomAlertDialog(
                              title: "Log out",
                              message: 'are you sure?',
                              onOkPressed: () {
                                authBloc.add(LogoutEvent());
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          const LoginScreenWrapper()),
                                  (route) => false,
                                );
                              },
                              childName: 'yes',
                            ));
                  }),
              const SizedBox(height: 10),
            ],
          ),
        ));
  }
}
