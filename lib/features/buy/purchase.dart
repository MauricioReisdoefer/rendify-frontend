import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:rendify/core/models/stock_model.dart';
import 'package:rendify/core/services/http_service.dart';
import 'package:rendify/shared/components/graphic.dart';

import 'bloc/buy_bloc.dart';
import 'bloc/buy_event.dart';
import 'bloc/buy_state.dart';
import 'bloc/company_bloc.dart';
import 'bloc/company_event.dart';
import 'bloc/company_state.dart';

class StockPage extends StatefulWidget {
  final StockModel stock;

  StockPage({super.key, required this.stock});

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  late StockModel stock;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    stock = widget.stock;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => StockBloc(
            initialPrice: stock.price,
            initialQuantity: stock.ammount!,
            client: HttpService(Client()),
            symbol: stock.symbol,
          ),
        ),
        BlocProvider(
          create: (_) => CompanyBloc(client:Client())
            ..add(FetchCompanyName(symbol: stock.symbol)),
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color(0xFFEEEEEE),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Stock",
                          style: GoogleFonts.poppins(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text("${stock.symbol}",
                            style: GoogleFonts.poppins(
                                fontSize: 14, color: Colors.grey)),
                        const SizedBox(height: 12),
                        Text(
                          "Interações".tr(),
                          style: GoogleFonts.poppins(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        BlocBuilder<CompanyBloc, CompanyState>(
                          builder: (context, state) {
                            return RichText(
                              text: TextSpan(
                                text: "Interaja com suas Ações da ".tr(),
                                style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
                                children: [
                                  TextSpan(
                                    text: state.company_name.isNotEmpty ? state.company_name : stock.symbol,
                                    style: GoogleFonts.poppins(fontSize: 14, color: Colors.blue),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BlocBuilder<CompanyBloc, CompanyState>(
                                builder: (context, state) => Text(
                                  state.company_name.isNotEmpty
                                      ? state.company_name
                                      : stock.symbol,
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text("\$${stock.price}",
                                  style: GoogleFonts.poppins(color: Colors.green)),
                              const SizedBox(height: 16),
                              SizedBox(
                                height: 200,
                                child: BdrChartCard(symbol: stock.symbol),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Preço: R\$${stock.price.toStringAsFixed(2)}".tr(),
                          style: GoogleFonts.poppins(fontSize: 16),
                        ),
                        BlocBuilder<StockBloc, StockState>(
                          builder: (context, state) => Text(
                            "Estoque: ${state.quantity} Ações".tr(),
                            style: GoogleFonts.poppins(
                                fontSize: 16, color: Colors.blue),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: BlocBuilder<StockBloc, StockState>(
                                builder: (context, state) {
                                  return ElevatedButton(
                                    onPressed: () async {
                                      final amount = await
                                          int.tryParse(_controller.text) ?? 0;
                                      context
                                          .read<StockBloc>()
                                          .add(BuyStock(amount));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size(1, 70),
                                      backgroundColor: Colors.green,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8)),
                                      padding:
                                          const EdgeInsets.symmetric(vertical: 14),
                                    ),
                                    child: 
                                        Text("Comprar".tr(),
                                            style: GoogleFonts.poppins(
                                                color: Colors.white, fontSize: 16)
                                  ),);
                                },
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: BlocBuilder<StockBloc, StockState>(
                                builder: (context, state) {
                                  return ElevatedButton(
                                    onPressed: () {
                                      final amount =
                                          int.tryParse(_controller.text) ?? 0;
                                      context
                                          .read<StockBloc>()
                                          .add(SellStock(amount));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size(1, 70),
                                      backgroundColor: const Color(0xffeb3f3f),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8)),
                                      padding:
                                          const EdgeInsets.symmetric(vertical: 14),
                                    ),
                                    child: Text("Vender".tr(),
                                        style: GoogleFonts.poppins(
                                            color: Colors.white, fontSize: 16)),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _controller,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "Digite a quantidade a ser vendida/comprada...".tr(),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
