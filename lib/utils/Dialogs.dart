import 'package:codeforces_assistant/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class EmailNotRegisteredPopUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      title: Text('Oops 😢, you\'re not registered.....'),
      content: Text('It\'s a new email id, so Sign Up and enjoy ☺'),
      actions: [
        TextButton(
          child: Text(
            'Ok',
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

class EmailAlreadyRegistered extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      title: Text('Email Already Registered!'),
      content:
          Text('You have already registered. Please use the Login Page 🥺.'),
      actions: [
        TextButton(
          child: Text('Ok'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

class ChangeHandleDialog extends StatelessWidget {
  void Function(String) onPressed;
  TextEditingController handleEditingController = TextEditingController();

  ChangeHandleDialog({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      title: Text('Change Handle'),
      content: CustomTextField(
        hintText: 'Enter Handle',
        controller: handleEditingController,
      ),
      actions: [
        TextButton(
          child: Text('Change'),
          onPressed: () {
            onPressed(handleEditingController.text);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
