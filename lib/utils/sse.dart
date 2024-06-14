import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../stores/system.dart';
import '../stores/user.dart';

class SseClient {
  final String endpoint;
  final StreamController<String> _controller =
  StreamController<String>();

  SseClient(this.endpoint) {
    _connect();
  }

  Stream<String> get stream => _controller.stream;

  void _connect() async {

    var address = await SystemStore.getAddress();
    if (address == null || !address.contains("http")) {
      throw Exception("baseUrl error");
    }
    var token = await UserStore.getToken();
    var url = Uri.parse('$address$endpoint?token=$token');

    final request = http.Request('GET',url)
      ..headers['Accept'] = 'text/event-stream';

    final response = await http.Client().send(request);

    response.stream.transform(utf8.decoder).listen((event) {
      for (String line in LineSplitter.split(event)) {
        print(line);
        if (line.startsWith('event:')) {
          _controller.add(line.substring(6));
        }
      }
    });
  }

  void close() {
    _controller.close();
  }
}
