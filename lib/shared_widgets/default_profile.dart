import 'package:flutter/material.dart';

class DefaultProfile extends StatelessWidget {
  const DefaultProfile({
    super.key,
    this.size = 60,
    this.color,
  });
  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color ?? Colors.grey.shade200,
      ),
      child: const Icon(
        Icons.person,
        size: 32,
        color: Colors.black54,
      ),
    );
  }
}
