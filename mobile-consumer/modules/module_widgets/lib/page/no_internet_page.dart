import 'package:flutter/material.dart';

class NoInternetPage extends StatelessWidget {
  final void Function() onTap;

  NoInternetPage({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: onTap,
          child: Text('No internet connection'),
        ),
      ),
    );
  }
}
