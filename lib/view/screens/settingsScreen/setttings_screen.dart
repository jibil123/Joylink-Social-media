import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joylink/model/bloc/authBloc/bloc/auth_bloc.dart';
import 'package:joylink/view/screens/authScreen/mainLoginScreen/login_screen.dart';
import 'package:joylink/view/screens/settingsScreen/custom_settings_widget.dart';
import 'package:joylink/view/screens/widgets/custom_alert_dialog.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
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
                                    builder: (_) => const LoginScreenWrapper()),
                                (route) => false,
                              );
                            }, childName: 'yes',));
                  }),
              const SizedBox(height: 10),
            ],
          ),
        ));
  }
}
