import 'dart:convert';
import 'dart:io';

void main(List<String> args) async {
  const networkAddress = "192.168.1.0";
  const int port = 54365;
  List<NetworkDetails> ipAvailables = [];
  List<Future<NetworkDetails>> futures = [];
  for (int i = 0; i < 256; i++) {
    final host = networkAddress.replaceAll('0', i.toString());
    futures.add(isNetwork(host, port));
  }
  await Future.wait(futures).then((value) {
    for (final network in value) {
      if (network.isAvailable) ipAvailables.add(network);
    }
  });
  print(ipAvailables);
}

Future<NetworkDetails> isNetwork(String host, int port) async {
  final NetworkDetails networkDetails = NetworkDetails(ip: host, port: port);
  HttpClient client = HttpClient();
  try {
    final req = await client.get(host, port, "/");
    final res = await req.close();
    final String data = await res.transform(const Utf8Decoder()).join();
    print(data);
    client.close();
    client = HttpClient();
    networkDetails.isAvailable = true;

    return networkDetails;
  } catch (e) {
    // print(e);
    return networkDetails;
  } finally {
    client.close();
  }
}

class NetworkDetails {
  String ip;
  int port;
  bool isAvailable;
  NetworkDetails({
    required this.ip,
    required this.port,
    this.isAvailable = false,
  });

  @override
  String toString() {
    return "$ip:$port -> $isAvailable \n";
  }
}
