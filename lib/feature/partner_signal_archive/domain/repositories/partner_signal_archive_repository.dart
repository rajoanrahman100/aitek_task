import 'package:aitek_task/feature/partner_signal_archive/data/models/invalid_signal_request_model.dart';
import 'package:aitek_task/feature/partner_signal_archive/data/models/trading_signal_request_model.dart';
import 'package:aitek_task/feature/partner_signal_archive/domain/entities/trading_signal_request_params.dart';
import 'package:dartz/dartz.dart';

abstract class PartnerSignalArchiveRepository {
  Future<Either<InvalidSignalRequestModel, List<TradingSignalModel>>> getAnalyticSignals(TradingSignalRequestParams params);
}
