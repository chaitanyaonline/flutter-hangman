import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'gameScreen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find The Word'),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage('images/six.png'),
                width: 300.0,
                height: 350.0,
              ),
              Padding(
                padding: EdgeInsets.all(50.0),
                child: Text(
                  'Hangman',
                  style: GoogleFonts.exo(
                    textStyle: TextStyle(
                      fontSize: 30.0,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: MaterialButton(
                  minWidth: 150.0,
                  height: 50.0,
                  color: Colors.lightBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Text(
                    'Start',
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return GamePage();
                    }));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
