import 'package:aitek_task/feature/user_profile/data/models/user_information_error_model.dart';
import 'package:aitek_task/feature/user_profile/data/models/user_information_response_model.dart';
import 'package:aitek_task/feature/user_profile/domain/entities/user_information_request_params.dart';
import 'package:dartz/dartz.dart';

abstract class UserProfileRemoteDataSource {
  Future<Either<UserInformationErrorModel, UserInformationResponseModel>> getAccountInformation(UserInformationRequestParams params);

  Future<Either<UserInformationErrorModel, String>> getLastFourPhoneNumber(UserInformationRequestParams params);
}
