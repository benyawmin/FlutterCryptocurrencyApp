converter(String id) {
  switch (id) {
    case 'trx':
      {
        return 'tron';
      }
    case 'btc':
      {
        return 'bitcoin';
      }
    case 'eth':
      {
        return 'ethereum';
      }
    case 'ltc':
      {
        return 'litecoin';
      }
    case 'usdt':
      {
        return 'tether';
      }
    case 'xrp':
      {
        return 'ripple';
      }
    case 'bch':
      {
        return 'bitcoin-cash';
      }
    case 'bnb':
      {
        return 'binancecoin';
      }
    case 'eos':
      {
        return 'eos';
      }
    case 'xlm':
      {
        return 'stellar';
      }
    case 'etc':
      {
        return 'ethereum-classic';
      }
    case 'doge':
      {
        return 'dogecoin';
      }
    case 'uni':
      {
        return 'uniswap';
      }
    case 'dai':
      {
        return 'dai';
      }
    case 'link':
      {
        return 'link';
      }
    case 'dot':
      {
        return 'polkadot';
      }
    case 'aave':
      {
        return 'aave';
      }
    case 'ada':
      {
        return 'cardano';
      }
    default:
      {
        return 'null';
      }
  }
}
