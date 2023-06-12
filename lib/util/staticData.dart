import 'package:flutter/material.dart';

class StaticData {
  static commonLoader() {
    return SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          color: Colors.white,
        ));
  }
}
