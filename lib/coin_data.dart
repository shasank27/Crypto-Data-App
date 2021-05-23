import 'package:http/http.dart' as http;
import 'dart:convert';

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
  Map<String, String> prices = {};
  Future getMoney(String selectedcurrency) async {
    for (String i in cryptoList) {
      http.Response response = await http.get(Uri.parse(
          'https://rest.coinapi.io/v1/exchangerate/$i/$selectedcurrency?apikey=93100797-DED9-4718-A126-2ED5496560A8'));
      var decoded = await jsonDecode(response.body);
      print(decoded['rate']);
      if (decoded['rate'] != null) {
        prices[i] = decoded['rate'].toStringAsFixed(0);
      }
    }
    return prices;
  }
}
