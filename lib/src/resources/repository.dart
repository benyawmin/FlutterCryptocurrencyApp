import 'news_api_provider.dart';

class Repository {
  // List sources = [
  //   newsDbProvider,
  //   NewsApiProvider(),
  // ];
  // List caches = [
  //   newsDbProvider,
  // ];

  buyAndSellNobitex(String token) async {
    return await NewsApiProvider().buyAndSellNobitex(token);
  }

  orderNobitex(String token, String type, String srcCurrency,
      String dstCurrency, String amount, String price) async {
    return await NewsApiProvider()
        .orderNobitex(token, type, srcCurrency, dstCurrency, amount, price);
  }

  fetchLatestNews() async {
    return await NewsApiProvider().fetchLatestNews();
  }

  pingGecko() async {
    return await NewsApiProvider().pingGecko();
  }

  chartGecko(String id) async {
    return await NewsApiProvider().chartGecko(id);
  }

  candleGecko(String id) async {
    return await NewsApiProvider().candleGecko(id);
  }

  nobitex(String username, String password) async {
    return await NewsApiProvider().nobitex(username, password);
  }

  // fetchAllFromDb() async {
  //   return await newsDbProvider.fetchAllItems();
  // }

  fetchSearchedNews(String searchParameter) async {
    return await NewsApiProvider().fetchSearchedNews(searchParameter);
  }

  fetchByCategory(String searchParameter) async {
    return await NewsApiProvider().fetchByCategory(searchParameter);
  }

  fetchByRegion(String region) async {
    return await NewsApiProvider().fetchByRegion(region);
  }

  fetchAllRegions() async {
    return await NewsApiProvider().fetchAllRegions();
  }

  // resetDb() {
  //   newsDbProvider.clear();
  // }

  // addToDb(item) {
  //   newsDbProvider.addItem(item);
  // }
}
