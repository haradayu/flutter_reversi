import 'package:flutter/material.dart';
import 'package:flutterapp/GameManager.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
    @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'リバーシ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '対局'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GameManager gm = GameManager();
  double blackArrowOpacity = 1.0;
  int blackScore = 2;
  int whiteScore = 2;
  TextStyle scoreLabelText(){
    return TextStyle(
      color: Colors.orange,
      fontSize: 40,
      fontFamily: 'Roboto',
      fontStyle: FontStyle.normal,
    );
  }

  Widget stone(x,y){
    if (gm.getCellStatus(x, y) == GameManager.blank){
      return Container();
    }else{
      var color;
      if (gm.getCellStatus(x, y) == GameManager.black){
        color = Colors.black;
      }else if(gm.getCellStatus(x, y) == GameManager.white){
        color = Colors.white;
      }
      return Container(
        margin: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle),
      );
    }
  }

  Widget reversiBoard(){
    final rows = <Widget>[];
    for (int x=0;x < 8;x++){
      final spots = <Widget>[];
      for(int y=0;y<8;y++){
        spots.add(
          GestureDetector(
            onTap: (){onTap(x,y);},
            child:Container(
                height: 40, width: 40,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  color: Colors.green,
                ),
                child:stone(x, y)
            ),
          )
        );

      }
      rows.add(Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: spots));
    }
    return Column(children: rows);

  }

  void onTap(x,y){
    bool flag = gm.putStone(x, y);
    print(flag);
    if(flag) {
      setState(() {
        if(gm.getTurn() == GameManager.black){
          blackArrowOpacity = 1.0;
        }else{
          blackArrowOpacity = 0.0;
        }
        blackScore = gm.getScore(GameManager.black);
        whiteScore = gm.getScore(GameManager.white);

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(

        child: Column(
          children: <Widget>[
            Spacer(flex: 1),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  Spacer(flex: 1),
                  Icon(Icons.arrow_right,
                      color: Colors.black.withOpacity(blackArrowOpacity),
                      size:60
                  ),
                  Text("黒 $blackScore",
                    style: scoreLabelText(),
                    textAlign: TextAlign.center,
                  ),
                  Spacer(flex: 1),
                  Icon(Icons.arrow_right,
                      color: Colors.black.withOpacity(1-blackArrowOpacity),
                      size:60
                  ),
                  Text("白 $whiteScore",
                    style: scoreLabelText(),
                    textAlign: TextAlign.center,
                  ),
                  Spacer(flex: 1)]
            ),
            Spacer(flex: 1),
            Center(
              child: reversiBoard()
            ),
            Center(
              child: Visibility(
                visible: false,
                child: RaisedButton(
                  child: Text("Pass"),
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  onPressed: () {},
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
