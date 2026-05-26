import 'package:aitek_task/core/di/service_locator.dart';
import 'package:aitek_task/core/network/api_endpoints.dart';
import 'package:aitek_task/core/network/dio_client.dart';
import 'package:aitek_task/core/utils/logger.dart';
import 'package:aitek_task/feature/partner_signal_archive/data/data_sources/partner_signal_archive_remote_data_source.dart';
import 'package:aitek_task/feature/partner_signal_archive/data/models/invalid_signal_request_model.dart';
import 'package:aitek_task/feature/partner_signal_archive/data/models/trading_signal_request_model.dart';
import 'package:aitek_task/feature/partner_signal_archive/domain/entities/trading_signal_request_params.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class PartnerSignalArchiveRemoteDataSourceImpl extends PartnerSignalArchiveRemoteDataSource {
  @override
  Future<Either<InvalidSignalRequestModel, List<TradingSignalModel>>> getAnalyticSignals(TradingSignalRequestParams params) async {
    try {
      final response = await sl<DioClient>().get(
        '${ApiEndpoints.getAnalyticSignals}/${params.login}',
        queryParameters: params.toQueryParameters(),
        options: Options(headers: {'passkey': params.partnerToken}),
        baseUrl: ApiEndpoints.partnerClientMobileBaseUrl,
      );

      if (response.data is! List) {
        return Left(InvalidSignalRequestModel(message: 'Invalid signal list'));
      }

      return Right(TradingSignalModel.fromJsonList(response.data));
    } on NetworkException catch (e) {
      logger.w(
        'Network error in getAnalyticSignals '
        '(Status: ${e.statusCode}): ${e.message}\nResponse Data: ${e.responseData}',
      );

      return Left(_parseError(e));
    } catch (e, stackTrace) {
      logger.e('Unexpected exception in getAnalyticSignals', error: e, stackTrace: stackTrace);

      return Left(InvalidSignalRequestModel(message: e.toString()));
    }
  }

  InvalidSignalRequestModel _parseError(NetworkException error) {
    final responseData = error.responseData;

    if (responseData is Map<String, dynamic>) {
      final model = InvalidSignalRequestModel.fromJson(responseData);
      return InvalidSignalRequestModel(message: model.message ?? error.message);
    }

    if (responseData is String && responseData.trim().isNotEmpty) {
      return InvalidSignalRequestModel(message: responseData);
    }

    return InvalidSignalRequestModel(message: error.message);
  }
}
