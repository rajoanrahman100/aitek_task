class PartnerTokenResponseModel {
  const PartnerTokenResponseModel({this.token});

  final String? token;

  bool get hasToken => token != null && token!.trim().isNotEmpty;

  factory PartnerTokenResponseModel.fromJson(dynamic json) {
    if (json is String) {
      return PartnerTokenResponseModel(token: json);
    }

    if (json is Map<String, dynamic>) {
      final token = json['token'] ?? json['Token'];
      return PartnerTokenResponseModel(token: token?.toString());
    }

    return const PartnerTokenResponseModel();
  }

  Map<String, dynamic> toJson() => {'token': token};
}
