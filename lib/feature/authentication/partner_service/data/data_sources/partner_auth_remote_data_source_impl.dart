import 'package:aitek_task/core/di/service_locator.dart';
import 'package:aitek_task/core/network/api_endpoints.dart';
import 'package:aitek_task/core/network/dio_client.dart';
import 'package:aitek_task/core/utils/logger.dart';
import 'package:aitek_task/feature/authentication/partner_service/data/data_sources/partner_auth_remote_data_source.dart';
import 'package:aitek_task/feature/authentication/partner_service/data/models/partner_token_error_model.dart';
import 'package:aitek_task/feature/authentication/partner_service/data/models/partner_token_response_model.dart';
import 'package:aitek_task/feature/authentication/partner_service/domain/entities/partner_login_request_params.dart';
import 'package:dartz/dartz.dart';

class PartnerAuthRemoteDataSourceImpl extends PartnerAuthRemoteDataSource {
  @override
  Future<Either<PartnerTokenErrorModel, PartnerTokenResponseModel>>
  requestMobileCabinetApiToken(PartnerLoginRequestParams params) async {
    try {
      final response = await sl<DioClient>().post(
        ApiEndpoints.requestMobileCabinetApiToken,
        data: params.toMap(),
        baseUrl: ApiEndpoints.partnerBaseUrl,
      );

      final tokenResponse = PartnerTokenResponseModel.fromJson(response.data);

      if (!tokenResponse.hasToken) {
        return const Left(
          PartnerTokenErrorModel(message: 'Authentication failed'),
        );
      }

      return Right(tokenResponse);
    } on NetworkException catch (e) {
      logger.w(
        'Network error in requestMobileCabinetApiToken '
        '(Status: ${e.statusCode}): ${e.message}\nResponse Data: ${e.responseData}',
      );

      return Left(
        PartnerTokenErrorModel(
          message: _messageForStatus(e.statusCode),
          status: e.statusCode,
        ),
      );
    } catch (e, stackTrace) {
      logger.e(
        'Unexpected exception in requestMobileCabinetApiToken',
        error: e,
        stackTrace: stackTrace,
      );

      return Left(PartnerTokenErrorModel(message: e.toString()));
    }
  }

  String _messageForStatus(int? statusCode) {
    switch (statusCode) {
      case 401:
        return 'Invalid login ID or password';
      case 404:
        return 'Partner authentication service was not found';
      default:
        return 'Authentication failed';
    }
  }
}
