import 'dart:async';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class ModalClass {
  String alphabet;
  bool status;
  ModalClass(this.alphabet, this.status);
}

class _GamePageState extends State<GamePage> {
  Timer timeDelay;
  String guessWord;
  String mainWord;
  String message;
  var checkIt;
  var collector;
  var wordToFind;
  var dialogImage;
  int turns;

  AssetImage one = AssetImage('images/one.png');
  AssetImage two = AssetImage('images/two.png');
  AssetImage three = AssetImage('images/three.png');
  AssetImage four = AssetImage('images/four.png');
  AssetImage five = AssetImage('images/five.png');
  AssetImage six = AssetImage('images/six.png');
  AssetImage win = AssetImage('images/win.jpg');
  AssetImage lose = AssetImage('images/lose.jpg');

  List<ModalClass> alphabets = List();

  //todo: init Method
  @override
  void initState() {
    checkIt = 0;
    super.initState();
    wordToFind = WordPair.random();
    mainWord = wordToFind.toString().toUpperCase();
    guessWord = "";
    for (int i = 0; i < mainWord.length; i++) {
      guessWord += "_";
    }
    turns = 5;
    int c = "A".codeUnitAt(0);
    int end = "Z".codeUnitAt(0);
    while (c <= end) {
      alphabets.add(ModalClass(String.fromCharCode(c), null));
      c++;
    }
  }

  //todo: playgame method
  playGame(int index) {
    setState(() {
      if (alphabets[index].status != null) {
        return;
      }
      collector = alphabets[index].alphabet;
      bool result = checkExist(collector);
      if (!result) {
        turns -= 1;
        alphabets[index].status = false;
      } else {
        alphabets[index].status = true;
      }
      if (guessWord == mainWord) {
        checkIt = 1;
        checkDialog();
        return dialogBox();
      }
      if (turns == 0) {
        checkIt = 0;
        checkDialog();
        return dialogBox();
      }
    });
  }

  //todo: checkExist method
  bool checkExist(var collector) {
    if (mainWord.contains(collector)) {
      for (var i = 0; i < mainWord.length; i++) {
        if (mainWord[i] == collector) {
          guessWord = guessWord.substring(0, i) +
              collector +
              guessWord.substring(i + 1, mainWord.length);
        }
      }
      return true;
    } else {
      return false;
    }
  }

  //todo: conditions for dialogBox O/P
  checkDialog() {
    if (checkIt == 1) {
      message = 'You Win';
      dialogImage = win;
    } else {
      message = 'Game Over';
      dialogImage = lose;
    }
  }

  //todo: alertDialogBox O/P
  dialogBox() {
    timeDelay = Timer(Duration(seconds: 1), () {
      return showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                this.message,
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
              content: Image(
                image: dialogImage,
                width: 100.0,
                height: 100.0,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                    child: Text(
                      'Exit',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    )),
                FlatButton(
                    onPressed: () {
                      this.resetGame();
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Play Again',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ))
              ],
            );
          });
    });
  }

  //todo: resetGame method
  resetGame() {
    setState(() {
      checkIt = 0;
      wordToFind = WordPair.random();
      mainWord = wordToFind.toString().toUpperCase();
      guessWord = "";
      for (int i = 0; i < mainWord.length; i++) {
        guessWord += "_";
      }
      turns = 5;
      alphabets = List();
      int c = "A".codeUnitAt(0);
      int end = "Z".codeUnitAt(0);
      while (c <= end) {
        alphabets.add(ModalClass(String.fromCharCode(c), null));
        c++;
      }
    });
  }

  //todo: getImages method
  AssetImage getImages(int turns) {
    switch (turns) {
      case 5:
        return one;
        break;
      case 4:
        return two;
        break;
      case 3:
        return three;
        break;
      case 2:
        return four;
        break;
      case 1:
        return five;
        break;
      case 0:
        return six;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 35.0, bottom: 10.0),
                child: Image(
                  image: getImages(turns),
                  width: 150.0,
                  height: 200.0,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text('Guess the Word:',
                    style: GoogleFonts.indieFlower(
                      textStyle: TextStyle(
                        fontSize: 20.0,
                      ),
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, left: 20.0, bottom: 20.0),
                child: Text(this.guessWord,
                    style: GoogleFonts.mavenPro(
                      textStyle: TextStyle(
                        fontSize: 30.0,
                        letterSpacing: 2.0,
                      ),
                    )),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(30.0),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7,
                      childAspectRatio: 1.0,
                      mainAxisSpacing: 8.0,
                      crossAxisSpacing: 8.0,
                    ),
                    itemBuilder: (context, i) => SizedBox(
                      width: 10.0,
                      height: 10.0,
                      child: InkWell(
                        child: Text(this.alphabets[i].alphabet,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.indieFlower(
                              textStyle: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                  color: alphabets[i].status == null
                                      ? Colors.black
                                      : (alphabets[i].status
                                          ? Colors.green
                                          : Colors.red)),
                            )),
                        focusColor: Colors.white,
                        onTap: () {
                          setState(() {
                            this.playGame(i);
                          });
                        },
                      ),
                    ),
                    itemCount: alphabets.length,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  'Turns left: $turns',
                  style: TextStyle(
                    fontSize: 25.0,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
