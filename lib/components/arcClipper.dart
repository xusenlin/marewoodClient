import 'package:flutter/material.dart';
//坐标从左上角开始
class ArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, 0); // 从左上角开始，画到弧度的起点
    path.quadraticBezierTo(size.width / 2, size.height/2, size.width, 0); // 使用二次贝塞尔曲线绘制向下的弧度
    path.lineTo(size.width, size.height); // 画到右下角
    path.lineTo(0, size.height); // 画到左下角
    path.close(); // 关闭路径
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}