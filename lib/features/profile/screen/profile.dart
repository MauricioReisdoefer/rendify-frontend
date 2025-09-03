import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            Text(
              "Meu Rendimento".tr(),
              style: GoogleFonts.poppins(fontSize: 20),
            ),
            Text.rich(
              TextSpan(
                text: 'Veja seu histórico ao longo dos últimos\n'.tr(),
                children: [
                  TextSpan(
                    text: '3 meses e 14 dias'.tr(),
                    onEnter: (event) {
                      print("Funciona");
                    },
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  TextSpan(text: ' (Desde da criação de sua conta)'.tr())
                ],
              ),
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "Seu Saldo Atual".tr(),
              style: GoogleFonts.poppins(fontSize: 20),
              textAlign: TextAlign.center,
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
              height: 55,
              child: Center(
                child: Text(
                  "R\$ A fazer",
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "Seu Estoque Atual".tr(),
              style: GoogleFonts.poppins(fontSize: 20),
              textAlign: TextAlign.center,
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
              height: 55,
              child: Center(
                child: Text(
                  "R\$ A fazer",
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Text.rich(
              TextSpan(
                  text: 'Lucros'.tr(),
                  style: GoogleFonts.poppins(color: Color(0xFF3C883C)),
                  children: [
                    TextSpan(
                        text: '/'.tr(),
                        style: GoogleFonts.poppins(color: Colors.black)),
                    TextSpan(
                      text: 'Prejuízos'.tr(),
                      style: GoogleFonts.poppins(color: Color(0xFFEB3F3F)),
                    ),
                  ]),
              style: GoogleFonts.poppins(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: <Color>[
                    Color(0xff3EC93D),
                    Color(0xff62C262),
                  ],
                ),
              ),
              height: 55,
              child: Center(
                child: Text(
                  "R\$ A fazer",
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            Text("Gráfico de estoque"),
            Text("Gráfico de saldo")
          ],
        ),
      ),
    );
  }
}
