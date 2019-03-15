import 'package:flutter/material.dart';
import 'dart:async';

enum Answers { YES, NO, MAYBE }

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MyApp> {
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey();
  String _stringSimpleText = 'Hello World';
  String _stringTextField;
  String _stringSimpleDialog = '';
  String _stringFAB = '';
  String _stringFooterButtons = '';
  String _stringSelectDate = '';
  int _intIconButton = 0;
  String _stringNavigatorBar = '';
  num _intNavigatorBar = 0;
  List<BottomNavigationBarItem> _listNavigatorBar;
  int _intRadio01 = 0;
  int _intRadio02 = 0;
  bool _boolCheckBox01 = false;
  bool _boolCheckBox02 = false;
  bool _boolSwitch01 = false;
  bool _boolSwitch02 = false;
  double _doubleSlider = 0.0;
  int _intAppBar = 0;

  @override
  void initState() {
    _listNavigatorBar = List();
    _listNavigatorBar.add(BottomNavigationBarItem(
        icon: Icon(Icons.people), title: Text('people')));
    _listNavigatorBar.add(BottomNavigationBarItem(
        icon: Icon(Icons.weekend), title: Text('weekend')));
    _listNavigatorBar.add(BottomNavigationBarItem(
        icon: Icon(Icons.message), title: Text('message')));
    super.initState();
  }

  Future _askUserSimpleDialog() async {
    switch (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text('Do you like Flutter?'),
            children: <Widget>[
              SimpleDialogOption(
                child: Text('Yes!'),
                onPressed: () {
                  Navigator.pop(context, Answers.YES);
                },
              ),
              SimpleDialogOption(
                child: Text('No!'),
                onPressed: () {
                  Navigator.pop(context, Answers.NO);
                },
              ),
              SimpleDialogOption(
                child: Text('Maybe!'),
                onPressed: () {
                  Navigator.pop(context, Answers.MAYBE);
                },
              ),
            ],
          );
        })) {
      case Answers.YES:
        _setSimpleDialogValue('Yes');
        break;
      case Answers.NO:
        _setSimpleDialogValue('No');
        break;
      case Answers.MAYBE:
        _setSimpleDialogValue('Maybe');
        break;
    }
  }

  void _setSimpleDialogValue(String value) =>
      setState(() => _stringSimpleDialog = value);

  void _onPressedFB(String value) =>
      setState(() => _stringFooterButtons = value);

  void _addAB() => setState(() => _intAppBar++);

  void _removeAB() => setState(() => _intAppBar--);

  Future _selectDate() async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2016),
        lastDate: DateTime(2020));

    if (picked != null) setState(() => _stringSelectDate = picked.toString());
  }

  Future _showAlert(String message) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(message),
            actions: <Widget>[
              FlatButton(
                  onPressed: () => Navigator.pop(context), child: Text('Ok'))
            ],
          );
        });
  }

  void _showBar() => _scaffoldState.currentState
      .showSnackBar(SnackBar(content: (Text('Hello from SnackBar'))));

  void _setSlider(double value) => setState(() => _doubleSlider = value);

  void _onSwitch01(bool value) => setState(() => _boolSwitch01 = value);

  void _onSwitch02(bool value) => setState(() => _boolSwitch02 = value);

  void _setRadio01(int value) => setState(() => _intRadio01 = value);

  void _setRadio02(int value) => setState(() => _intRadio02 = value);

  Widget makeRadio() {
    List<Widget> radio = List<Widget>();

    for (int i = 0; i < 2; i++) {
      radio.add(
          Radio(value: i, groupValue: _intRadio01, onChanged: _setRadio01));
    }

    Column column = Column(
      children: radio,
    );
    return column;
  }

  Widget makeRadioTiles() {
    List<Widget> radio = List<Widget>();

    for (int i = 0; i < 2; i++) {
      radio.add(RadioListTile(
        value: i,
        groupValue: _intRadio02,
        onChanged: _setRadio02,
        activeColor: Colors.lightBlue,
        controlAffinity: ListTileControlAffinity.trailing,
        title: Text('Item: $i'),
      ));
    }

    Column column = Column(
      children: radio,
    );
    return column;
  }

  textFromTextField() {
    if (_stringTextField == null) {
      return Text('Enter text to the field');
    } else {
      return Text(_stringTextField);
    }
  }

  void _changeCheckBox01(bool value) => setState(() => _boolCheckBox01 = value);

  void _changeCheckBox02(bool value) => setState(() => _boolCheckBox02 = value);

  void _onTextChange(String value) =>
      setState(() => _stringTextField = 'Change: $value');

  void _onTextSubmit(String value) =>
      setState(() => _stringTextField = 'Submit: $value');

  void _onPressedRaisedButton() =>
      setState(() => _stringSimpleText = 'My name is Kirill');

  void _onClickFlatButton() =>
      setState(() => _stringSimpleText = DateTime.now().toString());

  void _addIconButton() => setState(() => _intIconButton++);

  void _subIconButton() => setState(() => _intIconButton--);

  void _showBottom() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'I am ModalBottomSheet',
                  style: TextStyle(
                      color: Colors.redAccent, fontWeight: FontWeight.bold),
                ),
                RaisedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Close'),
                )
              ],
            ),
          );
        });
  }

  void _dateTimeFABOnClick() =>
      setState(() => _stringFAB = DateTime.now().toString());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldState,
        appBar: AppBar(
          title: Text('Name here'),
          backgroundColor: Colors.teal,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.add), onPressed: _addAB),
            IconButton(icon: Icon(Icons.remove), onPressed: _removeAB),
          ],
        ),
        persistentFooterButtons: <Widget>[
          IconButton(
              icon: Icon(Icons.radio),
              onPressed: () => _onPressedFB('Radio from FB')),
          IconButton(
              icon: Icon(Icons.map),
              onPressed: () => _onPressedFB('Map from FB')),
        ],
        drawer: Drawer(
          child: Container(
            padding: EdgeInsets.all(32.0),
            child: Column(
              children: <Widget>[
                Text('I am Drawer'),
                RaisedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Close'),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: _listNavigatorBar,
          currentIndex: _intNavigatorBar,
          fixedColor: Colors.lightBlue,
          onTap: (int item) {
            setState(() {
              _intNavigatorBar = item;
              _stringNavigatorBar = _intNavigatorBar.toString();
            });
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _dateTimeFABOnClick,
          backgroundColor: Colors.redAccent,
          mini: true,
          child: Icon(Icons.timer),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(32.0),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Text('AppBar value: $_intAppBar'),
                    Divider(),
                    Text(_stringFooterButtons),
                    Divider(),
                    Text('DateTime from FAB: $_stringFAB'),
                    Divider(),
                    Text(
                        'Current value from Navigation Bar is: $_stringNavigatorBar'),
                    Divider(),
                    makeRadio(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(_intRadio01.toString()),
                        Text('___'),
                        Text(_intRadio02.toString()),
                      ],
                    ),
                    makeRadioTiles(),
                    Divider(),
                    RaisedButton(
                      onPressed: _onPressedRaisedButton,
                      child: Text('Click Me'),
                      textColor: Colors.red,
                      color: Colors.green,
                    ),
                    Text(_stringSimpleText),
                    FlatButton(
                      onPressed: _onClickFlatButton,
                      child: Text('ClickZ Meee'),
                      color: Colors.yellow,
                    ),
                    Divider(),
                    Text(_intIconButton.toString()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                            icon: Icon(Icons.add), onPressed: _addIconButton),
                        IconButton(
                            icon: Icon(Icons.remove), onPressed: _subIconButton)
                      ],
                    ),
                    Divider(),
                    textFromTextField(),
                    TextField(
                      onChanged: _onTextChange,
                      onSubmitted: _onTextSubmit,
                      decoration: InputDecoration(hintText: 'Enter text'),
                    ),
                    Checkbox(
                      value: _boolCheckBox01,
                      onChanged: _changeCheckBox01,
                      activeColor: Colors.cyanAccent,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(_boolCheckBox01.toString()),
                        Text('_____'),
                        Text(_boolCheckBox02.toString()),
                      ],
                    ),
                    CheckboxListTile(
                      value: _boolCheckBox02,
                      onChanged: _changeCheckBox02,
                      activeColor: Colors.deepOrangeAccent,
                      title: Text('Bool II'),
                      secondary: Icon(Icons.archive),
                    ),
                    Divider(),
                    Switch(value: _boolSwitch01, onChanged: _onSwitch01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(_boolSwitch01.toString()),
                        Text('___'),
                        Text(_boolSwitch02.toString()),
                      ],
                    ),
                    SwitchListTile(
                      value: _boolSwitch02,
                      onChanged: _onSwitch02,
                      title: Text(
                        'Switch II',
                        style: TextStyle(color: Colors.pinkAccent),
                      ),
                      activeColor: Colors.limeAccent,
                    ),
                    Divider(),
                    Text('Slider value is: ${(_doubleSlider * 100).round()}'),
                    Slider(value: _doubleSlider, onChanged: _setSlider),
                    Divider(),
                    Text('Selected date is: $_stringSelectDate'),
                    RaisedButton(
                      onPressed: _selectDate,
                      child: Text('Select Date'),
                    ),
                    Divider(),
                    RaisedButton(
                      onPressed: _showBottom,
                      child: Text('Show ModalBottomSheet'),
                    ),
                    Divider(),
                    RaisedButton(
                      onPressed: _showBar,
                      child: Text('Show SnackBar'),
                    ),
                    Divider(),
                    RaisedButton(
                        onPressed: () =>
                            _showAlert('Do You like Flutter, I do'),
                        child: Text('Alert')),
                    Divider(),
                    Text('Simple Dialog choise: $_stringSimpleDialog'),
                    RaisedButton(
                      onPressed: _askUserSimpleDialog,
                      child: Text('SimpleDialog'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}