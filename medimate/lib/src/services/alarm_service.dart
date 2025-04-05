import 'package:alarm/alarm.dart';
import 'package:alarm/model/volume_settings.dart'; // Import this for volume control
import 'package:intl/intl.dart';

class AlarmService {
  static Future<void> setAlarm(String medicineName, DateTime alarmTime) async {
    final alarmSettings = AlarmSettings(
      id: alarmTime.millisecondsSinceEpoch % 100000, // Unique ID
      dateTime: alarmTime,
      assetAudioPath: 'assets/audio/alarm.mp3', // Custom alarm sound
      loopAudio: true,
      vibrate: true,

      notificationSettings: NotificationSettings(
        title: "Medicine Reminder",
        body: "Time to take: $medicineName",
      ),

      // ✅ Added volumeSettings
      volumeSettings: VolumeSettings.fade(
        fadeDuration: Duration(seconds: 5),
        volume: 0.2,
      ),
    );

    await Alarm.set(alarmSettings: alarmSettings);
    print("Alarm set for $medicineName at ${alarmTime.toLocal()}");
  }

  static Future<void> scheduleMedicineAlarms(
      List<Map<String, dynamic>> medicines) async {
    await Alarm.stopAll(); // 🔄 Clean up existing alarms

    for (var map in medicines) {
      String medicineName = map['name'];
      String timesString = map['times'] ?? "";

      if (timesString.isNotEmpty) {
        for (String dayTimes in timesString.split(',')) {
          final parts = dayTimes.split(':');
          if (parts.length == 2) {
            final timeList = parts[1].split('|');

            for (String time in timeList) {
              try {
                DateTime now = DateTime.now();
                DateTime parsedTime = DateFormat('hh:mm a').parse(time);

                DateTime alarmTime = DateTime(
                  now.year,
                  now.month,
                  now.day,
                  parsedTime.hour,
                  parsedTime.minute,
                );

                if (alarmTime.isBefore(now)) {
                  alarmTime = alarmTime.add(const Duration(days: 1));
                }

                await setAlarm(medicineName, alarmTime);
              } catch (e) {
                print("Error parsing time '$time': $e");
              }
            }
          }
        }
      }
    }
  }

  static Future<void> cancelAlarm(int alarmId) async {
    await Alarm.stop(alarmId);
    print("Alarm with ID $alarmId canceled.");
  }
}
