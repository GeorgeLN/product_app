import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_experis/features/presentation/viewmodels/offer_view_model.dart';

class OfferPage extends StatelessWidget {
  const OfferPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OfferViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Ofertas'),
          centerTitle: true,
        ),
        body: Consumer<OfferViewModel>(
          builder: (context, viewModel, child) {
            return ListView.builder(
              itemCount: viewModel.offers.length,
              itemBuilder: (context, index) {
                final offer = viewModel.offers[index];
                return ListTile(
                  title: Text(offer),
                );
              },
            );
          },
        ),
      ),
    );
  }
}