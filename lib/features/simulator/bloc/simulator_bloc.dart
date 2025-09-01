import 'package:flutter_bloc/flutter_bloc.dart';
import 'simulator_event.dart';
import 'simulator_state.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SimulatorBloc extends Bloc<SimulatorEvent, SimulatorState> {
  final http.Client client;

  SimulatorBloc(this.client) : super(SimulatorInitial()) {
    on<FetchBalance>((event, emit) async {
      emit(SimulatorLoading());
      try {
        final response = await client.get(
          Uri.parse("${dotenv.get('API_URL')}/user/get_by_name/${event.username}"),
          headers: {"Content-Type": "application/json"},
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          final balance = data["Result"]["balance"] as num; // pode ser double ou int
          emit(SimulatorLoaded(balance.toDouble()));
        } else {
          emit(SimulatorError("Erro ao buscar balance"));
        }
      } catch (e) {
        emit(SimulatorError("Erro: ${e.toString()}"));
      }
    });
  }
}