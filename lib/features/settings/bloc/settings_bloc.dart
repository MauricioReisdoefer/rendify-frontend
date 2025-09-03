import 'package:flutter_bloc/flutter_bloc.dart';
import 'settings_event.dart';
import 'settings_state.dart';
import 'settings_repository.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository settingsRepository;

  SettingsBloc(this.settingsRepository) : super(SettingsInitial()) {
    on<ChangeBalanceEvent>((event, emit) async {
      emit(SettingsLoading());
      try {
        final user = await settingsRepository.changeBalance(
            event.newBalance);
        emit(SettingsSuccess(user, "Saldo atualizado com sucesso"));
      } catch (e) {
        emit(SettingsError("Seu saldo não pôde ser atualizado"));
      }
    });
  }
}