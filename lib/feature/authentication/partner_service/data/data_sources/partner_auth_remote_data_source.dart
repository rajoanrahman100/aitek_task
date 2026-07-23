import 'package:aitek_task/feature/authentication/partner_service/data/models/partner_token_error_model.dart';
import 'package:aitek_task/feature/authentication/partner_service/data/models/partner_token_response_model.dart';
import 'package:aitek_task/feature/authentication/partner_service/domain/entities/partner_login_request_params.dart';
import 'package:dartz/dartz.dart';

abstract class PartnerAuthRemoteDataSource {
  Future<Either<PartnerTokenErrorModel, PartnerTokenResponseModel>> requestMobileCabinetApiToken(PartnerLoginRequestParams params);
}
