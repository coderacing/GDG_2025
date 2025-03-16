import 'package:flutter/material.dart';
import 'package:simple_shadow/simple_shadow.dart';

class AppLogo extends StatelessWidget {
  final double? width;
  final double? height;
  const AppLogo({
    super.key,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleShadow(
      child: Image.asset(
        'assets/images/app_logo.png',
        width: width ?? 100,
        height: height ?? 100,
        fit: BoxFit.contain,
      ),
    );
  }
}
