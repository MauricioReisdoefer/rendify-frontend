import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'login_page.dart';
import 'cadastro_page.dart';
import 'package:rendify/screens/main_screen.dart';

class LoginCadastroPage extends StatefulWidget {
  const LoginCadastroPage({super.key});

  @override
  State<LoginCadastroPage> createState() => _LoginCadastroPageState();
}

class _LoginCadastroPageState extends State<LoginCadastroPage> {
  bool isLogin = true;

  final TextEditingController nomeController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController confirmarSenhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Center(
                    child: Text(
                      'Bem-vindo ao Rendify'.tr(),
                      style: GoogleFonts.poppins(fontSize: 24),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => setState(() => isLogin = true),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isLogin ? Colors.indigo : Colors.grey[300],
                            foregroundColor: isLogin ? Colors.white : Colors.black54,
                            elevation: isLogin ? 4 : 0,
                            shape: LinearBorder(),
                            minimumSize: const Size(60, 60),
                          ),
                          child: Text(
                            'Login'.tr(),
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => setState(() => isLogin = false),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: !isLogin ? Colors.indigo : Colors.grey[300],
                            foregroundColor: !isLogin ? Colors.white : Colors.black54,
                            elevation: !isLogin ? 4 : 0,
                            shape: LinearBorder(),
                            minimumSize: const Size(60, 60),
                          ),
                          child: Text(
                            'Cadastro'.tr(),
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 27),
                  if (isLogin)
                    LoginPage(
                      nomeController: nomeController,
                      senhaController: senhaController,
                    )
                  else
                    CadastroPage(
                      nomeController: nomeController,
                      senhaController: senhaController,
                      confirmarSenhaController: confirmarSenhaController,
                    ),
                  const SizedBox(height: 15),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MainScreen(body: HomeScreen()),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 12),
                        elevation: 4,
                        shape: LinearBorder(),
                      ),
                      child: Text(
                        'Confirmar'.tr(),
                        style:
                            GoogleFonts.poppins(fontSize: 17, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
