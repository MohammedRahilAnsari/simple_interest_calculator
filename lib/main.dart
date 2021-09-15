import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Simple Interest Calculator",
    home: SIFrom(),
    theme: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.indigo,
      accentColor: Colors.indigoAccent,
    ),
  ));
}

class SIFrom extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SIFromState();
  }
}

class _SIFromState extends State<SIFrom> {
  var _formKey = GlobalKey<FormState>();

  var _currencies = ['Rupees', 'pounds', 'Dollars', 'Others'];
  final _minimumPadding = 5.0;
  var _currentItemSelected = '';

  @override
  void initState() {
    super.initState();
    _currentItemSelected = _currencies[0];
  }

  TextEditingController principalcntrlr = TextEditingController();
  TextEditingController rateofInterestcntrlr = TextEditingController();
  TextEditingController termcntrlr = TextEditingController();

  var displayResult = '';

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
      // resizeToAvoidBottomInset: fals e,
      appBar: AppBar(
        title: Text('Simple Interest Calculator'),
      ),
      body: Form(
        key: _formKey   ,
        child: Padding(
            padding: EdgeInsets.all(_minimumPadding * 2),
            child: ListView(
              children: [
                getImageAssert(),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      controller: principalcntrlr,
                      validator: (value){
                        if(value!.isEmpty) {
                          return 'Please Enter Principal amount';
                        }
                      },
                      decoration: InputDecoration(
                        labelStyle: textStyle,
                        labelText: 'principal',
                        hintText: 'Enter Principal e.g 12000',
                        errorStyle: TextStyle(
                          color: Colors.yellowAccent,
                          fontSize: 15.0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      controller: rateofInterestcntrlr,
                      validator: (value){
                        if(value!.isEmpty) {
                          return 'Please Enter Rate of Interest';
                        }
                      },
                      decoration: InputDecoration(
                        labelStyle: textStyle,
                        labelText: 'Rate of interest',
                        hintText: 'In Percent ',
                        errorStyle: TextStyle(
                          color: Colors.yellowAccent,
                          fontSize: 15.0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: Row(
                      children: [
                        Expanded(
                            child: TextFormField(
                          keyboardType: TextInputType.number,
                          style: textStyle,
                          controller: termcntrlr,
                              validator: (value){
                                if(value!.isEmpty) {
                                  return 'Please Enter Term';
                                }
                              },
                          decoration: InputDecoration(
                            labelStyle: textStyle,
                            labelText: 'Term',
                            hintText: 'Time in Years',
                            errorStyle: TextStyle(
                              color: Colors.yellowAccent,
                              fontSize: 15.0,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        )),
                        Container(
                          width: _minimumPadding * 5,
                        ),
                        Expanded(
                            child: DropdownButton<String>(
                          items: _currencies.map((value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          value: _currentItemSelected,
                          onChanged: (newValueSelected) {
                            _onDropDownItemSelected(newValueSelected!);
                          },
                        )),
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.only(
                      top: _minimumPadding, bottom: _minimumPadding),
                  child: Row(
                    children: [
                      Expanded(
                          child: RaisedButton(
                        color: Theme.of(context).accentColor,
                        textColor: Theme.of(context).primaryColorDark,
                        child: Text(
                          'Calculate',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          setState(() {
                            if(_formKey.currentState!.validate()) {
                              this.displayResult = _calculateTotalReturns();
                            }
                            });
                        },
                      )),
                      Expanded(
                          child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Reset',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          setState(() {
                            _reset();
                          });
                        },
                      ))
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: _minimumPadding, bottom: _minimumPadding),
                  child: Text(
                    this.displayResult,
                    style: textStyle,
                  ),
                )
              ],
            )),
      ),
    );
  }

  Widget getImageAssert() {
    AssetImage assetImage = AssetImage('images/money.png');
    Image image = Image(image: assetImage, width: 125.0, height: 125.0);
    return Container(
      child: image,
      margin: EdgeInsets.all(_minimumPadding * 10),
    );
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }

  String _calculateTotalReturns() {
    double principal = double.parse(principalcntrlr.text);
    double rateOFInterest = double.parse(rateofInterestcntrlr.text);
    double term = double.parse(termcntrlr.text);

    double totalAmountPayable =
        principal + (principal * rateOFInterest * term) / 100;

    String result =
        'After $term years, your investment will be worth $totalAmountPayable $_currentItemSelected';
    return result;
  }

  String? _reset() {
    principalcntrlr.text = '';
    rateofInterestcntrlr.text = '';
    termcntrlr.text = '';
    displayResult = '';
    _currentItemSelected = _currencies[0];
  }
}
