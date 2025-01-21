import 'package:get/get.dart';
import 'package:sunflower_tools/modules/shared/config/interceptor.dart';
import 'package:sunflower_tools/modules/shared/controllers/prices_controller.dart';

class PricesService {
  // Set [baseUrl] with the API IP
  final String baseUrl = const String.fromEnvironment('PRICES');

  final PricesController pricesController = Get.find<PricesController>();

  // Store the previous data to compare with new data
  Map<String, dynamic>? previousData;

  // Function to fetch data from the API
  Future<int> getPricesData() async {
    try {
      final response = await InterceptorConfig().dio.get(baseUrl);

      // Verifique se a resposta é válida antes de continuar
      if (response == null) {
        return Future.error('No response from the server');
      }

      // Verifique se statusCode está presente e é válido
      if (response.statusCode == null) {
        return Future.error('Invalid status code (null)');
      }

      // Se a resposta for um sucesso (statusCode 200)
      if (response.statusCode == 200) {
        if (response.data != null) {
          // Verifique se os dados são diferentes dos dados anteriores

          await pricesController.getPrices(
              body: response
                  .data); // Atualizar o exchangeController com os novos dados
        } else {
          return Future.error('Response data is null');
        }
      } else {
        return Future.error('Unexpected status code: ${response.statusCode}');
      }

      return response.statusCode ??
          500; // Retorna o statusCode, ou 500 se for nulo.
    } catch (error) {
      return Future.error(error.toString());
    }
  }
}
