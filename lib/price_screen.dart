import 'package:flutter/material.dart';
import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  Map<String, String> coinprice;
  String selectedcurrency = 'USD';
  bool gotPrice = false;
  CoinData coin = CoinData();
  List<DropdownMenuItem> dropdown() {
    List<DropdownMenuItem> dropdownMenuItem = [];
    for (String i in currenciesList) {
      var newitem = DropdownMenuItem(
        child: Text(i),
        value: i,
      );
      dropdownMenuItem.add(newitem);
    }
    return dropdownMenuItem;
  }

  getPrice() async {
    gotPrice = false;
    try {
      var data = await coin.getMoney(selectedcurrency);
      gotPrice = true;
      setState(() {
        coinprice = data;
      });
    } catch (e) {
      print(e);
    }
  }

  Padding pad(String crypto) {
    String price = gotPrice ? coinprice[crypto] : '?';
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $crypto = $price $selectedcurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    getPrice();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          pad(cryptoList[0]),
          pad(cryptoList[1]),
          pad(cryptoList[2]),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: DropdownButton(
              value: selectedcurrency,
              items: dropdown(),
              onChanged: (value) {
                setState(() {
                  selectedcurrency = value;
                  getPrice();
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
