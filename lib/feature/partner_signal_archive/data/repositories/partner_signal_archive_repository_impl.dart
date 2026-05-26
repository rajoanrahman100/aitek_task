import 'package:aitek_task/core/di/service_locator.dart';
import 'package:aitek_task/feature/partner_signal_archive/data/data_sources/partner_signal_archive_remote_data_source.dart';
import 'package:aitek_task/feature/partner_signal_archive/data/models/invalid_signal_request_model.dart';
import 'package:aitek_task/feature/partner_signal_archive/data/models/trading_signal_request_model.dart';
import 'package:aitek_task/feature/partner_signal_archive/domain/entities/trading_signal_request_params.dart';
import 'package:aitek_task/feature/partner_signal_archive/domain/repositories/partner_signal_archive_repository.dart';
import 'package:dartz/dartz.dart';

class PartnerSignalArchiveRepositoryImpl extends PartnerSignalArchiveRepository {
  @override
  Future<Either<InvalidSignalRequestModel, List<TradingSignalModel>>> getAnalyticSignals(TradingSignalRequestParams params) async {
    return await sl<PartnerSignalArchiveRemoteDataSource>().getAnalyticSignals(params);
  }
}
