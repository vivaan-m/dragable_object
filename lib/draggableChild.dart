import 'package:flutter/material.dart';

class PositionedDraggableIcon extends StatefulWidget {
  final double top;
  final double left;
  final Size size ;

  PositionedDraggableIcon({required this.top, required this.left,required this.size});

  @override
  _PositionedDraggableIconState createState() => _PositionedDraggableIconState();
}

class _PositionedDraggableIconState extends State<PositionedDraggableIcon> {
  GlobalKey _key = GlobalKey();
  late double top, left;
  late Size size;
  late double xOff, yOff;

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback(_afterLayout);
    top = widget.top;
    left = widget.left;
    size = widget.size;
    super.initState();
  }

  void _getRenderOffsets() {
    final RenderBox renderBoxWidget = _key.currentContext?.findRenderObject() as RenderBox;
    final offset = renderBoxWidget.localToGlobal(Offset.zero);

    yOff = offset.dy - top;
    xOff = offset.dx - left;
  }

  void _afterLayout(_) {
    _getRenderOffsets();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      key: _key,
      top: top,
      left: left,
      child: Draggable(
        child: Icon(Icons.input),
        feedback: Icon(Icons.input),
        childWhenDragging: Container(),
        onDragEnd: (drag) {

          print(Offset(drag.offset.dx-20,drag.offset.dy-80));
          bool inside = size.contains(Offset(drag.offset.dx,drag.offset.dy-80));


          if(inside) {
            setState(() {
              top = drag.offset.dy - yOff;
              left = drag.offset.dx - xOff;
            });
          }else{

          }
        },
      ),
    );
  }
}