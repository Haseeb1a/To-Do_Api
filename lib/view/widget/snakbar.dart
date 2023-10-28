import 'package:flutter/material.dart';
  void showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red, // Change the color as needed
      ),
    );
  }
    void showSuccess(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.green, // Change the color as needed
      ),
    );
  }
class Show extends StatelessWidget {
  const Show({Key? key}) : super(key: key);





  @override
  Widget build(BuildContext context) {
    // Your widget content here
    return Container();
  }
}
