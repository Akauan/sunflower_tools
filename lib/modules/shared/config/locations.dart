// Obtém o fuso horário de São Paulo (GMT-3)
import 'package:timezone/timezone.dart' as tz;

class LocationsConstants {
  static final tz.Location saoPaulo = tz.getLocation('America/Sao_Paulo');
}
