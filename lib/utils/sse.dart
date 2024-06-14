import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SseClient {
  final String url;
  final StreamController<Map<String, dynamic>> _controller =
  StreamController<Map<String, dynamic>>();

  SseClient(this.url) {
    _connect();
  }

  Stream<Map<String, dynamic>> get stream => _controller.stream;

  void _connect() async {
    final request = http.Request('GET', Uri.parse(url))
      ..headers['Accept'] = 'text/event-stream';

    final response = await http.Client().send(request);

    response.stream.transform(utf8.decoder).listen((event) {
      for (String line in LineSplitter.split(event)) {
        if (line.startsWith('data: ')) {
          final data = json.decode(line.substring(6));
          _controller.add(data);
        }
      }
    });
  }

  void close() {
    _controller.close();
  }
}
