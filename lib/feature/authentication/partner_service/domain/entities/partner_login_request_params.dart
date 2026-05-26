class PartnerLoginRequestParams {
  const PartnerLoginRequestParams({
    required this.login,
    required this.password,
  });

  final int login;
  final String password;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'login': login, 'password': password};
  }
}
