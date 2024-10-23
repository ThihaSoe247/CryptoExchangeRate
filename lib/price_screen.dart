import 'dart:math';
import 'package:bitcoin_tracker/coin_data.dart';
import 'package:bitcoin_tracker/data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String currencyValue = currenciesList[0];
  List<Map<String, dynamic>> rates = []; // Declare rates to store fetched data
  DataModel model = DataModel();

  @override
  void initState() {
    super.initState();
    getData(currencyValue);
  }

  List<Widget> buildCryptoCards() {
    List<Widget> cryptoCards = [];
    for (var rateData in rates) {
      String crypto = rateData['asset_id_base']; // Get the crypto type (e.g., BTC)
      double rate = rateData['rate'] ?? 0; // Get the rate, default to 0 if not available

      Widget card = Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $crypto = ${rate.toInt()} $currencyValue',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      );
      cryptoCards.add(card);
    }
    return cryptoCards;
  }

  void getData(String selectedCurrency) async {
    List<Map<String, dynamic>> allRates = []; // To store all crypto rates
    for (String crypto in cryptoList) {
      try {
        var coinData = await model.getExchangeData(crypto, selectedCurrency);
        allRates.add(coinData);
      } catch (e) {
        print('Error fetching data: $e');
      }
    }
    // Update state after the loop
    setState(() {
      rates = allRates; // Update the rates state variable
    });
  }

  CupertinoPicker iosPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }
    return CupertinoPicker(
      itemExtent: 32,
      onSelectedItemChanged: (selectedValue) {
        setState(() {
          currencyValue = currenciesList[selectedValue];
          getData(currencyValue);
        });
      },
      children: pickerItems,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Column(
              children: buildCryptoCards(),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: iosPicker(),
          ),
        ],
      ),
    );
  }
}
