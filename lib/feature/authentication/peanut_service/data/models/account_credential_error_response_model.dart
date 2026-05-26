class AccountCredentialErrorResponseModel {
  Errors? errors;
  String? type;
  String? title;
  int? status;
  String? traceId;

  AccountCredentialErrorResponseModel({
    this.errors,
    this.type,
    this.title,
    this.status,
    this.traceId,
  });

  factory AccountCredentialErrorResponseModel.fromJson(Map<String, dynamic> json) => AccountCredentialErrorResponseModel(
    errors: json["errors"] == null ? null : Errors.fromJson(json["errors"]),
    type: json["type"],
    title: json["title"],
    status: json["status"],
    traceId: json["traceId"],
  );

  Map<String, dynamic> toJson() => {
    "errors": errors?.toJson(),
    "type": type,
    "title": title,
    "status": status,
    "traceId": traceId,
  };
}

class Errors {
  List<String>? login;

  Errors({
    this.login,
  });

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
    login: json["login"] == null ? [] : List<String>.from(json["login"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "login": login == null ? [] : List<dynamic>.from(login!.map((x) => x)),
  };
}
