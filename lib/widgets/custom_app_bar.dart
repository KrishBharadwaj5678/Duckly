import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("Duckly", style: TextStyle(fontSize: 21)),
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          SystemNavigator.pop();
        },
        icon: Icon(Icons.arrow_back, size: 25),
      ),
    );
  }
}
