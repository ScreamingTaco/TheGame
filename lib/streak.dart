import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class StreakData {
  double streak;
  double highScore;

  StreakData(streak, highScore){
    this.streak = streak;
    this.highScore = highScore;
  }

  save() {}
}

Future<StreakData> getStreakData() async {
    //couldn't use async in a constructor. DONT RUN THIS MORE THAN ONCE per session; lastlogin gets updated after the first run

    StreakData _streakData = StreakData(0.0, 0.0);
    _streakData.streak = await calcStreak();
    _streakData.highScore = await getHighScore();

    // uncomment the next two lines to clear everything
    // final pref = await SharedPreferences.getInstance();
    // await pref.clear();

    return _streakData;
  }

Future<DateTime> getLastLogin() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final lastLogin =
      DateTime.parse(prefs.getString("last_login") ?? "2020-04-20 09:00:00");
  prefs.setString("last_login", DateTime.now().toString());
  return lastLogin;
}

Future<double> getHighScore() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final highScore = double.parse(prefs.getString("high_score") ?? "0.0");
  final currentStreak = await calcStreak();

  if (currentStreak > highScore) {
    prefs.setString("high_score", currentStreak.toString());
    return currentStreak;
  }

  return highScore;
}

Future<double> calcStreak() async {
  var currentDate = new DateTime.now();

  var lastAccessDate = await getLastLogin(); // the string would be parsed here
  var difference =
      currentDate.difference(lastAccessDate); // this calculates the difference
  var hourDifference = difference.inHours
      .toInt(); // I could have immediately converted difference to days, but this yields a less precise number
  var dayDifference = hourDifference / 24; //this converts hours to days

  return dayDifference; // this is then printed in the UI
}
