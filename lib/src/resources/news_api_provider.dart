import 'dart:io';
import 'package:cryptocurrency/src/models/news_model.dart';
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
    final queryParameters = {
      'vs_currency': 'usd',
      'days':'10000'
    };
    final uri =
        Uri.https('$geckoBaseUrl', '/api/v3/coins/$id/market_chart', queryParameters);

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

    candleGecko(String id) async {
    final queryParameters = {
      'vs_currency': 'usd',
      'days':'100'
    };
    final uri =
        Uri.https('$geckoBaseUrl', '/api/v3/coins/$id/ohlc', queryParameters);

    final response = await http.get(uri, headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
      HttpHeaders.cacheControlHeader: 'max-age=0,private,must-revalidate'
    });

    if (response.statusCode == 200) {
      final items = json.decode(response.body);
      print(items);
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
      "username":"$username",
      "password":"$password",
      "captcha":"api"
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
