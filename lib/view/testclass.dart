import 'package:flutter/material.dart';

class TestClass extends StatefulWidget {
  const TestClass({Key? key}) : super(key: key);

  @override
  _TestClassState createState() => _TestClassState();
}

class _TestClassState extends State<TestClass> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
    );
  }
}
