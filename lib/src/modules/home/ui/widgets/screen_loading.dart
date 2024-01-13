import 'package:flutter/material.dart';

class ScreenLoading extends StatelessWidget {
  final String? label;

  const ScreenLoading({
    super.key,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Container(
          color: Colors.grey.withOpacity(.5),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 16),
                Text(label ?? 'Carregando')
              ],
            ),
          )),
    );
  }
}
