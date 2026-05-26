class TradingSignalRequestParams {
  const TradingSignalRequestParams({
    required this.login,
    required this.partnerToken,
    required this.pairs,
    required this.from,
    required this.to,
    this.tradingSystem = 3,
  });

  final int login;
  final String partnerToken;
  final List<String> pairs;
  final DateTime from;
  final DateTime to;
  final int tradingSystem;

  Map<String, dynamic> toQueryParameters() {
    return <String, dynamic>{
      'tradingsystem': tradingSystem,
      'pairs': pairs.join(','),
      'from': from.millisecondsSinceEpoch ~/ 1000,
      'to': to.millisecondsSinceEpoch ~/ 1000,
    };
  }
}
