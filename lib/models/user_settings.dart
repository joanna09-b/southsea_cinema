class UserSettings {
  final String name;
  final String email;
  final String phoneNumber;
  final bool receiveNewsletters;

  const UserSettings({
    this.name = '',
    this.email = '',
    this.phoneNumber = '',
    this.receiveNewsletters = false,
  });
}
