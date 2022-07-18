import 'package:flutter/material.dart';

import 'draggableChild.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey containerKey = GlobalKey();

  var containerOffset;

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback(_afterLayout);
    super.initState();
  }
  void _getRenderOffsets() {
    containerOffset = containerKey.currentContext?.size;
    print(containerOffset);
  }
  void _afterLayout(_){
_getRenderOffsets();
  }
  bool changeView = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Container(
        color: Colors.amber,
        height: 320,
        width: 320,
        key:containerKey,
       // margin:const EdgeInsets.all(10),
        child: Stack(
          children: [

           containerOffset!=null? PositionedDraggableIcon(left: 10,top: 10,size: containerOffset,):SizedBox()
          ],
        ),
      ),

    );
  }
}
