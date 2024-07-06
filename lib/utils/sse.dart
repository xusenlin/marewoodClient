import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../stores/system.dart';
import '../stores/user.dart';

class SseClient {
  final String _endpoint;

  StreamSubscription<String> ? _subscription;
  http.Client ? _client;

  SseClient(this._endpoint);

  Future<void> startSubscribe(void Function(String data) onListen) async {
    var address = await SystemStore.getAddress();
    if (address == null || !address.contains("http")) {
      throw Exception("baseUrl error");
    }
    var token = await UserStore.getToken();
    var url = Uri.parse('$address$_endpoint?token=$token');

    final request = http.Request('GET', url)
      ..headers['Accept'] = 'text/event-stream';

    _client = http.Client();

    final response = await _client?.send(request);

    _subscription = response?.stream.transform(utf8.decoder).listen((event) {
      for (String line in LineSplitter.split(event)) {
        if (line.startsWith('event:')) {
          onListen(line.substring(6));
        }
      }
    }, onError: (err) {
      print("======");
      print(err);
    },onDone: (){
      print("onDone");
    },cancelOnError: true,
    );
  }

  void unsubscribe() {
    // if(_subscription!=null){
    //   _subscription?.cancel();
    // }
    // if(_client!=null){
    //   try{
    //     _client?.close();
    //   }catch(e){
    //     print(e);
    //   }
    // }

  }
}
