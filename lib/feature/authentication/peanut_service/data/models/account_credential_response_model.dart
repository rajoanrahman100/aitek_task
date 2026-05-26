class AccountCredentialResponseModel {
  bool? result;
  String? token;

  AccountCredentialResponseModel({this.result, this.token});

  factory AccountCredentialResponseModel.fromJson(Map<String, dynamic> json) =>
      AccountCredentialResponseModel(result: json["result"], token: json["token"]);

  Map<String, dynamic> toJson() => {"result": result, "token": token};
}
