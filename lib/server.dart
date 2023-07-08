import 'dart:io' as io;

void main() async {
  final ip = io.InternetAddress.anyIPv4;
  const port = 54365;
  var server = await io.HttpServer.bind(ip, port);
  await server.forEach((io.HttpRequest request) {
    request.response.write('Hello, world!');
    request.response.close();
  });
}
