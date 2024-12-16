import 'package:flutter/material.dart';
import 'package:flutter_application_1/records.dart';

class TimeLeaderboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard - Time'),
      ),
      body: FutureBuilder<Map<String, int>>(
        future: GameRecordsManager.getAllTimeLeaderboard(), 
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return const ListTile(
                    leading: Text('Rank'),
                    title: Text('Username'),
                    trailing: Text('Time (s)'),
                  );
                } else {
                  final username = snapshot.data!.keys.elementAt(index - 1);
                  final time = snapshot.data![username];
                  return ListTile(
                    leading: Text(index.toString()),
                    title: Text(username),
                    trailing: Text('${time} сек'),
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}

class MovesLeaderboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard - Moves'),
      ),
      body: FutureBuilder<Map<String, int>>(
        future: GameRecordsManager.getAllMovesLeaderboard(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return const ListTile(
                    leading: Text('Rank'),
                    title: Text('Username'),
                    trailing: Text('Moves'),
                  );
                } else {
                  final username = snapshot.data!.keys.elementAt(index - 1);
                  final moves = snapshot.data![username];
                  return ListTile(
                    leading: Text(index.toString()),
                    title: Text(username),
                    trailing: Text('${moves} шагов'),
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}