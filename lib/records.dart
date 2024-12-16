import 'package:shared_preferences/shared_preferences.dart';

class GameRecordsManager {
  static Future<void> saveGameRecord(String username, int moves, int time) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('${username}_moves', moves);
    await prefs.setInt('${username}_time', time);

    print('Результаты игры для пользователя $username успешно сохранены:');
    print('Шаги: $moves');
    print('Время: $time');
  }

  static Future<List<Map<String, dynamic>>> getAllGameRecords() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> gameRecords = [];

    prefs.getKeys().forEach((key) {
      if (key.endsWith('_moves')) {
        String username = key.replaceAll('_moves', '');
        int moves = prefs.getInt('${username}_moves') ?? 0;
        int time = prefs.getInt('${username}_time') ?? 0;
        gameRecords.add({'username': username, 'moves': moves, 'time': time});
      }
    });

    return gameRecords;
  }

  static Future<Map<String, dynamic>> getGameRecord(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int moves = prefs.getInt('${username}_moves') ?? 0;
    int time = prefs.getInt('${username}_time') ?? 0;
    return {'username': username, 'moves': moves, 'time': time};
  }
  static Future<Map<String, int>> getAllTimeLeaderboard() async {
  List<Map<String, dynamic>> gameRecords = await getAllGameRecords();
  
  Map<String, int> timeLeaderboard = {};

  gameRecords.forEach((record) {
    String username = record['username'];
    int time = record['time'];
    if (time != 0) {
      if (timeLeaderboard.containsKey(username)) {
        timeLeaderboard[username] = timeLeaderboard[username]! + time;
      } else {
        timeLeaderboard[username] = time;
      }
    }
  });

  timeLeaderboard = Map.fromEntries(timeLeaderboard.entries.toList()
    ..sort((a, b) => a.value.compareTo(b.value)));

  return timeLeaderboard;
}

static Future<Map<String, int>> getAllMovesLeaderboard() async {
  List<Map<String, dynamic>> gameRecords = await getAllGameRecords();

  Map<String, int> movesLeaderboard = {};

  gameRecords.forEach((record) {
    String username = record['username'];
    int moves = record['moves'];
    if (moves != 0) {
      if (movesLeaderboard.containsKey(username)) {
        movesLeaderboard[username] = movesLeaderboard[username]! + moves;
      } else {
        movesLeaderboard[username] = moves;
      }
    }
  });

  movesLeaderboard = Map.fromEntries(movesLeaderboard.entries.toList()
    ..sort((a, b) => a.value.compareTo(b.value)));

  return movesLeaderboard;
}
}