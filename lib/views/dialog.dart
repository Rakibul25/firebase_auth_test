import 'package:flutter/material.dart';

class loadingDialog extends StatelessWidget {
  final String? message;
  loadingDialog({required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 14,bottom: 14),
            child: const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.pinkAccent),
            ),
          ),

          Text(
            message.toString(),
          )
        ],
      ),
    );
  }

}
