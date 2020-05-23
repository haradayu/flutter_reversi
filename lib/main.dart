import 'package:flutter/material.dart';

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
  List<List<int>> board = List.generate(8, (_) => List.generate(8, (_) => 0));
  TextStyle scoreLabelText(){
    return TextStyle(
      fontSize: 40,
      fontFamily: 'Roboto',
      fontStyle: FontStyle.normal,
    );
  }

  Widget stone(x,y){
    if (board[x][y] == 0){
      return Container();
    }else{
      var color;
      if (board[x][y] == 1){
        color = Colors.black;
      }else if(board[x][y] == 2){
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
    setState(() {
      board[x][y] = (board[x][y] + 1)%3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  Spacer(flex: 1),
                  Icon(Icons.arrow_right, color: Colors.black.withOpacity(1.0),size:60),
                  Text("黒 32",
                    style: scoreLabelText(),
                    textAlign: TextAlign.center,
                  ),
                  Spacer(flex: 1),
                  Icon(Icons.arrow_right, color: Colors.black.withOpacity(1.0),size:60),
                  Text("白 32",
                    style: scoreLabelText(),
                    textAlign: TextAlign.center,
                  ),
                  Spacer(flex: 1)]
            ),
            Center(
              child: reversiBoard()
            )
          ],
        ),
      ),
    );
  }
}
