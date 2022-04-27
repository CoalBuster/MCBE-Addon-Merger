import 'package:flutter/material.dart';

class SimpleTile extends StatelessWidget {
  final String title;
  final String? subtitle;

  const SimpleTile({
    required this.title,
    this.subtitle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: subtitle == null ? null : Text(subtitle!),
    );
  }
}
