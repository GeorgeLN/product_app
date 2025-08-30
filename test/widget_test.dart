import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:prueba_experis/core/services/remote_config_service.dart';
import 'package:prueba_experis/features/data/models/product_model.dart';
import 'package:prueba_experis/features/presentation/pages/product_page.dart';
import 'package:prueba_experis/features/presentation/viewmodels/product_view_model.dart';

import 'widget_test.mocks.dart';

// Ahora también generamos un mock para ProductViewModel
@GenerateNiceMocks([
  MockSpec<RemoteConfigService>(),
  MockSpec<ProductViewModel>(),
])
void main() {
  // Creamos los mocks una sola vez para ambos tests
  late MockRemoteConfigService mockRemoteConfigService;
  late MockProductViewModel mockProductViewModel;

  setUp(() {
    // Esta función se ejecuta antes de cada test
    mockRemoteConfigService = MockRemoteConfigService();
    mockProductViewModel = MockProductViewModel();

    // Configuramos el comportamiento por defecto de nuestro ViewModel falso
    when(mockProductViewModel.products).thenReturn(<ProductModel>[]);
    when(mockProductViewModel.state).thenReturn(ViewState.content);
  });

  // Función auxiliar para no repetir código
  Future<void> pumpMyApp(WidgetTester tester) {
    return tester.pumpWidget(
      MultiProvider(
        providers: [
          // Usamos los mocks en lugar de los viewmodels reales
          ChangeNotifierProvider<ProductViewModel>.value(value: mockProductViewModel),
          Provider<RemoteConfigService>.value(value: mockRemoteConfigService),
        ],
        child: const MaterialApp(
          home: ProductPage(), // El home de MyApp es ProductPage
        ),
      ),
    );
  }

  testWidgets('Muestra el botón de ofertas cuando el feature flag está activado', (WidgetTester tester) async {
    // Arrange
    when(mockRemoteConfigService.showOffersSection).thenReturn(true);

    // Act
    await pumpMyApp(tester);
    await tester.pumpAndSettle();

    // Assert
    expect(find.byIcon(Icons.local_offer), findsOneWidget);
  });

  testWidgets('Oculta el botón de ofertas cuando el feature flag está desactivado', (WidgetTester tester) async {
    // Arrange
    when(mockRemoteConfigService.showOffersSection).thenReturn(false);

    // Act
    await pumpMyApp(tester);
    await tester.pumpAndSettle();

    // Assert
    expect(find.byIcon(Icons.local_offer), findsNothing);
  });
}