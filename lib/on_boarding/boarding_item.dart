import 'package:flutter/material.dart';
import 'onBoardingScreen.dart';


class BoardingItem extends StatelessWidget {
  final BoardingModel model;

  const BoardingItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Image.asset(model.image)),
        const SizedBox(height: 30),
        Text(
          model.title,
          style: const TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16.0),
        Text(
          model.body,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
