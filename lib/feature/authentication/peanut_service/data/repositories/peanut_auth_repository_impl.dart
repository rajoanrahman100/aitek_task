import 'package:aitek_task/core/di/service_locator.dart';
import 'package:aitek_task/feature/authentication/peanut_service/data/data_sources/peanut_auth_remote_data_source.dart';
import 'package:aitek_task/feature/authentication/peanut_service/data/data_sources/peanut_auth_remote_data_source_impl.dart';
import 'package:aitek_task/feature/authentication/peanut_service/data/models/account_credential_error_response_model.dart';
import 'package:aitek_task/feature/authentication/peanut_service/data/models/account_credential_response_model.dart';
import 'package:aitek_task/feature/authentication/peanut_service/domain/entities/login_request_params.dart';
import 'package:aitek_task/feature/authentication/peanut_service/domain/repositories/peanut_auth_repository.dart';
import 'package:dartz/dartz.dart';

class PeanutAuthRepositoryImpl extends PeanutAuthRepository {
  @override
  Future<Either<AccountCredentialErrorResponseModel, AccountCredentialResponseModel>> peanutServiceLogin(LoginReqParams params) async {
    return await sl<PeanutAuthRemoteDataSourceImpl>().peanutServiceLogin(params);
  }
}
