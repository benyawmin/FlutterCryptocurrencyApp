converter(String id) {
  switch (id) {
    case 'tron':
      {
        return 'trx';
      }
    case 'bitcoin':
      {
        return 'btc';
      }
    case 'ethereum':
      {
        return 'eth';
      }
    case 'litecoin':
      {
        return 'ltc';
      }
    case 'tether':
      {
        return 'usdt';
      }
    case 'ripple':
      {
        return 'xrp';
      }
    case 'bitcoin-cash':
      {
        return 'bch';
      }
    case 'binancecoin':
      {
        return 'bnb';
      }
    case 'eos':
      {
        return 'eos';
      }
    case 'stellar':
      {
        return 'xlm';
      }
    case 'ethereum-classic':
      {
        return 'etc';
      }
    case 'dogecoin':
      {
        return 'doge';
      }
    case 'uniswap':
      {
        return 'uni';
      }
    case 'dai':
      {
        return 'dai';
      }
    case 'link':
      {
        return 'link';
      }
    case 'polkadot':
      {
        return 'dot';
      }
    case 'aave':
      {
        return 'aave';
      }
    case 'cardano':
      {
        return 'ada';
      }
    default:
      {
        return 'null';
      }
  }
}
