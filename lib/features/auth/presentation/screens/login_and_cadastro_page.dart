import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rendify/features/auth/presentation/bloc/login/login_state.dart';
import 'login_page.dart';
import 'cadastro_page.dart';
import 'package:rendify/features/auth/presentation/bloc/register/register_bloc.dart';
import 'package:rendify/features/auth/presentation/bloc/register/register_event.dart';
import 'package:rendify/features/auth/presentation/bloc/register/register_state.dart';
import 'package:rendify/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:rendify/features/auth/presentation/bloc/login/login_event.dart';
import 'package:rendify/features/auth/data/repositories/auth_repository_imp.dart';
import 'package:rendify/features/auth/domain/usercases/register_user.dart';
import 'package:rendify/core/services/http_service.dart';
import 'package:rendify/to-do/screens/main_screen.dart';
import 'package:http/http.dart' as http;
import 'package:rendify/features/home/screen/home_screen.dart';

class LoginCadastroPage extends StatefulWidget {
  const LoginCadastroPage({super.key});

  @override
  State<LoginCadastroPage> createState() => _LoginCadastroPageState();
}

class _LoginCadastroPageState extends State<LoginCadastroPage> {
  bool isLogin = true;

  final TextEditingController nomeController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController confirmarSenhaController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final client = http.Client();
    return MultiBlocProvider(
      providers: [
        BlocProvider<RegisterBloc>(
          create: (_) => RegisterBloc(
            RegisterUser(
              AuthRepositoryImpl(
                HttpService(client),
              ),
            ),
          ),
        ),
        BlocProvider<LoginBloc>(
            create: (_) => LoginBloc(
                authRepository: AuthRepositoryImpl(HttpService(client))))
      ],
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
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
                              backgroundColor:
                                  isLogin ? Colors.indigo : Colors.grey[300],
                              foregroundColor:
                                  isLogin ? Colors.white : Colors.black54,
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
                              backgroundColor:
                                  !isLogin ? Colors.indigo : Colors.grey[300],
                              foregroundColor:
                                  !isLogin ? Colors.white : Colors.black54,
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
                    isLogin
                        ? BlocBuilder<LoginBloc, LoginState>(
                            builder: (context, state) {
                              if (state is LoginSubmitted) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              return Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    final nome = nomeController.text;
                                    final senha = senhaController.text;
                                    if (nome.isNotEmpty && senha.isNotEmpty) {
                                      context.read<LoginBloc>().add(
                                            LoginSubmitted(
                                              name: nome,
                                              password: senha,
                                            ),
                                          );
                                      if (state.name == "Done") {
                                        ScaffoldMessenger.of(context)
                                            .clearSnackBars();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => MainScreen(
                                                body: HomeScreen(
                                              userId: 1,
                                            )),
                                          ),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .clearSnackBars();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content: Text(
                                                  "Verifique seu nome e senha e tente novamente."
                                                      .tr())),
                                        );
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "Preencha os campos corretamente"
                                                    .tr())),
                                      );
                                    }
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
                                    style: GoogleFonts.poppins(
                                        fontSize: 17, color: Colors.white),
                                  ),
                                ),
                              );
                            },
                          )
                        : BlocBuilder<RegisterBloc, RegisterState>(
                            builder: (context, state) {
                              if (state is RegisterLoading) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              return Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    final nome = nomeController.text;
                                    final senha = senhaController.text;
                                    final confirmar =
                                        confirmarSenhaController.text;

                                    if (nome.isNotEmpty &&
                                        senha.isNotEmpty &&
                                        senha == confirmar) {
                                      context.read<RegisterBloc>().add(
                                            SubmitRegister(
                                                nome: nome,
                                                senha: senha,
                                                confirmarSenha: confirmar),
                                          );
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MainScreen(
                                              body: HomeScreen(
                                            userId: 1,
                                          )),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "Preencha os campos corretamente"
                                                    .tr())),
                                      );
                                    }
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
                                    style: GoogleFonts.poppins(
                                        fontSize: 17, color: Colors.white),
                                  ),
                                ),
                              );
                            },
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
