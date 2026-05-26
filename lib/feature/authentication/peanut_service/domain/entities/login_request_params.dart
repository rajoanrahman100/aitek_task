class LoginReqParams {
  final int login;
  final String password;

  LoginReqParams({required this.login, required this.password});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'login': login, 'password': password, };
  }
}
