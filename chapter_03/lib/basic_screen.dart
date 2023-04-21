import 'package:chapter_03/immutable_widget.dart';
import 'package:chapter_03/text_layout.dart';
import 'package:flutter/material.dart';

class BasicScreen extends StatelessWidget {
  const BasicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text('Welcome to Flutter'),
        actions: const <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Icon(Icons.edit),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          AspectRatio(
            aspectRatio: 1.0,
            child: ImmutableWidget(),
          ),
          TextLayout(),
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.lightBlue,
          child: const Center(
            child: Text('I am a drawer'),
          ),
        ),
      ),
    );
  }

}