// ignore_for_file: non_constant_identifier_names

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:red_red_group/model/service.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;

  UserBloc(this._userRepository) : super(UserInitial()) {
    on<UserEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        final User = await _userRepository.getUser();
        emit(UserLoadedState(User));
      } catch (e) {
        emit(UserErrorState(e.toString()));
      }
    });
  }
}
