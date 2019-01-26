import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SUDOKU Game',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: MyHomePage(title: 'SUDOKU Game'),
    );
  }
}

const double RADIUS_CORNER = 12;
const int VALUE_NONE = 0;

const int COUNT_ROW_SUB_TABLE = 3;
const int COUNT_COL_SUB_TABLE = 3;

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class SudokuChannel {
  bool enableMove;
  int value;

  SudokuChannel({this.value = 0, this.enableMove = true});
}

class SudokuSubTable {
  int indexRowInTable;
  int indexColInTable;
  List<List<SudokuChannel>> subTable;

  SudokuSubTable({this.indexRowInTable, this.indexColInTable});

  init() {
    subTable = List();
    for (int row = 1; row <= COUNT_ROW_SUB_TABLE; row++) {
      List<SudokuChannel> list = List();
      for (int col = 1; col <= COUNT_COL_SUB_TABLE; col++) {
        list.add(SudokuChannel(value: 0));
      }
      subTable.add(list);
    }
  }

  setValue({int row = 0, int col = 0, int value = 0, bool enableMove = true}) {
    subTable[row][col] = SudokuChannel(value: value, enableMove: enableMove);
  }

  int randomNumber() {
    Random r = Random();
    return r.nextInt(10);
  }
}

class SudokuTable {
  List<List<SudokuSubTable>> table;

  init() {
    table = List();
    for (int row = 0; row < COUNT_ROW_SUB_TABLE; row++) {
      List<SudokuSubTable> list = List();
      for (int col = 0; col < COUNT_COL_SUB_TABLE; col++) {
        SudokuSubTable subTable =
        SudokuSubTable(indexRowInTable: row, indexColInTable: col);
        subTable.init();
        list.add(subTable);
      }
      table.add(list);
    }
  }

}

class _MyHomePageState extends State<MyHomePage> {
  /// Theme game
  ///
  Color colorBorderTable = Colors.white;
  Color colorBackgroundApp = Colors.blue[100];
  Color colorBackgroundChannelEmpty1 = Color(0xffe3e3e3);
  Color colorBackgroundChannelEmpty2 = Colors.white30;
  Color colorBackgroundNumberTab = Colors.white;
  Color colorTextNumber = Colors.white;
  Color colorBackgroundChannelValue = Colors.blue[700];
  Color colorBackgroundChannelValueFixed = Colors.purple[700];

  SudokuTable sudokuTable;

  double channelSize = 0;

  @override
  void initState() {
    initSudokuTable();
    initTableFixed();
    super.initState();
  }

  void initSudokuTable() {
    sudokuTable = SudokuTable();
    sudokuTable.init();
  }

  void initTableFixed() {
    SudokuSubTable subTableLeftTop = sudokuTable.table[0][0];
    subTableLeftTop.setValue(row: 0, col: 2, value: 5, enableMove: false);
    subTableLeftTop.setValue(row: 1, col: 0, value: 1, enableMove: false);
    subTableLeftTop.setValue(row: 1, col: 2, value: 2, enableMove: false);

    SudokuSubTable subTableTop = sudokuTable.table[0][1];
    subTableTop.setValue(row: 0, col: 0, value: 9, enableMove: false);
    subTableTop.setValue(row: 1, col: 1, value: 6, enableMove: false);
    subTableTop.setValue(row: 1, col: 2, value: 8, enableMove: false);
    subTableTop.setValue(row: 2, col: 0, value: 2, enableMove: false);

    SudokuSubTable subTableRightTop = sudokuTable.table[0][2];
    subTableRightTop.setValue(row: 0, col: 1, value: 1, enableMove: false);
    subTableRightTop.setValue(row: 1, col: 0, value: 4, enableMove: false);
    subTableRightTop.setValue(row: 2, col: 0, value: 7, enableMove: false);

    SudokuSubTable subTableLeft = sudokuTable.table[1][0];
    subTableLeft.setValue(row: 0, col: 0, value: 2, enableMove: false);
    subTableLeft.setValue(row: 0, col: 1, value: 1, enableMove: false);
    subTableLeft.setValue(row: 1, col: 1, value: 4, enableMove: false);
    subTableLeft.setValue(row: 1, col: 2, value: 8, enableMove: false);
    subTableLeft.setValue(row: 2, col: 1, value: 5, enableMove: false);

    SudokuSubTable subTableCenter = sudokuTable.table[1][1];
    subTableCenter.setValue(row: 0, col: 0, value: 8, enableMove: false);
    subTableCenter.setValue(row: 0, col: 2, value: 6, enableMove: false);
    subTableCenter.setValue(row: 1, col: 1, value: 9, enableMove: false);
    subTableCenter.setValue(row: 2, col: 0, value: 4, enableMove: false);
    subTableCenter.setValue(row: 2, col: 2, value: 3, enableMove: false);

    SudokuSubTable subTableRight = sudokuTable.table[1][2];
    subTableRight.setValue(row: 0, col: 1, value: 3, enableMove: false);
    subTableRight.setValue(row: 1, col: 0, value: 6, enableMove: false);
    subTableRight.setValue(row: 1, col: 1, value: 5, enableMove: false);
    subTableRight.setValue(row: 2, col: 1, value: 7, enableMove: false);
    subTableRight.setValue(row: 2, col: 2, value: 8, enableMove: false);

    SudokuSubTable subTableBottomLeft = sudokuTable.table[2][0];
    subTableBottomLeft.setValue(row: 0, col: 2, value: 4, enableMove: false);
    subTableBottomLeft.setValue(row: 1, col: 2, value: 3, enableMove: false);
    subTableBottomLeft.setValue(row: 2, col: 1, value: 6, enableMove: false);

    SudokuSubTable subTableBottom = sudokuTable.table[2][1];
    subTableBottom.setValue(row: 0, col: 2, value: 2, enableMove: false);
    subTableBottom.setValue(row: 1, col: 0, value: 6, enableMove: false);
    subTableBottom.setValue(row: 1, col: 1, value: 8, enableMove: false);
    subTableBottom.setValue(row: 2, col: 2, value: 4, enableMove: false);

    SudokuSubTable subTableBottomRight = sudokuTable.table[2][2];
    subTableBottomRight.setValue(row: 1, col: 0, value: 5, enableMove: false);
    subTableBottomRight.setValue(row: 1, col: 2, value: 1, enableMove: false);
    subTableBottomRight.setValue(row: 2, col: 0, value: 3, enableMove: false);
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery
        .of(context)
        .size
        .width
        .toString());
    channelSize = (MediaQuery
        .of(context)
        .size
        .width / 9) - 8;
    print("" + channelSize.toString());
    return Scaffold(
        body: Container(
            constraints: BoxConstraints.expand(),
            color: colorBackgroundApp,
            child: Column(children: <Widget>[
              buildMenu(),
              Container(height: 8, color: Colors.blue[300]),
              Expanded(
                  child: Container(constraints: BoxConstraints.expand(),
                      child: Center(
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                      color: colorBorderTable,
                                      borderRadius: BorderRadius.all(Radius.circular(8))),
                                  padding: EdgeInsets.all(6),
                                  child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            buildSubTable(sudokuTable.table[0][0],
                                                colorBackgroundChannelEmpty1),
                                            buildSubTable(sudokuTable.table[0][1],
                                                colorBackgroundChannelEmpty2),
                                            buildSubTable(sudokuTable.table[0][2],
                                                colorBackgroundChannelEmpty1),
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            buildSubTable(sudokuTable.table[1][0],
                                                colorBackgroundChannelEmpty2),
                                            buildSubTable(sudokuTable.table[1][1],
                                                colorBackgroundChannelEmpty1),
                                            buildSubTable(sudokuTable.table[1][2],
                                                colorBackgroundChannelEmpty2),
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            buildSubTable(sudokuTable.table[2][0],
                                                colorBackgroundChannelEmpty1),
                                            buildSubTable(sudokuTable.table[2][1],
                                                colorBackgroundChannelEmpty2),
                                            buildSubTable(sudokuTable.table[2][2],
                                                colorBackgroundChannelEmpty1),
                                          ],
                                        )
                                      ]),
                                )
                              ])))),
              Container(height: 8, color: Colors.blue[200]),
              Container(
                  padding: EdgeInsets.all(12),
                  color: colorBackgroundNumberTab,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: buildNumberListTab()))
            ])));
  }

  Container buildMenu() {
    return Container(
      padding: EdgeInsets.only(top: 30, bottom: 8, right: 16, left: 16),
      constraints: BoxConstraints.expand(height: 100),
      color: Colors.white,
      child: Row(mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("SUDOKU",
                style: TextStyle(
                    color: Colors.blue[700],
                    fontSize: 30,
                    fontWeight: FontWeight.bold)),
            Expanded(child: Container()),
            FlatButton(color: Colors.blue[700], child: Text("New Game",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18)),
              onPressed: () {

              },)
          ]),
    );
  }

  Container buildSubTable(SudokuSubTable subTable, Color color) {
    return Container(
        padding: EdgeInsets.all(2),
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: buildRowChannel(subTable, 0, color)),
          Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: buildRowChannel(subTable, 1, color)),
          Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: buildRowChannel(subTable, 2, color))
        ]));
  }

  List<Widget> buildRowChannel(SudokuSubTable subTable, int rowChannel, Color color) {
    List<SudokuChannel> dataRowChanel = subTable.subTable[rowChannel];
    List<Widget> listWidget = List();
    for (int col = 0; col < 3; col++) {
      Widget widget = buildChannel(rowChannel, dataRowChanel[col], color,
          onNumberAccept: (data) {
            setState(() {
              sudokuTable.table[subTable.indexRowInTable][subTable.indexColInTable]
                  .subTable[rowChannel][col] = SudokuChannel(value: data);
            });
          }, onRemove: () {
            setState(() {
              sudokuTable.table[subTable.indexRowInTable][subTable.indexColInTable]
                  .subTable[rowChannel][col] = SudokuChannel();
            });
          });
      listWidget.add(widget);
    }
    return listWidget;
  }

  Widget buildChannel(int rowChannel, SudokuChannel channel, Color color,
      {Function(int) onNumberAccept, Function() onRemove}) {
    if (channel.value == 0) {
      return DragTarget(builder: (BuildContext context, List<int> candidateData,
          List<dynamic> rejectedData) {
        return buildChannelEmpty();
      }, onWillAccept: (data) {
        return data >= 0 && data <= 9;
      }, onAccept: (data) {
        onNumberAccept(data);
      });
    } else {
      if (channel.enableMove) {
        return DragTarget(builder: (BuildContext context, List<int> candidateData,
            List<dynamic> rejectedData) {
          return Draggable(
            child: buildChannelValue(channel.value),
            feedback: Material(
                type: MaterialType.transparency, child: buildChannelValue(channel.value)),
            childWhenDragging: buildChannelEmpty(),
            onDragCompleted: () {
              onRemove();
            },
            onDraggableCanceled: (v, o) {
              onRemove();
            },
            data: channel.value,
          );
        }, onWillAccept: (data) {
          return data >= 0 && data <= 9;
        }, onAccept: (data) {
          onNumberAccept(data);
        });
      } else {
        return buildChannelValueFixed(channel.value);
      }
    }
  }

  Container buildChannelEmpty() {
    return Container(
      margin: EdgeInsets.all(1),
      width: channelSize,
      height: channelSize,
      decoration: BoxDecoration(
          color: colorBackgroundChannelEmpty1,
          borderRadius: BorderRadius.all(Radius.circular(4))),
    );
  }

  Widget buildChannelValue(int value) {
    return Container(
      margin: EdgeInsets.all(1),
      width: channelSize,
      height: channelSize,
      decoration: BoxDecoration(
          color: colorBackgroundChannelValue,
          borderRadius: BorderRadius.all(Radius.circular(4))),
      child: Center(
          child: Text(value.toString(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w900))),
    );
  }

  Widget buildChannelValueFixed(int value) {
    return Container(
      margin: EdgeInsets.all(1),
      width: channelSize,
      height: channelSize,
      decoration: BoxDecoration(
          color: colorBackgroundChannelValueFixed,
          borderRadius: BorderRadius.all(Radius.circular(4))),
      child: Center(
          child: Text(value.toString(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w900))),
    );
  }

  List<Widget> buildNumberListTab() {
    List<Widget> listWidget = List();
    for (int i = 1; i <= 9; i++) {
      Widget widget = buildNumberBoxWithDraggable(i);
      listWidget.add(widget);
    }
    return listWidget;
  }

  Widget buildNumberBoxWithDraggable(int i) {
    return Draggable(
      child: buildNumberBox(i),
      feedback:
      Material(type: MaterialType.transparency, child: buildNumberBox(i)),
      data: i,
    );
  }

  Container buildNumberBox(int i) {
    return Container(
        width: channelSize,
        height: channelSize,
        margin: EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
            color: colorBackgroundChannelValue,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Center(child:Text("$i",
            style: TextStyle(
                fontSize: 22,
                color: colorTextNumber,
                fontWeight: FontWeight.w900))));
  }
}
