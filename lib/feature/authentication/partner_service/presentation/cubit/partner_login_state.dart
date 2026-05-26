import 'package:aitek_task/feature/authentication/partner_service/data/models/partner_token_response_model.dart';
import 'package:equatable/equatable.dart';

abstract class PartnerLoginState extends Equatable {
  const PartnerLoginState();

  @override
  List<Object?> get props => [];
}

class PartnerLoginInitial extends PartnerLoginState {}

class PartnerLoginLoading extends PartnerLoginState {}

class PartnerLoginSuccess extends PartnerLoginState {
  const PartnerLoginSuccess(this.response);

  final PartnerTokenResponseModel response;

  @override
  List<Object?> get props => [response];
}

class PartnerLoginFailure extends PartnerLoginState {
  const PartnerLoginFailure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
