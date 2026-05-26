import 'package:aitek_task/feature/authentication/peanut_service/data/models/account_credential_error_response_model.dart';
import 'package:aitek_task/feature/authentication/peanut_service/data/models/account_credential_response_model.dart';
import 'package:aitek_task/feature/authentication/peanut_service/domain/entities/login_request_params.dart';
import 'package:dartz/dartz.dart';

abstract class PeanutAuthRepository {
  Future<Either<AccountCredentialErrorResponseModel, AccountCredentialResponseModel>> peanutServiceLogin(LoginReqParams params);
}
