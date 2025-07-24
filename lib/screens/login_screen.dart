import 'package:flutter/material.dart';
import '../components/appbar.dart';
import 'package:google_fonts/google_fonts.dart';

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
      appBar: const CustomAppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Bem-vindo ao Rendify',
                    style: GoogleFonts.poppins(fontSize: 24),
                  ),
                  const SizedBox(height: 60),
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
                            minimumSize: Size(60, 60),
                          ),
                          child: Text('Login', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 17),),
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
                            minimumSize: Size(60, 60),
                          ),
                          child: Text('Cadastro', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 17),),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 37),
                  TextField(
                    controller: nomeController,
                    decoration: const InputDecoration(labelText: 'Nome', border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.zero), filled: true, fillColor: Color(0xFFCACACA), labelStyle: TextStyle(color: Colors.black))
                  ),
                  const SizedBox(height: 25),
                  TextField(
                    controller: senhaController,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Senha', border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.zero), filled: true, fillColor: Color(0xFFCACACA), labelStyle: TextStyle(color: Colors.black)),
                  ),
                  if (!isLogin) ...[
                    const SizedBox(height: 25),
                    TextField(
                      controller: confirmarSenhaController,
                      obscureText: true,
                      decoration: const InputDecoration(labelText: 'Confirmar senha', border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.zero), filled: true, fillColor: Color(0xFFCACACA), labelStyle: TextStyle(color: Colors.black))
                    ),
                  ],
                  const SizedBox(height: 25),
                  ElevatedButton(
                    onPressed: () {
                      // ação de login ou cadastro
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                      elevation: 4,
                      shape: LinearBorder(),
                    ),
                    child: Text('Confirmar', style: GoogleFonts.poppins(fontSize: 17, color: Colors.white),),
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
