import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'color.dart';
import 'streak.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Game',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Manrope',
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Color> colors = randomColor();
  StreakData _streakData = StreakData(0.0, 0.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: colors,
            tileMode: TileMode.repeated, // repeats the gradient over the canvas
          ),
        ),
        child: Stack(
          children: <Widget>[
            Align(
                alignment: Alignment(.85, -.85),
                child: IconButton(
                  icon: Icon(Icons.menu),
                  color: Colors.white,
                  onPressed: _showRules,
                )),
            Center(
                child: Container(
              height: MediaQuery.of(context).size.height * .5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    "You just lost the game",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 38,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  FutureBuilder(
                    future: getStreakData(),
                    initialData: _streakData,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        _streakData.streak = snapshot.data.streak;
                        _streakData.highScore = snapshot.data.highScore;
                      }
                      return Text(
                        "Broke a ${snapshot.data.streak.round()} day streak\nBest: ${snapshot.data.highScore.round()}", //TODO: implent this
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.share),
                    color: Colors.white,
                    onPressed: () {
                      Share.share(
                          //TODO: Add streak into the msg
                          "I just lost the game after ${_streakData.streak.round()} days!\n\nhttps://devpost.com/software/the-game-uesxym",
                          subject: "The Game");
                    },
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  //TODO: consider restyling this
  _showRules() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
            "Rules",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
          ),
          content: new Text(
            "1. Everyone is playing The Game\n\n2. You lose when you think about the game\n\n3. When you lose, you need to tell someone",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
          backgroundColor: Color(0x90000000),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        );
      },
    );
  }
}
