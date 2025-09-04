import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart';

class DuvidasFrequentesPage extends StatelessWidget {
  const DuvidasFrequentesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            "Dúvidas Frequentes".tr(),
            style: GoogleFonts.poppins(fontSize: 20),
          ),
          SizedBox(
            height: 5,
          ),
          FAQTile(
              question: 'Como funciona a simulação do mercado?'.tr(),
              answer:
                  'Com base em registros passados, o simulador ira acelerar a variação da ação para fins de aprendizado'
                      .tr()),
          FAQTile(
            question: 'O que é a Watchlist?'.tr(),
            answer:
                'A Watchlist é uma lista personalizada de ativos que você deseja acompanhar frequentemente.'
                    .tr(),
          ),
          FAQTile(
            question: 'Como usar as ferramentas de simulação?'.tr(),
            answer:
                'Acesse a aba "Simulador", selecione os ativos desejados e defina as condições para iniciar a simulação.'
                    .tr(),
          ),
          FAQTile(
            question: 'Onde posso buscar mais ajuda?'.tr(),
            answer:
                'Para buscar ajuda sobre algo específico, vá até o final da página para encontrar o nosso e-mail.'
                    .tr(),
          ),
          const SizedBox(height: 30),
          Text.rich(
            TextSpan(
              text: 'Você precisa de '.tr(),
              children: [
                TextSpan(
                  text: 'Ajuda Personalizada?'.tr(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                )
              ],
            ),
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text("Utilize nosso contato\npor e-mail para \nreceber ajuda"
                  .tr()),
              SizedBox(
                width: 6,
              ),
              ElevatedButton(
                onPressed: () async {
                  final Uri _url = Uri.parse(
                      'https://mail.google.com/mail/u/0/#inbox?compose=GTvVlcSHwCdMTSTsgMHFdXTCvzWXKxvPllttCwwhTPNFhDMKnRltCVcKsZLrNjpRQNnTSglsgbJvc');
                  if (!await launchUrl(_url)) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Não foi possível acessar o e-mail")));
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5F6EF8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('E-mail'.tr(),
                      style: GoogleFonts.poppins(
                          fontSize: 16, color: Colors.white)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FAQTile extends StatelessWidget {
  final String question;
  final String answer;

  FAQTile({
    super.key,
    required this.question,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text(
          question,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
            child: Text(answer),
          ),
        ],
      ),
    );
  }
}
