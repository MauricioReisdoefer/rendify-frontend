import 'package:flutter/material.dart';
import '../components/appbar.dart';

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
                  const Text(
                    'Bem-vindo ao Rendify',
                    style: TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => setState(() => isLogin = true),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isLogin ? Colors.indigo : Colors.grey[300],
                            foregroundColor: isLogin ? Colors.white : Colors.black54,
                            elevation: isLogin ? 4 : 0,
                          ),
                          child: const Text('Login'),
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
                          ),
                          child: const Text('Cadastro'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: nomeController,
                    decoration: const InputDecoration(labelText: 'Nome'),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: senhaController,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Senha'),
                  ),
                  if (!isLogin) ...[
                    const SizedBox(height: 10),
                    TextField(
                      controller: confirmarSenhaController,
                      obscureText: true,
                      decoration: const InputDecoration(labelText: 'Confirmar senha'),
                    ),
                  ],
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // ação de login ou cadastro
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                      elevation: 4,
                    ),
                    child: const Text('Confirmar'),
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
