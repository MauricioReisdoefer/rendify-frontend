import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/gestures.dart';
import 'package:rendify/features/settings/bloc/settings_repository.dart';
import 'package:rendify/to-do/screens/duvidas_screen.dart';
import 'package:rendify/to-do/screens/main_screen.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:http/http.dart' as http;

import '../bloc/settings_bloc.dart';
import '../bloc/settings_event.dart';
import '../bloc/settings_state.dart';

class SettingsScreen extends StatelessWidget {
  final String balance;
  late final TextEditingController balanceController;

  SettingsScreen(this.balance, {super.key}) {
    balanceController = TextEditingController(text: balance);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SettingsBloc(SettingsRepository(http.Client())),
      child: BlocConsumer<SettingsBloc, SettingsState>(
        listener: (context, state) {
          if (state is SettingsSuccess) {
            balanceController.text =
                'R\$ ${state.user.balance.toStringAsFixed(2)}';
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Balance updated successfully".tr())),
            );
          } else if (state is SettingsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: ListView(
              padding: EdgeInsets.all(20.0),
              children: [
                Text(
                  "Bem-vindo às Configurações, Cliente".tr(),
                  style: GoogleFonts.poppins(fontSize: 20),
                ),
                SizedBox(height: 10),
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.poppins(color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(text: 'Para acessar saber mais, clique em'.tr()),
                      TextSpan(
                        text: '\nDúvidas'.tr(),
                        style: GoogleFonts.poppins(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainScreen(
                                        body: DuvidasFrequentesPage(),
                                      )),
                            );
                          },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Text("Mudar Saldo".tr(),
                    style: GoogleFonts.poppins(fontSize: 20)),
                SizedBox(height: 10),
                Text("Digite a quantidade desejada na área \nabaixo".tr()),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: <Color>[
                        Color(0xff225DC2),
                        Color(0xff5F72D9),
                      ],
                    ),
                  ),
                  child: TextField(
                    inputFormatters: [
                      CurrencyTextInputFormatter.currency(symbol: 'R\$')
                    ],
                    controller: balanceController,
                    decoration: InputDecoration(
                      hintText: 'R\$ 0,00',
                      hintStyle: GoogleFonts.poppins(color: Colors.white),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                    style: GoogleFonts.poppins(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: <Color>[
                        Color(0xff225DC2),
                        Color(0xff5F72D9),
                      ],
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      if (balanceController.text.isNotEmpty) {
                        final bloc = context.read<SettingsBloc>();
                        bloc.add(ChangeBalanceEvent(
                            userId: 1,
                            newBalance: double.parse(balanceController.text
                                .replaceAll("R\$", "")
                                .replaceAll(".", "")
                                .replaceAll(",", ".")
                                .replaceAll(" ", ""))));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                                  Text("Saldo atualizado com sucesso".tr())),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text("Digite o saldo desejado".tr())),
                        );
                      }
                    },
                    child: Text("Salvar".tr(),
                        style: GoogleFonts.poppins(
                            color: Colors.white, fontSize: 20)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      overlayColor: Colors.transparent,
                      minimumSize: Size(1, 55),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text("Reiniciar Simulação".tr(),
                    style: GoogleFonts.poppins(fontSize: 20)),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: <Color>[
                        Color(0xff225DC2),
                        Color(0xff5F72D9),
                      ],
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      print("Clicou");
                    },
                    child: Text("Reiniciar".tr(),
                        style: GoogleFonts.poppins(
                            color: Colors.white, fontSize: 20)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      overlayColor: Colors.transparent,
                      minimumSize: Size(1, 55),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text("Mudar Idioma".tr(),
                    style: GoogleFonts.poppins(fontSize: 20)),
                SizedBox(height: 10),
                Text("Selecione o idioma desejado na área \nabaixo".tr()),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: <Color>[
                        Color(0xff225DC2),
                        Color(0xff5F72D9),
                      ],
                    ),
                  ),
                  child: DropdownButton<Locale>(
                    value: context.locale,
                    items: const [
                      DropdownMenuItem(
                          child: Text(" Português"), value: Locale('pt', 'BR')),
                      DropdownMenuItem(
                          child: Text(" English"), value: Locale('en', 'US')),
                      DropdownMenuItem(
                          child: Text(" Español"), value: Locale('es', 'MEX')),
                    ],
                    style:
                        GoogleFonts.poppins(color: Colors.white, fontSize: 20),
                    iconSize: 0,
                    underline: SizedBox(),
                    dropdownColor: Color(0xff225DC2),
                    onChanged: (Locale? newLocale) {
                      if (newLocale != null) {
                        context.setLocale(newLocale);
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MainScreen(body: SettingsScreen(balance)),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
