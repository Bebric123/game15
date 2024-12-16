import 'dart:async'; 
import 'package:flutter/material.dart'; 
import 'package:flutter_application_1/widget/gride.dart'; 
import 'package:google_fonts/google_fonts.dart'; 
import 'records.dart'; 
 
class board extends StatefulWidget { 
  final String username; 
  const board({Key? key, required this.username}) : super(key: key); 
   
  @override 
  _boardState createState() => _boardState(); 
} 
 
class _boardState extends State<board> { 
  var number = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]; 
  int noOfMoves = 0; 
  int seconds = 0; 
  bool isTimerRunning = true; 

  @override 
  void initState(){ 
    super.initState(); 
    number.shuffle(); 
    startTimer(); 
  } 
 
  void startTimer() { 
    const oneSec = Duration(seconds: 1); 
    Timer.periodic(oneSec, (Timer timer) { 
      if (!isTimerRunning) { 
        timer.cancel(); 
      } else { 
        setState(() { 
          seconds++; 
        }); 
      } 
    }); 
  } 
  @override
  void dispose() {
    super.dispose();
    stopTimer(); 
  }
  void stopTimer() { 
    isTimerRunning = false; 
  } 
 
  @override 
  Widget build(BuildContext context) { 
    return Scaffold( 
      appBar: AppBar(),
      body: Column( 
        children:[ 
          Padding( 
            padding: const EdgeInsets.all(8.0), 
            child: Center( 
              child: Text( 
                "Пятнашки", 
                style: GoogleFonts.roboto( 
                  color: Colors.black, 
                  fontSize: 40, 
                  fontWeight: FontWeight.bold, 
                ), 
              ), 
            ), 
          ), 
          Padding( 
            padding: const EdgeInsets.all(8.0), 
            child: Center( 
              child: Text( 
                noOfMoves.toString() + " Шагов | " + seconds.toString() + " Секунд", 
                style: GoogleFonts.roboto( 
                  color: const Color.fromARGB(255, 0, 0, 0), 
                  fontSize: 30, 
                  fontWeight: FontWeight.bold, 
                ), 
              ), 
            ), 
          ), 
          const SizedBox( 
            height: 10, 
          ), 
          Center(child: gride(number,onClick)) 
        ], 
      ), 
    ); 
  } 
 
   void onClick(index){ 
  if(index-1 >= 0 && number[index-1] == 16 && index % 4 != 0 || 
     index+1 < 16 && number[index+1] == 16 && (index+1) % 4 != 0 || 
     (index-4 >= 0 && number[index-4] == 16) || 
     (index+4 < 16 && number[index+4] == 16)){ 
    setState(() { 
      number[number.indexOf(16)] = number[index]; 
      number[index] = 16; 
      noOfMoves++; 
    });
    checkWinner(); 
  } 
}
 
  bool isSorted(List numberList){ 
    int first = numberList.first; 
    for(int i = 0; i < numberList.length; i++){ 
       int nextnumber = numberList[i]; 
       if(first > nextnumber) return false; 
       first = numberList[i]; 
    } 
    return true; 
  } 
 
  void checkWinner() async {
  bool isWinner = isSorted(number);
  if (isWinner) {
    stopTimer();
    GameRecordsManager.saveGameRecord(widget.username, noOfMoves, seconds);
    Map<String, dynamic> userRecord = await GameRecordsManager.getGameRecord(widget.username);
    int bestMoves = userRecord['moves'] ?? 0;
    int bestTime = userRecord['time'] ?? 0;

    if (noOfMoves < bestMoves || (noOfMoves == bestMoves && seconds < bestTime)) {
      await GameRecordsManager.saveGameRecord(widget.username, noOfMoves, seconds);
      print("New high score saved!");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Поздравляем! Вы победили и установили новый рекорд!'),
        ),
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 200,
              width: 200,
              child: Image.asset('assets/cat-plink.gif'),
            ),
          );
        },
      );
    } else {
      print("Поздравляем! Вы победили");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Поздравляем! Вы победили!'),
        ),
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 200,
              width: 200,
              child: Image.asset('assets/pop_cat.webp'),
            ),
          );
        },
      );
    }
  }
 }
}