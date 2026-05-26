import 'package:aitek_task/core/di/service_locator.dart';
import 'package:aitek_task/feature/authentication/peanut_service/data/models/account_credential_error_response_model.dart';
import 'package:aitek_task/feature/authentication/peanut_service/data/models/account_credential_response_model.dart';
import 'package:aitek_task/feature/authentication/peanut_service/domain/request_param/login_request_params.dart';

import 'package:dartz/dartz.dart';

import '../../data/repositories/auth_repository_impl.dart';

abstract class AuthRepository {
  Future<Either<AccountCredentialErrorResponseModel, AccountCredentialResponseModel>> peanutServiceLogin(LoginReqParams params);
}

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either<AccountCredentialErrorResponseModel, AccountCredentialResponseModel>> peanutServiceLogin(LoginReqParams params) async {
    // TODO: implement peanutServiceLogin
    return await sl<AuthApiServiceImpl>().peanutServiceLogin(params);
  }
}
