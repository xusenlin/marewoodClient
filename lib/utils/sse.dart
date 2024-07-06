import 'dart:async';
import 'package:eventflux/client.dart';
import 'package:eventflux/enum.dart';
import 'package:eventflux/models/reconnect.dart';
import 'package:eventflux/models/response.dart';

import '../stores/system.dart';
import '../stores/user.dart';

class SseClient {
  final String _endpoint;

  EventFlux eventSource = EventFlux.spawn();

  SseClient(this._endpoint);

  Future<void> startSubscribe(void Function(String data) onListen) async {
    var address = await SystemStore.getAddress();
    if (address == null || !address.contains("http")) {
      throw Exception("baseUrl error");
    }
    var token = await UserStore.getToken();
    eventSource.connect(EventFluxConnectionType.get,
        '$address$_endpoint?token=$token',
        onSuccessCallback: (EventFluxResponse? data) {
          data?.stream?.listen((data) {onListen(data.data);});
        },
        onError: (oops) {
          print("oops:");
        },
        autoReconnect: true, // Keep the party going, automatically!
        reconnectConfig: ReconnectConfig(
          mode: ReconnectMode.linear,
          interval: const Duration(seconds: 1),
          maxAttempts: 3,
          onReconnect: () {
            print("重新连接时执行的操作");
            // 重新连接时执行的操作
            // 提示：对于网络变化，`onReconnect` 将不会被调用。
            // 它只会在连接被服务器中断并且 eventflux 尝试重新建立连接时被调用。
          }
        )
    );
  }

  void unsubscribe() {
    eventSource.disconnect();
  }
}
