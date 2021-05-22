import 'package:flutter/material.dart';

class Utility{

  static Utility utility;

  static Utility getInstance(){
    if(utility == null){
      utility = Utility();
    }
    return utility;
  }

  showAlertDialog(BuildContext context, String alertTitle, String alertMessage, [String btnText='OK']){
    // set up the buttons
    // Widget cancelButton = FlatButton(
    //   child: Text("Cancel"),
    //   onPressed:  () {
    //     Navigator.pop(context);
    //   },
    // );
    Widget okButton = FlatButton(
      child: Text(btnText),
      color: Colors.green,
      onPressed:  () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(alertTitle),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(alertMessage)
          ],
        ),
      ),
      actions: [
        // cancelButton,
        Padding(
          padding: const EdgeInsets.only(right: 20.0, bottom: 10.0),
          child: okButton,
        ),
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );

  }

}