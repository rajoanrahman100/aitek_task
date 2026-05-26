import 'package:aitek_task/core/di/service_locator.dart';
import 'package:aitek_task/core/network/api_endpoints.dart';
import 'package:aitek_task/core/network/dio_client.dart';
import 'package:aitek_task/core/utils/logger.dart';
import 'package:aitek_task/feature/authentication/peanut_service/data/data_source/auth_api_service.dart';
import 'package:aitek_task/feature/authentication/peanut_service/data/models/account_credential_error_response_model.dart';
import 'package:aitek_task/feature/authentication/peanut_service/data/models/account_credential_response_model.dart';
import 'package:aitek_task/feature/authentication/peanut_service/domain/request_param/login_request_params.dart';
import 'package:dartz/dartz.dart';

class AuthApiServiceImpl extends AuthApiService {
  @override
  Future<Either<AccountCredentialErrorResponseModel, AccountCredentialResponseModel>> peanutServiceLogin(LoginReqParams params) async {
    try {
      final response = await sl<DioClient>().post(
        ApiEndpoints.isAccountCredentialsCorrect,
        data: params.toMap(),
        baseUrl: ApiEndpoints.peanutBaseUrl,
      );

      // Status 200: Success authentication
      return Right(AccountCredentialResponseModel.fromJson(response.data));
    } on NetworkException catch (e) {
      logger.w("Network error in peanutServiceLogin (Status: ${e.statusCode}): ${e.message}\nResponse Data: ${e.responseData}");
      if (e.statusCode == 401 && e.responseData != null) {
        // Status 401: Unauthorized (Incorrect credentials), return response model
        return Right(AccountCredentialResponseModel.fromJson(e.responseData));
      } else if (e.statusCode == 400 && e.responseData != null) {
        // Status 400: Validation error, return validation error response model
        return Left(AccountCredentialErrorResponseModel.fromJson(e.responseData));
      } else {
        // Other NetworkException (timeout, 500, etc.)
        return Left(
          AccountCredentialErrorResponseModel(
            title: e.message,
            status: e.statusCode,
            errors: Errors(login: [e.message]),
          ),
        );
      }
    } catch (e, stackTrace) {
      logger.e("Unexpected exception in peanutServiceLogin", error: e, stackTrace: stackTrace);
      // General error
      return Left(
        AccountCredentialErrorResponseModel(
          title: "Unexpected error: ${e.toString()}",
          errors: Errors(login: [e.toString()]),
        ),
      );
    }
  }
}
