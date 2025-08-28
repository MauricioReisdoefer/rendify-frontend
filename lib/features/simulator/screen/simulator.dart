import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rendify/features/settings/screen/settings.dart';
import 'package:rendify/to-do/screens/purchase.dart';
import '../../../to-do/screens/main_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/simulator_bloc.dart';
import '../bloc/simulator_event.dart';
import '../bloc/simulator_state.dart';
import 'package:http/http.dart' as http;

class SimulatorScreen extends StatelessWidget {
  final int userId;
  final String username;

  SimulatorScreen({super.key, required this.userId, required this.username});

  List lista = ["Moeda 1", "Moeda 2", "Moeda 3", "Moeda 4", "Moeda 5"];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) =>
            SimulatorBloc(http.Client())..add(FetchBalance(username)),
        child: Scaffold(
          body: ListView(
            padding: EdgeInsets.all(20.0),
            children: [
              Text(
                "Bem-vindo ao Simulador, ".tr() + "$username",
                style: GoogleFonts.poppins(fontSize: 20),
              ),
              SizedBox(height: 20),
              BlocBuilder<SimulatorBloc, SimulatorState>(
                builder: (context, state) {
                  if (state is SimulatorLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is SimulatorLoaded) {
                    return Container(
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
                      height: 55,
                      child: Center(
                        child: Text(
                          "R\$${state.balance.toStringAsFixed(2)}",
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontSize: 20),
                        ),
                      ),
                    );
                  } else if (state is SimulatorError) {
                    return Text(
                      "Erro ao carregar seu saldo,\nTente novamente mais tarde"
                          .tr(),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(fontSize: 16),
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
              SizedBox(height: 20),
              Text("Suas ações".tr(), style: GoogleFonts.poppins(fontSize: 20)),
              SizedBox(
                height: 10,
              ),
              Container(
                  decoration: BoxDecoration(
                      color: Color(0xFFE5E5E5),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  height: 300,
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      RichText(
                          text: TextSpan(
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              children: <TextSpan>[
                            TextSpan(text: 'Total em estoque: '.tr()),
                            TextSpan(
                              text: 'R\$8301,10 ',
                              style: GoogleFonts.poppins(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: 'em '.tr()),
                            TextSpan(
                              text: '389 ações '.tr(),
                              style: GoogleFonts.poppins(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                          ])),
                      SizedBox(height: 10),
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title: Text(lista[index]),
                                subtitle: Text("MDA"),
                                trailing: Icon(Icons.search),
                                shape: BeveledRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              ),
                            );
                          },
                          itemCount: lista.length,
                        ),
                      ),
                    ],
                  )),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
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
                    child: BlocBuilder<SimulatorBloc, SimulatorState>(
                      builder: (context, state) {
                        if (state is SimulatorLoading) {
                          return Center(child: CircularProgressIndicator());
                        } else if (state is SimulatorLoaded) {
                          return ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MainScreen(
                                            userId: userId,
                                            username: username,
                                            body: SettingsScreen(
                                                username: username,
                                                userId: userId,
                                                "R\$${state.balance.toStringAsFixed(2)}"),
                                          )),
                                );
                              },
                              child: Text("Configurações".tr(),
                                  style: GoogleFonts.poppins(
                                      color: Colors.white, fontSize: 15)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                overlayColor: Colors.transparent,
                                minimumSize: Size(1, 70),
                              ));
                        } else if (state is SimulatorError) {
                          return ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MainScreen(
                                            userId: userId,
                                            username: username,
                                            body: SettingsScreen(
                                                username: username,
                                                userId: userId,
                                                "R\$ 0,00"),
                                          )),
                                );
                              },
                              child: Text("Configurações".tr(),
                                  style: GoogleFonts.poppins(
                                      color: Colors.white, fontSize: 15)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                overlayColor: Colors.transparent,
                                minimumSize: Size(1, 70),
                              ));
                        }
                        return SizedBox.shrink();
                      },
                    ),
                  ),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainScreen(
                                      body: StockPage(),
                                    )),
                          );
                        },
                        child: Text("Comprar ações".tr(),
                            style: GoogleFonts.poppins(
                                color: Colors.white, fontSize: 15)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          overlayColor: Colors.transparent,
                          minimumSize: Size(1, 70),
                        )),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
