import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class TimeZoneHelper {
  static Future<void> configureLocalTimeZone() async {
    tz.initializeTimeZones();
    var timeZoneName =
        DateTime.now().timeZoneName; // Captura o timeZone do dispositivo

    // Lista de Timezones disponivel em: https://help.syncfusion.com/flutter/calendar/timezone
    if (timeZoneName == 'GMT') {
      timeZoneName = 'Europe/London';
    }
    //final timeZoneName = 'America/Sao_Paulo';
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  /// Retorna um [TzDateTime] cronometrado para uma duracao.
  static int getToday() {
    return tz.TZDateTime.now(tz.local).day % DateTime.daysPerWeek;
  }

  /// Retorna um [TzDateTime] cronometrado para uma duracao.
  static tz.TZDateTime nowPlusDuration({Duration duration}) {
    return tz.TZDateTime.now(tz.local).add(duration);
  }

  /// Retorna um [TZDateTime] da proxima ocorrencia da hora dada.
  static tz.TZDateTime nextInstanceOf({int hour, int minute}) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  /// Retorna um [TXDateTime] da proxima ocorrencia da data dada.
  static tz.TZDateTime nextInstanceOfDay({int hour, int minute, int day}) {
    var scheduledDate = nextInstanceOf(hour: hour, minute: minute);

    // Enquanto nao for o dia dado, aumente a data em um dia
    while (scheduledDate.weekday != day) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }
}
