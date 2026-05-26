import 'package:aitek_task/feature/user_profile/data/models/user_information_response_model.dart';
import 'package:equatable/equatable.dart';

abstract class UserProfileState extends Equatable {
  const UserProfileState();

  @override
  List<Object?> get props => [];
}

class UserProfileInitial extends UserProfileState {}

class UserProfileLoading extends UserProfileState {}

class UserProfileSuccess extends UserProfileState {
  const UserProfileSuccess({
    required this.userInformation,
    required this.lastFourPhoneNumber,
  });

  final UserInformationResponseModel userInformation;
  final String lastFourPhoneNumber;

  @override
  List<Object?> get props => [userInformation, lastFourPhoneNumber];
}

class UserProfileFailure extends UserProfileState {
  const UserProfileFailure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
