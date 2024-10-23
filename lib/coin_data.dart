import 'package:http/http.dart' as http;
import 'dart:convert';


const apiKey ="A60DE59B-8852-4FEA-A1C7-0A15DBFB99D1";
const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {

  String url;
  CoinData({required this.url});

  Future getCoinData() async{
    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri);
    String data = response.body;

    return jsonDecode(data);

  }



}