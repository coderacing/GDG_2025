import 'package:flutter/material.dart';

class BkgImgWidget extends StatelessWidget {
  Widget? childWidget;

  BkgImgWidget({child = Widget}) {
    this.childWidget = child;
  }
  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage("assets/images/capsule.png"),
          repeat: ImageRepeat.repeat,
        ),
      ),
      child: childWidget /* add child content content here */,
    );
  }
}
