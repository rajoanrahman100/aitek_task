class InvalidSignalRequestModel {
  String? message;

  InvalidSignalRequestModel({this.message});

  factory InvalidSignalRequestModel.fromJson(Map<String, dynamic> json) =>
      InvalidSignalRequestModel(message: json["Message"]);

  Map<String, dynamic> toJson() => {"Message": message};
}
