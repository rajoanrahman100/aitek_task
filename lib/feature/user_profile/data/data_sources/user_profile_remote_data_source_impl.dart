import 'package:aitek_task/core/di/service_locator.dart';
import 'package:aitek_task/core/network/api_endpoints.dart';
import 'package:aitek_task/core/network/dio_client.dart';
import 'package:aitek_task/core/utils/logger.dart';
import 'package:aitek_task/feature/user_profile/data/data_sources/user_profile_remote_data_source.dart';
import 'package:aitek_task/feature/user_profile/data/models/user_information_error_model.dart';
import 'package:aitek_task/feature/user_profile/data/models/user_information_response_model.dart';
import 'package:aitek_task/feature/user_profile/domain/entities/user_information_request_params.dart';
import 'package:dartz/dartz.dart';

class UserProfileRemoteDataSourceImpl extends UserProfileRemoteDataSource {
  @override
  Future<Either<UserInformationErrorModel, UserInformationResponseModel>> getAccountInformation(UserInformationRequestParams params) async {
    try {
      final response = await sl<DioClient>().post(
        ApiEndpoints.getAccountInformation,
        data: params.toMap(),
        baseUrl: ApiEndpoints.peanutBaseUrl,
      );

      if (response.data is! Map<String, dynamic>) {
        return const Left(UserInformationErrorModel(message: 'Invalid profile response'));
      }

      return Right(UserInformationResponseModel.fromJson(response.data));
    } on NetworkException catch (e) {
      logger.w(
        'Network error in getAccountInformation '
        '(Status: ${e.statusCode}): ${e.message}\nResponse Data: ${e.responseData}',
      );

      return Left(UserInformationErrorModel(message: _messageFromError(e), status: e.statusCode));
    } catch (e, stackTrace) {
      logger.e('Unexpected exception in getAccountInformation', error: e, stackTrace: stackTrace);

      return Left(UserInformationErrorModel(message: e.toString()));
    }
  }

  String _messageFromError(NetworkException error) {
    if (error.statusCode == 500 && error.responseData?.toString().trim() == 'Access Denied') {
      return 'Access Denied';
    }

    if (error.responseData is String && error.responseData.toString().trim().isNotEmpty) {
      return error.responseData.toString();
    }

    return error.message;
  }
}
