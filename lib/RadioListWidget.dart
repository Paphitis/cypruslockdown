import 'package:cypruslockdown/Locale/Languages.dart';
import 'package:flutter/material.dart';

class RadioListWidget extends StatelessWidget {
  final String title;
  final int index;
  final String groupValue;
  final ValueChanged<String> onChanged;
  final Function onPressed;

  const RadioListWidget({
    @required this.index,
    @required this.title,
    @required this.groupValue,
    @required this.onChanged,
    @required this.onPressed,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      value: "$index",
      groupValue: groupValue,
      onChanged: (value) {
        onChanged(value);
      },
      title: Text(Localise.getString(title)),
      secondary: IconButton(
        icon: Icon(Icons.info_outline),
        onPressed: onPressed,
      ),
    );
  }
}
