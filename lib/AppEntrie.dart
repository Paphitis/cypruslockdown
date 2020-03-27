import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Language {
  greek,
  english,
}

const pref_id = "pref_id";
const pref_post = "pref_post";
const pref_lang = "pref_lang";

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _reason;
  String _idNumber;
  String _postalCode;
  TextEditingController _controller;
  TextEditingController _controllerPostCode;
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  Language _language = Language.greek;
  bool _idError = false;
  bool _postalCodeError = false;
  bool _reasonError = false;
  FocusNode _idFocus = FocusNode();
  FocusNode _postalFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
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
        child: Scaffold(
          resizeToAvoidBottomPadding: true,
          resizeToAvoidBottomInset: true,
          key: _globalKey,
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Column(
              children: <Widget>[
                Text("Cyprus Lockdown", style: TextStyle(color: Colors.black, fontSize: 20),),
                Text( _language == Language.greek ?"Εργαλείο προετοιμασίας SMS":"SMS preparation tool", style: TextStyle(color: Colors.grey, fontSize: 15),),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () async {

                    setState(() {
                      _language = _language == Language.greek
                          ? Language.english
                          : Language.greek;
                    });

                    SharedPreferences _prefs = await SharedPreferences.getInstance();
                    _prefs.setString(pref_lang, _language == Language.greek ? "GR" : "EN");

                  },
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.blue),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          _language == Language.greek ? "EN" : "GR",



                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ))),
            ],
          ),
          body: ListView(
            children: <Widget>[
              if (_reasonError) ...[
                SizedBox(
                  height: 20,
                ),
                Center(
                    child: Text(
                  _language == Language.greek
                      ? "Παρακαλώ επιλέξτε ένα"
                      : "Please choose one",
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
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _validate();
            },
            tooltip: 'Send',
            child: Icon(Icons.send),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ),
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
            RadioListTile(
                value: "1",
                groupValue: _reason,
                onChanged: (value) {
                  setSelectedRadioTile(value);
                },
                title: Text(_language == Language.greek
                    ? "1. Φαρμακείο, αιμοδοσία ή  γιατρό"
                    : "1. Pharmacy, blood donation or doctor"),
                secondary: IconButton(
                    icon: Icon(Icons.info_outline),
                    onPressed: () {
                      _getBottomSheet(1);
                    })),
            RadioListTile(
                value: "2",
                groupValue: _reason,
                onChanged: (value) {
                  setSelectedRadioTile(value);
                },
                title: Text(_language == Language.greek
                    ? "2. Για αγορά ή προμήθεια αγαθών/υπηρεσιών"
                    : "2. For the purchase or supply of goods / services"),
                secondary: IconButton(
                    icon: Icon(Icons.info_outline),
                    onPressed: () {
                      _getBottomSheet(2);
                    })),
            RadioListTile(
                value: "3",
                groupValue: _reason,
                onChanged: (value) {
                  setSelectedRadioTile(value);
                },
                title: Text(
                    _language == Language.greek ? "3. Τράπεζα" : "3. Bank"),
                secondary: IconButton(
                    icon: Icon(Icons.info_outline),
                    onPressed: () {
                      _getBottomSheet(3);
                    })),
            RadioListTile(
                value: "4",
                groupValue: _reason,
                onChanged: (value) {
                  setSelectedRadioTile(value);
                },
                title: Text(_language == Language.greek
                    ? "4. Αναγκαίες επισκέψεις σε κρατικές υπηρεσίες"
                    : "4. Necessary visits to government agencies"),
                secondary: IconButton(
                    icon: Icon(Icons.info_outline),
                    onPressed: () {
                      _getBottomSheet(4);
                    })),
            RadioListTile(
                value: "5",
                groupValue: _reason,
                onChanged: (value) {
                  setSelectedRadioTile(value);
                },
                title: Text(_language == Language.greek
                    ? "5. Παροχή βοήθειας σε άτομα που αδυνατούν να αυτοεξυπηρετηθούν"
                    : "5. Assisting people who are unable to self-serve"),
                secondary: IconButton(
                    icon: Icon(Icons.info_outline),
                    onPressed: () {
                      _getBottomSheet(5);
                    })),
            RadioListTile(
                value: "6",
                groupValue: _reason,
                onChanged: (value) {
                  setSelectedRadioTile(value);
                },
                title: Text(_language == Language.greek
                    ? "6. Σωματική άσκηση ή ανάγκες κατοικίδιου ζώου"
                    : "6. Physical exercise or pet needs"),
                secondary: IconButton(
                    icon: Icon(Icons.info_outline),
                    onPressed: () {
                      _getBottomSheet(6);
                    })),
            RadioListTile(
                value: "7",
                groupValue: _reason,
                onChanged: (value) {
                  setSelectedRadioTile(value);
                },
                title: Text(_language == Language.greek
                    ? "7. Κηδεία, γάμος, βάφτιση"
                    : "7. Funeral, marriage, baptism"),
                secondary: IconButton(
                    icon: Icon(Icons.info_outline),
                    onPressed: () {
                      _getBottomSheet(7);
                    })),
            RadioListTile(
                value: "8",
                groupValue: _reason,
                onChanged: (value) {
                  setSelectedRadioTile(value);
                },
                title: Text(_language == Language.greek
                    ? "8. Οποιοσδήποτε άλλος σκοπός μετακίνησης"
                    : "8. Any other purpose for travel"),
                secondary: IconButton(
                    icon: Icon(Icons.info_outline),
                    onPressed: () {
                      _getBottomSheet(8);
                    })),
          ],
        ),
      ),
    );
  }

  void _getBottomSheet(int index) {
    List<String> _reasonsGR = [
      'Μετάβαση σε φαρμακείο ή για αιμοδοσία ή επίσκεψη σε γιατρό',
      'Μετάβαση σε κατάστημα για αγορά ή προμήθεια αγαθών/υπηρεσιών πρώτης ανάγκης',
      'Μετάβαση σε τράπεζα, στο μέτρο που δεν είναι δυνατή η ηλεκτρονική συναλλαγή',
      'Απόλυτα αναγκαίες επισκέψεις σε κρατικές υπηρεσίες ή υπηρεσίες του ευρύτερου δημόσιου τομέα και της τοπικής αυτοδιοίκησης',
      'Διακίνηση για παροχή βοήθειας σε άτομα που αδυνατούν να αυτοεξυπηρετηθούν ή που οφείλουν να αυτοπροστατευθούν ή βρίσκονται σε αυτοπεριορισμό ή/και σε χώρους υποχρεωτικού περιορισμού (καραντίνα)',
      'Μετακίνηση για σωματική άσκηση ή για τις ανάγκες κατοικίδιου ζώου, εφόσον δεν υπερβαίνουν τα δύο άτομα και περιορίζονται σε γειτνιάζουσες με την κατοικία τους περιοχές',
      'Μετάβαση σε τελετή (π.χ. κηδεία, γάμος, βάφτιση) από συγγενείς πρώτου και δεύτερου βαθμού που δεν υπερβαίνουν τον αριθμό των 10 προσώπων',
      'Οποιοσδήποτε άλλος σκοπός μετακίνησης που μπορεί να δικαιολογηθεί με βάση τα μέτρα απαγόρευσης της κυκλοφορίας'
    ];
    List<String> _reasonsEN = [
      'Go to pharmacy or donate blood or visit a doctor',
      'Going to a shop to buy or supply essentials / services',
      'Go to bank, as long as electronic transaction is not possible',
      'Absolutely necessary visits to public services or services of the wider public sector and local government',
      'To help people who are unable to self-serve or who need to protect themselves or are in self-restraint and / or in quarantine areas',
      'Moving for physical activity or for the needs of the pet, provided they do not exceed two persons and are confined to areas adjacent to their home',
      'Going to a ceremony (eg funeral, marriage, baptism) by first and second degree relatives not exceeding 10 persons',
      'Any other purpose of travel which may be justified by the prohibition measures '
    ];

    _globalKey.currentState
      ..showBottomSheet<Null>((BuildContext context) {
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
                _language == Language.greek
                    ? "Λόγος :"
                    : "Purpose :" + "$index",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    child: Text(
                  _language == Language.greek
                      ? _reasonsGR[index - 1]
                      : _reasonsEN[index - 1],
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
      });
  }

  _getId() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: TextFormField(
        focusNode: _idFocus,
        textInputAction: TextInputAction.next,
        inputFormatters:[
          LengthLimitingTextInputFormatter(10),
          WhitelistingTextInputFormatter(RegExp("[A-Za-zα-ωΑ-Ω0-9]")),
        ] ,
        onFieldSubmitted: (item) {
          _idFocus.unfocus();
          FocusScope.of(context).requestFocus(_postalFocus);
        },
        controller: _controller,
        decoration: _getTextFieldDecoration(
            _language == Language.greek
                ? "Αρ. Ταυτότητας/Διαβατηρίου"
                : "ID Numbner/Passport Number.",
            _idError),
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
        inputFormatters:[
          LengthLimitingTextInputFormatter(4),
          BlacklistingTextInputFormatter(RegExp("^[/./,]")),
        ] ,
        controller: _controllerPostCode,
        focusNode: _postalFocus,
        textInputAction: TextInputAction.done,
        onFieldSubmitted: (item) {
            _validate();
        },
        decoration: _getTextFieldDecoration(
            _language == Language.greek ? "Ταχυδρομικός Κώδικας" : "Postcode",
            _postalCodeError),
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



  _getTextFieldDecoration(String label, bool showError) {
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

  _validate() async{
    FocusScope.of(context).requestFocus(new FocusNode());
    setState(() {
      _idError = false;
      _postalCodeError = false;
      _reasonError = false;
    });
    _idNumber = _controller.text.trim();
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

       _canSendSMS().then((canSend){
         String message = "$_reason $_idNumber $_postalCode";
         if(canSend){
           _sendSMS(message);
         }else{

           showDialog(context: context, builder: (context){

             return AlertDialog(
               title: Text(_language == Language.greek ? "Η συσκευή σας δεν μπορεί να στείλει sms" : "Your device can not send sms"),

               content: Text("SMS : $message"),

               actions: <Widget>[
                 FlatButton(child: Text("OK"), onPressed: (){Navigator.of(context).pop();},),
               ],

             );


           });

         }

       });



    }
  }

  void _sendSMS(String message) async {
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

  Future<bool> _canSendSMS() async {
    bool _result = await canSendSMS();
    print(_result ? 'This unit can send SMS' : 'This unit cannot send SMS');
    return _result;
  }

  void _getPrefs() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      if (_prefs.containsKey(pref_id)) {
        _controller.text = _prefs.getString(pref_id);
      }
      if (_prefs.containsKey(pref_post)) {
        _controllerPostCode.text = _prefs.getString(pref_post);
      }
      if (_prefs.containsKey(pref_lang)) {
        _language = _prefs.getString(pref_lang) == 'GR' ? Language.greek : Language.english;
      }
    });
  }
}
