import 'package:flutter/material.dart';

//Create CircularButton
class ImageButton extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final ImageIcon icon;
  final Function onClick;

  ImageButton({this.color, this.width, this.icon, this.onClick, this.height});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      width: width,
      height: height,
      child: IconButton(icon: icon, enableFeedback: true, onPressed: onClick),
    );
  }
}
