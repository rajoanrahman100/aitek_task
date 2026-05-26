import 'package:aitek_task/core/di/service_locator.dart';
import 'package:aitek_task/core/di/use_case.dart';
import 'package:aitek_task/feature/authentication/peanut_service/domain/repositories/auth_repository.dart';

import 'package:dartz/dartz.dart';

import '../../data/models/account_credential_error_response_model.dart';
import '../../data/models/account_credential_response_model.dart';
import '../request_param/login_request_params.dart';

class PeanutServiceLoginUseCase
    extends UseCase<Either<AccountCredentialErrorResponseModel, AccountCredentialResponseModel>, LoginReqParams> {
  @override
  Future<Either<AccountCredentialErrorResponseModel, AccountCredentialResponseModel>> call({LoginReqParams? params}) async {
    return await sl<AuthRepository>().peanutServiceLogin(params!);
  }
}
