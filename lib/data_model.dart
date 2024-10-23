import 'package:bitcoin_tracker/coin_data.dart';

const apiKey = "A60DE59B-8852-4FEA-A1C7-0A15DBFB99D1";
const urlLink = "https://rest.coinapi.io/v1/exchangerate";

class DataModel {
  Future<Map<String, dynamic>> getExchangeData(String cryptoType, String country) async {
    var url = "$urlLink/$cryptoType/$country/?apikey=$apiKey";
    CoinData coinData = CoinData(url: url);
    var finalCoinData = await coinData.getCoinData() as Map<String, dynamic>;
    return finalCoinData; // Return a single Map instead of a list
  }
}
