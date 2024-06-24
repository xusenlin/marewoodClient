import 'package:flutter/material.dart';

void terminalOutDisplay(BuildContext context,String out){
  showModalBottomSheet(
    showDragHandle: true,
    backgroundColor: Colors.white,
    context: context,
    builder: (BuildContext context) {
      return SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Text(
              out,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 12
              )
            ),
          )
      );
    },
  );
}