// ignore_for_file: non_constant_identifier_names

part of 'user_bloc.dart';

@immutable
abstract class UserState extends Equatable {}

class UserLoadingState extends UserState {
  @override
  List<Object?> get props => [];
}

class UserLoadedState extends UserState {
  final AddUser User;

  UserLoadedState(this.User);

  @override
  List<Object?> get props => [User];
}

class UserErrorState extends UserState {
  final String error;

  UserErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

class UserInitial extends UserState {
  @override
  List<Object?> get props => [];
}
