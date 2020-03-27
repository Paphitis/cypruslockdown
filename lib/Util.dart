import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';

class Util
{

static getTextFieldDecoration(String label, bool showError) {
  return InputDecoration(
    labelText: label,
    fillColor: Colors.red,
    errorText: showError ? "" : null,
    errorBorder: new OutlineInputBorder(
      borderRadius: new BorderRadius.circular(25.0),
      borderSide: new BorderSide(color: Colors.red),
    ),
    border: new OutlineInputBorder(
      borderRadius: new BorderRadius.circular(25.0),
      borderSide: new BorderSide(color: Colors.blue),
    ),
    //fillColor: Colors.green
  );
}


static send(String message) async {
  try {
    String _result =
    await sendSMS(message: message, recipients: ["8998"]);
    //  setState(() => _message = _result);
    print(_result);
  } catch (error) {
    //   setState(() => _message = error.toString());
    print(error.toString());
  }
}

static Future<bool> canSendSMS() async {
  bool _result = await canSendSMS();
  print(_result ? 'This unit can send SMS' : 'This unit cannot send SMS');
  return _result;
}



}