import 'package:aitek_task/core/di/service_locator.dart';
import 'package:aitek_task/core/di/use_case.dart';
import 'package:aitek_task/feature/partner_signal_archive/data/models/invalid_signal_request_model.dart';
import 'package:aitek_task/feature/partner_signal_archive/data/models/trading_signal_request_model.dart';
import 'package:aitek_task/feature/partner_signal_archive/domain/entities/trading_signal_request_params.dart';
import 'package:aitek_task/feature/partner_signal_archive/domain/repositories/partner_signal_archive_repository.dart';
import 'package:dartz/dartz.dart';

class GetAnalyticSignalsUseCase extends UseCase<Either<InvalidSignalRequestModel, List<TradingSignalModel>>, TradingSignalRequestParams> {
  @override
  Future<Either<InvalidSignalRequestModel, List<TradingSignalModel>>> call({TradingSignalRequestParams? params}) async {
    return await sl<PartnerSignalArchiveRepository>().getAnalyticSignals(params!);
  }
}
