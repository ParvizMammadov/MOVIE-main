import 'package:flutter/material.dart';

class myListTile extends StatelessWidget {
  final void Function()? ontap;
  final IconData icon;
  final String text;
  const myListTile({
    Key? key,
    required this.ontap,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: ontap,
      leading: Icon(
        icon,
        color: Colors.white,
        size: 30,
      ),
      title: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
    );
  }
}