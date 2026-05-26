class UserInformationResponseModel {
  final String? address;
  final int? balance;
  final String? city;
  final String? country;
  final int? currency;
  final int? currentTradesCount;
  final int? currentTradesVolume;
  final int? equity;
  final int? freeMargin;
  final bool? isAnyOpenTrades;
  final bool? isSwapFree;
  final int? leverage;
  final String? name;
  final String? phone;
  final int? totalTradesCount;
  final int? totalTradesVolume;
  final int? type;
  final int? verificationLevel;
  final String? zipCode;

  UserInformationResponseModel({
    this.address,
    this.balance,
    this.city,
    this.country,
    this.currency,
    this.currentTradesCount,
    this.currentTradesVolume,
    this.equity,
    this.freeMargin,
    this.isAnyOpenTrades,
    this.isSwapFree,
    this.leverage,
    this.name,
    this.phone,
    this.totalTradesCount,
    this.totalTradesVolume,
    this.type,
    this.verificationLevel,
    this.zipCode,
  });

  factory UserInformationResponseModel.fromJson(Map<String, dynamic> json) =>
      UserInformationResponseModel(
        address: json['address'] is String ? json['address'] : null,
        balance: json['balance'] is int ? json['balance'] : null,
        city: json['city'] is String ? json['city'] : null,
        country: json['country'] is String ? json['country'] : null,
        currency: json['currency'] is int ? json['currency'] : null,
        currentTradesCount: json['currentTradesCount'] is int
            ? json['currentTradesCount']
            : null,
        currentTradesVolume: json['currentTradesVolume'] is int
            ? json['currentTradesVolume']
            : null,
        equity: json['equity'] is int ? json['equity'] : null,
        freeMargin: json['freeMargin'] is int ? json['freeMargin'] : null,
        isAnyOpenTrades: json['isAnyOpenTrades'] is bool
            ? json['isAnyOpenTrades']
            : null,
        isSwapFree: json['isSwapFree'] is bool ? json['isSwapFree'] : null,
        leverage: json['leverage'] is int ? json['leverage'] : null,
        name: json['name'] is String ? json['name'] : null,
        phone: json['phone'] is String ? json['phone'] : null,
        totalTradesCount: json['totalTradesCount'] is int
            ? json['totalTradesCount']
            : null,
        totalTradesVolume: json['totalTradesVolume'] is int
            ? json['totalTradesVolume']
            : null,
        type: json['type'] is int ? json['type'] : null,
        verificationLevel: json['verificationLevel'] is int
            ? json['verificationLevel']
            : null,
        zipCode: json['zipCode'] is String ? json['zipCode'] : null,
      );

  Map<String, dynamic> toJson() => {
    'address': address,
    'balance': balance,
    'city': city,
    'country': country,
    'currency': currency,
    'currentTradesCount': currentTradesCount,
    'currentTradesVolume': currentTradesVolume,
    'equity': equity,
    'freeMargin': freeMargin,
    'isAnyOpenTrades': isAnyOpenTrades,
    'isSwapFree': isSwapFree,
    'leverage': leverage,
    'name': name,
    'phone': phone,
    'totalTradesCount': totalTradesCount,
    'totalTradesVolume': totalTradesVolume,
    'type': type,
    'verificationLevel': verificationLevel,
    'zipCode': zipCode,
  };
}
