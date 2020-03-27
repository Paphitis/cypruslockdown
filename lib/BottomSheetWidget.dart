import 'package:flutter/material.dart';
import 'package:cypruslockdown/Locale/Languages.dart';

class BottomSheetWidget extends StatelessWidget {

  final int index;

  const BottomSheetWidget({ @required  this.index,
  Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Text(
            Localise.getString("sheet_title"),
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                child: Text(
                  Localise.getString("reason${index}"),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                )),
          ),
          SizedBox(
            height: 30,
          ),
          RaisedButton(
            color: Colors.blue,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(18))),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}