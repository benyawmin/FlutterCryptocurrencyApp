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

  final _r1 = PublishSubject();
  final _r2 = PublishSubject();
  final _r3 = PublishSubject();

  final _c1 = PublishSubject();
  final _c2 = PublishSubject();
  final _c3 = PublishSubject();
  final _c4 = PublishSubject();
  final _c5 = PublishSubject();

  get r1Stream => _r1.stream;
  get r2Stream => _r2.stream;
  get r3Stream => _r3.stream;

  get c1Stream => _c1.stream;
  get c2Stream => _c2.stream;
  get c3Stream => _c3.stream;
  get c4Stream => _c4.stream;
  get c5Stream => _c5.stream;

  get geckoStream => _gecko.stream;
  get loginStream => _login.stream;
  get chartGeckoStream => _chartGecko.stream;
  get candleGeckoStream => _candleGecko.stream;

  r1Fetch(String region) async {
    _r1.sink.add(await _repository.fetchByRegion(region));
  }

  r2Fetch(String region) async {
    _r2.sink.add(await _repository.fetchByRegion(region));
  }

  r3Fetch(String region) async {
    _r3.sink.add(await _repository.fetchByRegion(region));
  }

  c1Fetch(String category) async {
    _c1.sink.add(await _repository.fetchByCategory(category));
  }

  c2Fetch(String category) async {
    _c2.sink.add(await _repository.fetchByCategory(category));
  }

  c3Fetch(String category) async {
    _c3.sink.add(await _repository.fetchByCategory(category));
  }

  c4Fetch(String category) async {
    _c4.sink.add(await _repository.fetchByCategory(category));
  }

  c5Fetch(String category) async {
    _c5.sink.add(await _repository.fetchByCategory(category));
  }

  get newsStream => _newsFetcher.stream;
  get txtFieldStream => _txtField.stream;
  get searchedListBuilderStream => _searchedListBuilder.stream;
  get savedNewsStream => _savedNews.stream;
  get filteredByCatStream => _filteredByCat.stream;
  get filteredByRegionStream => _filteredByRegion.stream;

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
    if (response == 'Error')
      _login.sink.addError('Wrong login information! Try again');
    else
      _login.sink.add(response);
  }

  dispose() {
    _newsFetcher.close();
    _filteredByCat.close();
    _txtField.close();
    _searchedListBuilder.close();
    _savedNews.close();
    _filteredByRegion.close();

    _r1.close();
    _r2.close();
    _r3.close();

    _c1.close();
    _c2.close();
    _c3.close();
    _c4.close();
    _c5.close();

    _gecko.close();
    _login.close();
    _chartGecko.close();
    _candleGecko.close();
  }
}