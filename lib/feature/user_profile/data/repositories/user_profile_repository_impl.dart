import 'package:aitek_task/core/di/service_locator.dart';
import 'package:aitek_task/feature/user_profile/data/data_sources/user_profile_remote_data_source.dart';
import 'package:aitek_task/feature/user_profile/data/models/user_information_error_model.dart';
import 'package:aitek_task/feature/user_profile/data/models/user_information_response_model.dart';
import 'package:aitek_task/feature/user_profile/domain/entities/user_information_request_params.dart';
import 'package:aitek_task/feature/user_profile/domain/repositories/user_profile_repository.dart';
import 'package:dartz/dartz.dart';

class UserProfileRepositoryImpl extends UserProfileRepository {
  @override
  Future<Either<UserInformationErrorModel, UserInformationResponseModel>> getAccountInformation(UserInformationRequestParams params) async {
    return await sl<UserProfileRemoteDataSource>().getAccountInformation(params);
  }
}
