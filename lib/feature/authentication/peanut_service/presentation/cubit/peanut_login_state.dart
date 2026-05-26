import 'package:equatable/equatable.dart';
import 'package:aitek_task/feature/authentication/peanut_service/data/models/account_credential_response_model.dart';

abstract class PeanutLoginState extends Equatable {
  const PeanutLoginState();

  @override
  List<Object?> get props => [];
}

class PeanutLoginInitial extends PeanutLoginState {}

class PeanutLoginLoading extends PeanutLoginState {}

class PeanutLoginSuccess extends PeanutLoginState {
  final AccountCredentialResponseModel response;

  const PeanutLoginSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class PeanutLoginFailure extends PeanutLoginState {
  final String message;

  const PeanutLoginFailure(this.message);

  @override
  List<Object?> get props => [message];
}