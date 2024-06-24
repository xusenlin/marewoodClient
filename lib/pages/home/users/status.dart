import 'package:flutter/material.dart';

class Status extends StatelessWidget{
  const Status({super.key, required this.status});

  final int status;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case 2:
        return const Icon(Icons.remove_circle_outline,color: Colors.redAccent,size: 18);
      case 1:
        return const Icon(Icons.check_circle_outline,color: Colors.green,size: 18);
      default:
        return const Icon(Icons.panorama_fish_eye_outlined,color: Colors.grey,size: 18);
    }
  }

}