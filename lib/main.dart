import 'package:flutter/material.dart';
import 'package:rendify/shared/components/appbar.dart';
import 'package:rendify/features/auth/presentation/screens/login_and_cadastro_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await dotenv.load(fileName: ".env");

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en','US'), Locale('pt','BR'), Locale('es','MEX')],
      path: 'assets/translations',
      fallbackLocale: Locale('pt','BR'),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Rendify",
      home: Scaffold(
        appBar: CustomAppBar(),
        body: LoginCadastroPage(),
        ),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
    );
  }
}
