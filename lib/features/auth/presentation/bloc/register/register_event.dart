import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SubmitRegister extends RegisterEvent {
  final String nome;
  final String senha;
  final String confirmarSenha;

  SubmitRegister({
    required this.nome,
    required this.senha,
    required this.confirmarSenha,
  });

  @override
  List<Object> get props => [nome, senha, confirmarSenha];
}
