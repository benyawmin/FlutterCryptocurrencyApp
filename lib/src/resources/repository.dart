import 'api_provider.dart';

class Repository {
  // List sources = [
  //   newsDbProvider,
  //   NewsApiProvider(),
  // ];
  // List caches = [
  //   newsDbProvider,
  // ];

  buyAndSellNobitex(String token) async {
    return await ApiProvider().buyAndSellNobitex(token);
  }

  walletsNobitex(String token) async {
    return await ApiProvider().walletsNobitex(token);
  }

  orderNobitex(String token, String type, String srcCurrency,
      String dstCurrency, String amount, String price) async {
    return await ApiProvider()
        .orderNobitex(token, type, srcCurrency, dstCurrency, amount, price);
  }

  fetchLatestNews() async {
    return await ApiProvider().fetchLatestNews();
  }

  pingGecko() async {
    return await ApiProvider().pingGecko();
  }

  chartGecko(String id) async {
    return await ApiProvider().chartGecko(id);
  }

  candleGecko(String id) async {
    return await ApiProvider().candleGecko(id);
  }

  nobitex(String username, String password) async {
    return await ApiProvider().nobitex(username, password);
  }

  // fetchAllFromDb() async {
  //   return await newsDbProvider.fetchAllItems();
  // }

  fetchSearchedNews(String searchParameter) async {
    return await ApiProvider().fetchSearchedNews(searchParameter);
  }

  fetchByCategory(String searchParameter) async {
    return await ApiProvider().fetchByCategory(searchParameter);
  }

  fetchByRegion(String region) async {
    return await ApiProvider().fetchByRegion(region);
  }

  fetchAllRegions() async {
    return await ApiProvider().fetchAllRegions();
  }

  // resetDb() {
  //   newsDbProvider.clear();
  // }

  // addToDb(item) {
  //   newsDbProvider.addItem(item);
  // }
}
