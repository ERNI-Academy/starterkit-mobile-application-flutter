class SetPasswordModel {
  SetPasswordModel({required this.password, required this.confirmPassword, this.code});

  final String password;
  final String confirmPassword;
  final String? code;
}
