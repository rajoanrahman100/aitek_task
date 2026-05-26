import 'package:aitek_task/core/di/service_locator.dart';
import 'package:aitek_task/core/di/use_case.dart';
import 'package:aitek_task/feature/user_profile/data/models/user_information_error_model.dart';
import 'package:aitek_task/feature/user_profile/domain/entities/user_information_request_params.dart';
import 'package:aitek_task/feature/user_profile/domain/repositories/user_profile_repository.dart';
import 'package:dartz/dartz.dart';

class GetLastFourPhoneNumberUseCase extends UseCase<Either<UserInformationErrorModel, String>, UserInformationRequestParams> {
  @override
  Future<Either<UserInformationErrorModel, String>> call({UserInformationRequestParams? params}) async {
    return await sl<UserProfileRepository>().getLastFourPhoneNumber(params!);
  }
}
