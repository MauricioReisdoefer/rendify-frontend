import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; 
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rendify/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:rendify/features/auth/presentation/bloc/login/login_event.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController nomeController;
  final TextEditingController senhaController;

  const LoginPage({
    super.key,
    required this.nomeController,
    required this.senhaController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Nome".tr(), style: GoogleFonts.poppins(fontSize: 17)),
        TextField(
          controller: nomeController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide.none),
            filled: true,
            fillColor: Color(0xFFCACACA),
          ),
          onChanged: (value) {
            context.read<LoginBloc>().add(LoginNameChanged(value));
          },
        ),
        const SizedBox(height: 15),
        Text("Senha".tr(), style: GoogleFonts.poppins(fontSize: 17)),
        TextField(
          controller: senhaController,
          obscureText: true,
          decoration: const InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide.none),
            filled: true,
            fillColor: Color(0xFFCACACA),
          ),
          onChanged: (value) {
            context.read<LoginBloc>().add(LoginPasswordChanged(value));
          },
        ),
      ],
    );
  }
}
