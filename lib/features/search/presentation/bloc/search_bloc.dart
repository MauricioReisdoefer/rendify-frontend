import 'package:flutter_bloc/flutter_bloc.dart';
import 'search_event.dart';
import 'search_state.dart';
import 'package:rendify/features/auth/data/repositories/auth_repository_imp.dart';
import 'package:rendify/core/models/user_model.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final AuthRepositoryImpl authRepository;

  SearchBloc({required this.authRepository}) : super(SearchState.initial()){
    on<SearchChanged>((event, emit) {
      emit(state.copyWith(name: event.name));
    });

    on<SearchSubmitted>((event, emit) async {
      emit(state.copyWith(isSubmitting: true, isFailure: false, isSuccess: false));
      try {
        final UserModel user = await authRepository.login(
          event.name, 
          event.password,
        );

        emit(state.copyWith(isSubmitting: false, isSuccess: true));
      } catch (e) {
        emit(state.copyWith(isSubmitting: false, isFailure: true));
      }
    });
  }
}