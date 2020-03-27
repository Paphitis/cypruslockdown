import 'package:cypruslockdown/BottomSheetWidget.dart';
import 'package:cypruslockdown/Locale/Languages.dart';
import 'package:cypruslockdown/Preferences.dart';
import 'package:cypruslockdown/RadioListWidget.dart';
import 'package:cypruslockdown/Util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _reason;
  String _idNumber;
  String _postalCode;
  TextEditingController _controllerID;
  TextEditingController _controllerPostCode;
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  bool _idError = false;
  bool _postalCodeError = false;
  bool _reasonError = false;
  FocusNode _idFocus = FocusNode();
  FocusNode _postalFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    Localise.setLang(Language.greek);
    _controllerID = TextEditingController();
    _controllerPostCode = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((dou) {
      _getPrefs();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: _screen(),
      ),
    );
  }

  setSelectedRadioTile(String val) {
    setState(() {
      _reasonError = false;
      _reason = val;
    });
  }

  _getReason() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: _reasonError
            ? BoxDecoration(border: Border.all(color: Colors.red, width: 1))
            : null,
        child: Column(
          children: <Widget>[
            RadioListWidget(
              index: 1,
              title: "reason1_short",
              groupValue: _reason,
              onPressed: () {
                _getBottomSheet(1);
              },
              onChanged: (value) {
                setSelectedRadioTile(value);
              },
            ),
            RadioListWidget(
              index: 2,
              title: "reason2_short",
              groupValue: _reason,
              onPressed: () {
                _getBottomSheet(2);
              },
              onChanged: (value) {
                setSelectedRadioTile(value);
              },
            ),
            RadioListWidget(
              index: 3,
              title: "reason3_short",
              groupValue: _reason,
              onPressed: () {
                _getBottomSheet(3);
              },
              onChanged: (value) {
                setSelectedRadioTile(value);
              },
            ),
            RadioListWidget(
              index: 4,
              title: "reason4_short",
              groupValue: _reason,
              onPressed: () {
                _getBottomSheet(4);
              },
              onChanged: (value) {
                setSelectedRadioTile(value);
              },
            ),
            RadioListWidget(
              index: 5,
              title: "reason5_short",
              groupValue: _reason,
              onPressed: () {
                _getBottomSheet(5);
              },
              onChanged: (value) {
                setSelectedRadioTile(value);
              },
            ),
            RadioListWidget(
              index: 6,
              title: "reason6_short",
              groupValue: _reason,
              onPressed: () {
                _getBottomSheet(6);
              },
              onChanged: (value) {
                setSelectedRadioTile(value);
              },
            ),
            RadioListWidget(
              index: 7,
              title: "reason7_short",
              groupValue: _reason,
              onPressed: () {
                _getBottomSheet(7);
              },
              onChanged: (value) {
                setSelectedRadioTile(value);
              },
            ),
            RadioListWidget(
              index: 8,
              title: "reason8_short",
              groupValue: _reason,
              onPressed: () {
                _getBottomSheet(8);
              },
              onChanged: (value) {
                setSelectedRadioTile(value);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _getBottomSheet(int index) {
    _globalKey.currentState
      ..showBottomSheet<Null>((BuildContext context) {
        return BottomSheetWidget(
          index: index,
        );
      });
  }

  _getId() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: TextFormField(
        focusNode: _idFocus,
        textInputAction: TextInputAction.next,
        inputFormatters: [
          LengthLimitingTextInputFormatter(10),
          WhitelistingTextInputFormatter(RegExp("[A-Za-zα-ωΑ-Ω0-9]")),
        ],
        onFieldSubmitted: (item) {
          _idFocus.unfocus();
          FocusScope.of(context).requestFocus(_postalFocus);
        },
        controller: _controllerID,
        decoration: Util.getTextFieldDecoration(
            Localise.getString("id_number"), _idError),
        onChanged: (value) {
          if (value != null && value.length != 0) {
            setState(() {
              _idError = false;
            });
          }
        },
      ),
    );
  }

  _getPostCode() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: TextFormField(
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(4),
          BlacklistingTextInputFormatter(RegExp("^[/./,]")),
        ],
        controller: _controllerPostCode,
        focusNode: _postalFocus,
        textInputAction: TextInputAction.done,
        onFieldSubmitted: (item) {
          _validate();
        },
        decoration: Util.getTextFieldDecoration(
            Localise.getString("postcode"), _postalCodeError),
        onChanged: (value) {
          if (value != null && value.length != 0) {
            setState(() {
              _postalCodeError = false;
            });
          }
        },
      ),
    );
  }

  _validate() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    setState(() {
      _idError = false;
      _postalCodeError = false;
      _reasonError = false;
    });
    _idNumber = _controllerID.text.trim();
    _postalCode = _controllerPostCode.text.trim();

    if (_reason == null) {
      setState(() {
        _reasonError = true;
      });
    }

    if (_idNumber == null || _idNumber.length == 0) {
      setState(() {
        _idError = true;
      });
    }
    if (_postalCode == null || _postalCode.length == 0) {
      setState(() {
        _postalCodeError = true;
      });
    }

    if (!_reasonError && !_idError && !_postalCodeError) {
      SharedPreferences _prefs = await SharedPreferences.getInstance();

      _prefs.setString(pref_id, '$_idNumber');
      _prefs.setString(pref_post, '$_postalCode');

      Util.canSend().then((canSend) {
        String message = "$_reason $_idNumber $_postalCode";

        if (canSend) {
          Util.send(message);
        } else {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(Localise.getString("popup_title")),
                  content: Text("SMS : $message"),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("OK"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              });
        }
      });
    }
  }

  void _getPrefs() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      if (_prefs.containsKey(pref_id)) {
        _controllerID.text = _prefs.getString(pref_id);
      }
      if (_prefs.containsKey(pref_post)) {
        _controllerPostCode.text = _prefs.getString(pref_post);
      }
      if (_prefs.containsKey(pref_lang)) {
        Localise.setLang(_prefs.getString(pref_lang) == 'GR'
            ? Language.greek
            : Language.english);
      }
    });
  }

  _appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      title: _appBarTitle(),
      actions: _appBarActions(),
    );
  }

  _appBarTitle() {
    return Column(
      children: <Widget>[
        Text(
          Localise.getString("title"),
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        Text(
          Localise.getString("subtitle"),
          style: TextStyle(color: Colors.grey, fontSize: 15),
        ),
      ],
    );
  }

  _appBarActions() {
    return <Widget>[
      _languageButton(),
    ];
  }

  _languageButton() {
    return FlatButton(
        onPressed: () async {
          setState(() {
            Language _language = Localise.language == Language.greek
                ? Language.english
                : Language.greek;
            Localise.setLang(_language);
          });

          SharedPreferences _prefs = await SharedPreferences.getInstance();

          _prefs.setString(
              pref_lang, Localise.language == Language.greek ? "GR" : "EN");
        },
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.blue),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                Localise.language == Language.greek ? "EN" : "GR",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )));
  }

  _screen() {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      resizeToAvoidBottomInset: true,
      key: _globalKey,
      appBar: _appBar(),
      body: _body(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _validate();
        },
        tooltip: 'Send',
        child: Icon(Icons.send),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _body() {
    return ListView(
      children: <Widget>[
        if (_reasonError) ...[
          SizedBox(
            height: 20,
          ),
          Center(
              child: Text(
            Localise.getString("reason_error"),
            style: TextStyle(color: Colors.red, fontSize: 20),
          )),
        ],
        _getReason(),
        SizedBox(
          height: 20,
        ),
        _getId(),
        SizedBox(
          height: 20,
        ),
        _getPostCode(),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
