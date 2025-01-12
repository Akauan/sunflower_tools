import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

DateTime addCooldownWithTimezone(int startedAt, int cooldown, String timezone) {
  // Inicializar a base de dados de fuso horário
  tz.initializeTimeZones();

  // Obter a localização do fuso horário
  final location = tz.getLocation(timezone);

  // Converter timestamp para DateTime no fuso horário UTC
  DateTime utcTime =
      DateTime.fromMillisecondsSinceEpoch(startedAt, isUtc: true);

  // Converter o DateTime para o fuso horário especificado
  tz.TZDateTime tzTime = tz.TZDateTime.from(utcTime, location);

  // Adicionar o cooldown em segundos
  tz.TZDateTime endTime = tzTime.add(Duration(seconds: cooldown));

  // Retornar o DateTime final no fuso horário especificado
  return endTime;
}

String formattedItemData(int startedAt, int cooldown, String timezone,
    {bool returnDifference = false}) {
  // Formatar a data e hora de acordo com o fuso horário
  DateTime result = addCooldownWithTimezone(startedAt, cooldown, timezone);
  final location = tz.getLocation(timezone);
  final localResult = tz.TZDateTime.from(result, location);
  DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
  if (returnDifference) {
    final now = DateTime.now().toUtc();
    final diff = localResult.difference(now).inSeconds;
    return diff.toString();
  }
  return formatter.format(localResult);
}
