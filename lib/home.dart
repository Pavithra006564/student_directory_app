import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 14, 88, 149),
        title: Text(
          "Student Directory",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add),
        onPressed: () {},
        backgroundColor: const Color.fromARGB(255, 14, 86, 145),
        foregroundColor: Colors.white,
      ),
    );
  }
}
