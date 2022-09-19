import 'package:flutter/material.dart';

class RowAddressWidget extends StatelessWidget {
  const RowAddressWidget({
    Key? key, required this.keyValue, required this.value,
  }) : super(key: key);

  final String keyValue;
  final String value;
  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(keyValue),
          Text(value)
        ],
      ),
    );
  }
}