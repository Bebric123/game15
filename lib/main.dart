import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; 
import 'package:flutter_application_1/widget/liderboard.dart';
import 'records.dart';
import 'board.dart';
void main (){
  runApp(MemoryGame());
}
class MemoryGame extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: MenuMemoryGame(),
    );
  }
}
class MenuMemoryGame extends StatefulWidget {
  @override
  _MenuMemoryGameState createState() => _MenuMemoryGameState();
}
class _MenuMemoryGameState extends State<MenuMemoryGame>{
  String username='';
  Color widgetColor = Colors.black;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '15-PuzzleGameSimulator',
          style: GoogleFonts.roboto( 
                  color: const Color.fromARGB(255, 255, 255, 255), 
                  fontSize: 35, 
                  fontWeight: FontWeight.bold, 
                ), 
        ),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
      ),
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          TextField(
          onChanged: (value) {
            setState(() {
              username = value;
            });
            GameRecordsManager.saveGameRecord(username, 0, 0);
          },
            decoration: InputDecoration(
              hintText: 'Введите никнейм',
              hintStyle: GoogleFonts.roboto( 
                  color: Color.fromARGB(255, 117, 113, 113), 
                  fontSize: 20, 
                  fontWeight: FontWeight.bold, 
                ), 
            ),
          ),
          
            ListTile(
              title: Text(
                'Начать игру',
                style: GoogleFonts.roboto( 
                  color: Colors.black, 
                  fontSize: 20, 
                  fontWeight: FontWeight.bold, 
                ), 
              ),
              enabled: username.isNotEmpty,
              onTap: (){
                Navigator.push( 
                  context, 
                  MaterialPageRoute(builder: (context) => board(username: username)) 
                );
              },
            ),
            ListTile(
              title: Text(
                'Таблица лидеров шаги',
                style: GoogleFonts.roboto( 
                  color: Colors.black, 
                  fontSize: 20, 
                  fontWeight: FontWeight.bold, 
                ), 
              ),
              onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovesLeaderboard(),
                    ),
                  );
                },
              ),
            ListTile(
              title: Text(
                'Таблица лидеров время',
                style: GoogleFonts.roboto( 
                  color: Colors.black, 
                  fontSize: 20, 
                  fontWeight: FontWeight.bold, 
                ), 
              ),
              onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TimeLeaderboard(),
                    ),
                  );
                },
              ),
            ListTile(
              title: Text(
                'Выход',
                style: GoogleFonts.roboto( 
                  color: Colors.black, 
                  fontSize: 20, 
                  fontWeight: FontWeight.bold, 
                ), 
                ),
              onTap: (){
                exit(0);
              },
            ),
          ],
        ),
      ),
    );
  }
}