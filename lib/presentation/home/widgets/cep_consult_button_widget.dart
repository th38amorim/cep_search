import 'package:flutter/material.dart';

class CepConsultButtonWidget extends StatelessWidget {
  const CepConsultButtonWidget({
    Key? key, required this.onPressed,
  }) : super(key: key);

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: 200,
      child: ElevatedButton(
        onPressed: onPressed, 
        child: const Text('Consultar'),
      ),
    );
  }
}