import 'package:aitek_task/core/di/service_locator.dart';
import 'package:aitek_task/core/di/use_case.dart';
import 'package:aitek_task/feature/user_profile/data/models/user_information_error_model.dart';
import 'package:aitek_task/feature/user_profile/data/models/user_information_response_model.dart';
import 'package:aitek_task/feature/user_profile/domain/entities/user_information_request_params.dart';
import 'package:aitek_task/feature/user_profile/domain/repositories/user_profile_repository.dart';
import 'package:dartz/dartz.dart';

class GetAccountInformationUseCase
    extends
        UseCase<
          Either<UserInformationErrorModel, UserInformationResponseModel>,
          UserInformationRequestParams
        > {
  @override
  Future<Either<UserInformationErrorModel, UserInformationResponseModel>> call({
    UserInformationRequestParams? params,
  }) async {
    return await sl<UserProfileRepository>().getAccountInformation(params!);
  }
}
