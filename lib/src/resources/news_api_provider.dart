import 'dart:io';
import 'package:cryptocurrency/src/models/news_model.dart';
import 'package:cryptocurrency/src/screens/chart_al.dart';
// import 'package:cryptocurrency/src/resources/currencies.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsApiProvider {
  final baseUrl = 'api.currentsapi.services';
  final geckoBaseUrl = 'api.coingecko.com';
  final nobitexBase = 'api.nobitex.ir';

  pingGecko() async {
    final queryParameters = {
      'vs_currency': 'usd',
    };
    final uri =
        Uri.https('$geckoBaseUrl', '/api/v3/coins/markets', queryParameters);

    final response = await http.get(uri, headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
      HttpHeaders.cacheControlHeader: 'max-age=0,private,must-revalidate'
    });
    if (response.statusCode == 200) {
      final items = json.decode(response.body);
      return items;
      // return NewsModel.fromJson(items).news;
    } else if (response.statusCode == 401) {
      throw Exception('Error 401');
    } else if (response.statusCode == 429) {
      throw Exception('Error 429');
    } else {
      throw Exception('null');
    }
  }

  chartGecko(String id) async {
    final queryParameters = {'vs_currency': 'usd', 'days': '10000'};
    final uri = Uri.https(
        geckoBaseUrl, '/api/v3/coins/$id/market_chart', queryParameters);

    final response = await http.get(uri, headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
      HttpHeaders.cacheControlHeader: 'max-age=0,private,must-revalidate'
    });

    if (response.statusCode == 200) {
      final items = json.decode(response.body);
      // var xa = [];
      // var ya = [];
      // for (var i = 0; i < items['prices'].length; i++) {
      //   xa.add(readTimestamp((await items['prices'][i][0])));
      //   ya.add((await items['prices'][i][1]));
      // }
      // List xy = [xa, ya, items['prices']];

      return items['prices'];
      // return NewsModel.fromJson(items).news;
    } else if (response.statusCode == 401) {
      throw Exception('Error 401');
    } else if (response.statusCode == 429) {
      throw Exception('Error 429');
    } else {
      throw Exception('null');
    }
  }

  candleGecko(String id) async {
    final queryParameters = {'vs_currency': 'usd', 'days': '365'};
    final uri =
        Uri.https(geckoBaseUrl, '/api/v3/coins/$id/ohlc', queryParameters);

    final response = await http.get(uri, headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
      HttpHeaders.cacheControlHeader: 'max-age=0,private,must-revalidate'
    });
    if (response.statusCode == 200) {
      final items = json.decode(response.body);
      // print(items[0]);
      // print(items.length);
      return items;
      // return NewsModel.fromJson(items).news;
    } else if (response.statusCode == 401) {
      throw Exception('Error 401');
    } else if (response.statusCode == 429) {
      throw Exception('Error 429');
    } else {
      throw Exception('null');
    }
  }

  nobitex(String username, String password) async {
    final response = await http.post(
      Uri.parse('https://api.nobitex.ir/auth/login/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "username": "$username",
        "password": "$password",
        "captcha": "api"
      }),
    );
    if (response.statusCode == 200) {
      final items = json.decode(response.body);
      return items;
      // return NewsModel.fromJson(items).news;
    } else {
      return 'Error';
    }
    // else if (response.statusCode == 401) {
    //   return Exception('Error 401');
    // } else if (response.statusCode == 429) {
    //   return Exception('Error 429');
    // } else {
    //   return Exception('null');
    // }
  }

  buyAndSellNobitex(String token) async {
// List transactions = [];

// for (var cs in currencies) {
//       var response2 = await http.post(
//       Uri.parse('https://api.nobitex.ir/market/orders/list'),
//       headers: <String, String>{
//         'Authorization': 'Token $token',
//         'content-type': 'application/json',
//       },
//       body: jsonEncode(<String, String>{
//         'srcCurrency': cs.toString(),
//         'dstCurrency':'rls',
//         'details':'2'
//       }),
//     );
//     final items2 = json.decode(response2.body);
//     transactions.add(items2);
//       print(cs);

// }
    // print(transactions);
    // return transactions[];
    // } else if (response.statusCode == 401) {
    //   return 'Error 401';
    // } else if (response.statusCode == 429) {
    //   return 'Error 429';
    // } else {
    //   // print(response.statusCode);
    //   return 'null';
    // }

    final response = await http.post(
      Uri.parse('https://api.nobitex.ir/users/wallets/list'),
      headers: <String, String>{
        'Authorization': 'Token $token',
        // 'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{}),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      final items = json.decode(response.body);
      List walletIds = [];
      for (var item in items['wallets']) {
        walletIds.add(item['id']);
      }
      print(walletIds);

      List transactions = [];

      for (var wi in walletIds) {
        var response2 = await http.post(
          Uri.parse('https://api.nobitex.ir/users/wallets/transactions/list'),
          headers: <String, String>{
            'Authorization': 'Token $token',
            'content-type': 'application/json',
          },
          body: jsonEncode(<String, String>{'wallet': wi.toString()}),
        );
        final items2 = json.decode(response2.body);
        transactions.add(items2['transactions']);
      }
      List newTransactions = transactions.where((i) => i.length != 0).toList();
      List allTransactions = [];
      for (var i = 0; i < newTransactions.length; i++) {
        for (var j = 0; j < newTransactions[i].length; j++) {
          allTransactions.add(newTransactions[i][j]);
        }
      }
// print(newTransactions[0].toString());
// print(newTransactions[0].toString());

      print(allTransactions);
      List buyAndSellTransactions = allTransactions.where((element) => !element['description']
      .contains('address') && element['currency'] != 'rls'
      )
      .toList();
      print(buyAndSellTransactions);
      return buyAndSellTransactions;
    } else if (response.statusCode == 401) {
      return 'Error 401';
    } else if (response.statusCode == 429) {
      return 'Error 429';
    } else {
      // print(response.statusCode);
      return 'null';
    }
  }

  fetchLatestNews() async {
    final uri = Uri.https('$baseUrl', '/v1/latest-news');
    final response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader:
          'tUgFTJO_UFo_Xwo1xpmJ9qPbq7uuhTCMFT-Svqepr4hSVsbv',
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    if (response.statusCode == 200) {
      final items = json.decode(response.body);
      return NewsModel.fromJson(items).news;
    } else if (response.statusCode == 401) {
      throw Exception('Error 401');
    } else if (response.statusCode == 429) {
      throw Exception('Error 429');
    } else {
      throw Exception('null');
    }
  }

  fetchSearchedNews(String searchParameter) async {
    final queryParameters = {
      'keywords': searchParameter,
    };
    final uri = Uri.https('$baseUrl', '/v1/search', queryParameters);
    final response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader:
          'tUgFTJO_UFo_Xwo1xpmJ9qPbq7uuhTCMFT-Svqepr4hSVsbv',
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    if (response.statusCode == 200) {
      final items = json.decode(response.body);
      return NewsModel.fromJson(items).news;
    } else if (response.statusCode == 401) {
      throw Exception('Error 401');
    } else if (response.statusCode == 429) {
      throw Exception('Error 429');
    } else {
      throw Exception('null');
    }
  }

  fetchByCategory(String searchParameter) async {
    final queryParameters = {
      'category': searchParameter,
    };
    final uri = Uri.https('$baseUrl', '/v1/search', queryParameters);
    final response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader:
          'tUgFTJO_UFo_Xwo1xpmJ9qPbq7uuhTCMFT-Svqepr4hSVsbv',
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    if (response.statusCode == 200) {
      final items = json.decode(response.body);
      return NewsModel.fromJson(items).news;
    } else if (response.statusCode == 401) {
      throw Exception('Error 401');
    } else if (response.statusCode == 429) {
      throw Exception('Error 429');
    } else {
      throw Exception('null');
    }
  }

  fetchByRegion(String searchParameter) async {
    final queryParameters = {
      'country': searchParameter,
    };
    final uri = Uri.https('$baseUrl', '/v1/search', queryParameters);
    final response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader:
          'tUgFTJO_UFo_Xwo1xpmJ9qPbq7uuhTCMFT-Svqepr4hSVsbv',
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    if (response.statusCode == 200) {
      final items = json.decode(response.body);
      return NewsModel.fromJson(items).news;
    } else if (response.statusCode == 401) {
      throw Exception('Error 401');
    } else if (response.statusCode == 429) {
      throw Exception('Error 429');
    } else {
      throw Exception('null');
    }
  }

  fetchAllRegions() async {
    final uri = Uri.https('$baseUrl', 'v1/available/regions');
    final response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader:
          'tUgFTJO_UFo_Xwo1xpmJ9qPbq7uuhTCMFT-Svqepr4hSVsbv',
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    if (response.statusCode == 200) {
      final items = json.decode(response.body);
      return items['regions'].values.toList();
    } else if (response.statusCode == 401) {
      throw Exception('Error 401');
    } else if (response.statusCode == 429) {
      throw Exception('Error 429');
    } else {
      throw Exception('null');
    }
  }
}
