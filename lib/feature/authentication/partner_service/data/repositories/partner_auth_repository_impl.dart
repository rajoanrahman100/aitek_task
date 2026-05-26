import 'package:aitek_task/core/di/service_locator.dart';
import 'package:aitek_task/feature/authentication/partner_service/data/data_sources/partner_auth_remote_data_source.dart';
import 'package:aitek_task/feature/authentication/partner_service/data/models/partner_token_error_model.dart';
import 'package:aitek_task/feature/authentication/partner_service/data/models/partner_token_response_model.dart';
import 'package:aitek_task/feature/authentication/partner_service/domain/entities/partner_login_request_params.dart';
import 'package:aitek_task/feature/authentication/partner_service/domain/repositories/partner_auth_repository.dart';
import 'package:dartz/dartz.dart';

class PartnerAuthRepositoryImpl extends PartnerAuthRepository {
  @override
  Future<Either<PartnerTokenErrorModel, PartnerTokenResponseModel>>
  requestMobileCabinetApiToken(PartnerLoginRequestParams params) async {
    return await sl<PartnerAuthRemoteDataSource>().requestMobileCabinetApiToken(
      params,
    );
  }
}
