import 'package:flutter/material.dart';

class BkgImgWidget extends StatelessWidget {
  Widget? childWidget;

  BkgImgWidget({super.key, child = Widget}) {
    childWidget = child;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/capsule.png"),
          repeat: ImageRepeat.repeat,
        ),
      ),
      child: childWidget /* add child content content here */,
    );
  }
}
