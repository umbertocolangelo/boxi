import 'package:boxi/pages/profile_page.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatefulWidget {
  final String label;

  const AppBarWidget({required this.label, Key? key}) : super(key: key);

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        widget.label),
      actions: [
        IconButton(
          icon: Icon(Icons.person),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(label: 'Profile'),
              ),
            );
          },
        ),
      ],
    );
      
  }
}
