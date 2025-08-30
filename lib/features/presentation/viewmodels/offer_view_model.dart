import 'package:flutter/material.dart';

class OfferViewModel extends ChangeNotifier {
  List<String> offers = [
    'Oferta 1: 2x1 en todos los productos',
    'Oferta 2: 50% de descuento en productos seleccionados',
    'Oferta 3: Envío gratis en compras superiores a \$50',
  ];
}
