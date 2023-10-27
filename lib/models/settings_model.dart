// ignore_for_file: public_member_api_docs, sort_constructors_first
class SettingsModel {
  final String text;
  final String iconPath;
  SettingsModel({
    required this.text,
    required this.iconPath,
  });
}

final List<SettingsModel> settingsList = [
  SettingsModel(
    text: 'Share app',
    iconPath: 'assets/icons/ok.png',
  ),
  SettingsModel(
    text: 'Rate us',
    iconPath: 'assets/icons/yıldız.png',
  ),
  SettingsModel(
    text: 'Contact us',
    iconPath: 'assets/icons/message.png',
  ),
  SettingsModel(
    text: 'Terms of service',
    iconPath: 'assets/icons/i.png',
  ),
  SettingsModel(
    text: 'Privacy policy',
    iconPath: 'assets/icons/eye.png',
  ),
];
