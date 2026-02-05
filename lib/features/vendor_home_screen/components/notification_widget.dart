import 'package:flutter/material.dart';

class RsvpNotification extends StatelessWidget {
  final String name;
  final String message;
  Color iconContainerColor;
  IconData status_icons;
  VoidCallback onPressed;
   RsvpNotification({
    Key? key,
    required this.name,
    required this.message,
    required this.iconContainerColor,
    required this.status_icons,
     required this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        elevation: 5,
        child: ListTile(
          onTap: onPressed,
          contentPadding: const EdgeInsets.all(10),
          leading: CircleAvatar(
            backgroundColor: iconContainerColor,
            child: Icon(status_icons, color: Colors.white),
          ),
          title: Text(
            name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(message),
            ],
          ),
          trailing: Icon(Icons.more_vert),
        ),
      ),
    );
  }
}
