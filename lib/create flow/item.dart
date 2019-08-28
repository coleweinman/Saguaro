import 'package:flutter/material.dart';
import 'package:cac_2019/common_widgets.dart';
import 'package:cac_2019/main.dart';
import 'selection_page.dart';

class ItemPage extends StatefulWidget {
  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  TextEditingController itemNameController;
  TextEditingController itemCostController;
  TextEditingController saveAmountController;
  String itemName = "";
  double itemCost = 100.0;
  double saveAmount = 0.0;
  int radioValue = 2;
  DateTime _dueDate = new DateTime.now();
  DateTime _startDate = new DateTime.now();
  int frequency = 7;

  @override
  void initState() {
    itemNameController = new TextEditingController(text: itemName);
    itemCostController = new TextEditingController(text: itemCost.toString());
    saveAmountController = new TextEditingController(text: saveAmount.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(radioValue == 1)
      saveAmountController.text = _getSaveAmount().toString();
    if(radioValue == 2)
      _dueDate = _getCompleteDate();
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(105,240,174,1.0),
        title: new Text('Save for an Item'),
      ),
      /*floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.add),
        backgroundColor: Color.fromRGBO(105,240,174,1.0),
        onPressed: () {
          var saveObject = new SaveObject(
              name: itemName,
              cost: itemCost,
              frequency: frequency,
              startDate: _startDate,
              completeDate: _dueDate
          );
          Navigator.of(context).pop(saveObject);
        },
      ),*/
      body: new SingleChildScrollView(
        child: new Center(
          child: new Column(
            children: <Widget>[
              new Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Column(
                    children: <Widget>[
                      new SimpleText(
                        'Item Information',
                        size: 18.0,
                        bold: true,
                      ),
                      new ThemeTextField(
                        controller: itemNameController,
                        label: 'Item Name',
                        width: 300.0,
                        onChanged: (value) {
                          setState(() {
                            itemName = value;
                          });
                        },
                      ),
                      Container(height: 10,),
                      new ThemeTextField(
                        controller: itemCostController,
                        label: 'Item Cost',
                        width: 200.0,
                        onChanged: (value) {
                          setState(() {
                            itemCost = double.parse(value);
                          });
                        },
                      ),
                      new DropdownButton(
                        value: frequency,
                        items: <DropdownMenuItem>[
                          new DropdownMenuItem(
                            child: new Text("Daily"),
                            value: 1,
                          ),
                          new DropdownMenuItem(
                            child: new Text("Weekly"),
                            value: 7,
                          ),
                          new DropdownMenuItem(
                            child: new Text("Bi-weekly"),
                            value: 14,
                          ),
                          new DropdownMenuItem(
                            child: new Text("Monthly"),
                            value: 30,
                          ),
                          new DropdownMenuItem(
                            child: new Text("Bi-monthly"),
                            value: 60,
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            frequency = value;
                          });
                        },
                      ),
                      new Row(
                        children: <Widget>[
                          new SimpleText("Start Date: ", bold: true, size: 20,),
                          new SimpleText("${_startDate.month}/${_startDate.day}/${_startDate.year}", bold: false, size: 20,),
                          new IconButton(
                            icon: new Icon(Icons.edit),
                            onPressed: () async {
                              DateTime result = await showDatePicker(
                                initialDate: _startDate,
                                firstDate: DateTime.utc(_startDate.year, _startDate.month, _startDate.day),
                                lastDate: DateTime(2200),
                                context: context,
                              );
                              if(result != null) {
                                setState(() {
                                  _startDate = result;
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              new Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Column(
                    children: <Widget>[
                      new SimpleText(
                        'Saving Information',
                        size: 18.0,
                        bold: true,
                      ),
                      new Row(
                        children: <Widget>[
                          new Radio(
                            value: 1,
                            activeColor: Color.fromRGBO(105,240,174,1.0),
                            onChanged: _saveTypeChanged,
                            groupValue: radioValue,
                          ),
                          new SimpleText('Save by Date', bold: false, size: 20,),
                        ],
                      ),
                      new Row(
                        children: <Widget>[
                          new SimpleText("Save by: ", bold: true, size: 20,),
                          new SimpleText("${_dueDate.month}/${_dueDate.day}/${_dueDate.year}", bold: false, size: 20,),
                          new IconButton(
                            icon: new Icon(Icons.edit),
                            onPressed: () async {
                              DateTime result = await showDatePicker(
                                initialDate: _dueDate,
                                firstDate: DateTime.utc(_dueDate.year, _dueDate.month, _dueDate.day),
                                lastDate: DateTime(2200),
                                context: context,
                              );
                              if(result != null) {
                                setState(() {
                                  _dueDate = result;
                                });
                              }
                            },
                          ),
                        ],
                      ),
                      Container(height: 10,),
                      new Row(
                        children: <Widget>[
                          new Radio(
                            value: 2,
                            activeColor: Color.fromRGBO(105,240,174,1.0),
                            onChanged: _saveTypeChanged,
                            groupValue: radioValue,
                          ),
                          new SimpleText('Save by Amount', bold: false, size: 20,),
                        ],
                      ),
                      Container(height: 10,),
                      new Row(
                        children: <Widget>[
                          new ThemeTextField(
                            keyboardType: TextInputType.number,
                            label: "Amount",
                            controller: saveAmountController,
                            width: 200,
                            onChanged: (value) {
                              setState(() {
                                saveAmount = double.parse(value);
                              });
                            },
                          ),
                        ],
                      ),
                    ],

                  ),
                ),
              ),
              new RaisedButton(
                color: Color.fromRGBO(105,240,174,1.0),
                child: Text(
                  "DONE",
                  style: new TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                textColor: Color.fromRGBO(255,255,255,1.0),
                onPressed: () {
                  var saveObject = new SaveObject(
                      name: itemName,
                      cost: itemCost,
                      frequency: frequency,
                      startDate: _startDate,
                      completeDate: _dueDate
                  );
                  Navigator.of(context).pop(saveObject);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveTypeChanged(int value) {
    setState(() {
      radioValue = value;
    });
  }

  double _getSaveAmount() {
    Duration savingTime = _dueDate.difference(_startDate);
    Duration gap = new Duration(days: frequency);
    int times = savingTime.inDays~/gap.inDays;
    return itemCost/times;
  }

  DateTime _getCompleteDate() {
    int saveTimes = 1;
    if(saveAmount > 0)
      saveTimes = itemCost~/saveAmount;
    Duration gap = new Duration(days: frequency);
    return new DateTime.now().add(new Duration(days: gap.inDays*saveTimes));
  }
}