class UserInformationRequestParams {
  const UserInformationRequestParams({
    required this.login,
    required this.token,
  });

  final int login;
  final String token;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'login': login, 'token': token};
  }
}
