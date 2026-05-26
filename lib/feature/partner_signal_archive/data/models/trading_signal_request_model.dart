class TradingSignalModel {
  final int? id;
  final int? actualTime;
  final String? comment;
  final String? pair;
  final int? cmd;
  final int? tradingSystem;
  final String? period;
  final double? price;
  final double? sl;
  final double? tp;

  TradingSignalModel({
    this.id,
    this.actualTime,
    this.comment,
    this.pair,
    this.cmd,
    this.tradingSystem,
    this.period,
    this.price,
    this.sl,
    this.tp,
  });

  factory TradingSignalModel.fromJson(Map<String, dynamic> json) =>
      TradingSignalModel(
        id: json['Id'] is int ? json['Id'] : null,
        actualTime: json['ActualTime'] is int ? json['ActualTime'] : null,
        comment: json['Comment'] is String ? json['Comment'] : null,
        pair: json['Pair'] is String ? json['Pair'] : null,
        cmd: json['Cmd'] is int ? json['Cmd'] : null,
        tradingSystem: json['TradingSystem'] is int
            ? json['TradingSystem']
            : null,
        period: json['Period'] is String ? json['Period'] : null,
        price: (json['Price'] as num?)?.toDouble(),
        sl: (json['Sl'] as num?)?.toDouble(),
        tp: (json['Tp'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
    'Id': id,
    'ActualTime': actualTime,
    'Comment': comment,
    'Pair': pair,
    'Cmd': cmd,
    'TradingSystem': tradingSystem,
    'Period': period,
    'Price': price,
    'Sl': sl,
    'Tp': tp,
  };

  /// Parse a JSON array directly into a list
  static List<TradingSignalModel> fromJsonList(List<dynamic> jsonList) =>
      jsonList
          .whereType<Map<String, dynamic>>()
          .map(TradingSignalModel.fromJson)
          .toList();

  @override
  String toString() =>
      'TradingSignalModel(id: $id, pair: $pair, cmd: $cmd, price: $price, sl: $sl, tp: $tp)';
}
