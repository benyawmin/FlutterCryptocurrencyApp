import 'package:cryptocurrency/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class LatestNewsBloc {
  final _repository = Repository();

  final _newsFetcher = PublishSubject();
  final _txtField = BehaviorSubject();
  final _searchedListBuilder = PublishSubject();
  final _savedNews = BehaviorSubject();
  final _filteredByCat = PublishSubject();
  final _filteredByRegion = PublishSubject();

  final _gecko = PublishSubject();
  final _login = PublishSubject();
  final _chartGecko = PublishSubject();
  final _candleGecko = PublishSubject();
  final _buyAndSellNobitex = PublishSubject();
  final _orderNobitex = PublishSubject();
  final _walletsNobitex = PublishSubject();

  get geckoStream => _gecko.stream;
  get loginStream => _login.stream;
  get chartGeckoStream => _chartGecko.stream;
  get candleGeckoStream => _candleGecko.stream;
  get buyAndSellNobitexStream => _buyAndSellNobitex.stream;
  get orderNobitexStream => _orderNobitex.stream;

  get newsStream => _newsFetcher.stream;
  get txtFieldStream => _txtField.stream;
  get searchedListBuilderStream => _searchedListBuilder.stream;
  get savedNewsStream => _savedNews.stream;
  get filteredByCatStream => _filteredByCat.stream;
  get filteredByRegionStream => _filteredByRegion.stream;
  get walletsNobitexStream => _walletsNobitex.stream;

  addTxt(String txt) {
    _txtField.sink.add(txt);
  }

  fetchSearchedNews(String txt) async {
    var searchedResults = await _repository.fetchSearchedNews(txt);
    if (searchedResults.isEmpty)
      _searchedListBuilder.sink.addError('No results found');
    else
      _searchedListBuilder.sink.add(searchedResults);
  }

  fetchLatestNews() async {
    var latestNews = await _repository.fetchLatestNews();
    _newsFetcher.sink.add(latestNews);
  }

  // addToSavedNews(snapshot, index) async {
  //   _savedNews.sink.add(await _repository.fetchAllFromDb());
  // }

  fetchByCat(String category) async {
    _filteredByCat.sink.add(await _repository.fetchByCategory(category));
  }

  fetchByRegion(String region) async {
    _filteredByRegion.sink.add(await _repository.fetchByRegion(region));
  }

  pingGecko() async {
    _gecko.sink.add(await _repository.pingGecko());
  }

  chartGecko(String id) async {
    _chartGecko.sink.add(await _repository.chartGecko(id));
  }

  candleGecko(String id) async {
    _candleGecko.sink.add(await _repository.candleGecko(id));
  }

  login(username, password) async {
    final response = await _repository.nobitex(username, password);
    if (response == 'Error') {
      _login.sink.addError('Wrong login information! Try again');
    } else {
      _login.sink.add(response);
    }
  }

  buyAndSellNobitexx(String token) async {
    final result = await _repository.buyAndSellNobitex(token);
    _buyAndSellNobitex.sink.add(result);
  }

  walletsNobitex(String token) async {
    final result = await _repository.walletsNobitex(token);
    _walletsNobitex.sink.add(result);
  }

  orderNobitex(String token, String type, String srcCurrency,
      String dstCurrency, String amount, String price) async {
    final result = await _repository.orderNobitex(
        token, type, srcCurrency, dstCurrency, amount, price);
    _orderNobitex.sink.add(result);
  }

  dispose() {
    _newsFetcher.close();
    _filteredByCat.close();
    _txtField.close();
    _searchedListBuilder.close();
    _savedNews.close();
    _filteredByRegion.close();
    _gecko.close();
    _login.close();
    _chartGecko.close();
    _candleGecko.close();
    _walletsNobitex.close();
  }
}
