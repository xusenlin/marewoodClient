import 'package:flutter/material.dart';
import 'package:marewood_client/models/task.dart';
import 'package:marewood_client/stores/system.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TaskWebView extends StatelessWidget {
  const TaskWebView({super.key, required this.task});

  final Task task;

  // late final WebViewCookieManager cookieManager = WebViewCookieManager();

  @override
  Widget build(BuildContext context) {
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000));
      // ..addJavaScriptChannel(
      //   'Toaster',
      //   onMessageReceived: (JavaScriptMessage message) {
      //     ScaffoldMessenger.of(context).showSnackBar(
      //       SnackBar(content: Text(message.message)),
      //     );
      //   },
      // )
      // ..setNavigationDelegate(
      //   NavigationDelegate(
      //     onProgress: (int progress) {},
      //     onPageStarted: (String url) {},
      //     onPageFinished: (String url) {},
      //     onHttpError: (HttpResponseError error) {print(error);},
      //     onWebResourceError: (WebResourceError error) {print(error);},
      //     onNavigationRequest: (NavigationRequest request) {
      //       return NavigationDecision.navigate;
      //     },
      //   ),
      // );

    Future<void> loadRequest() async {
      var address = await SystemStore.getAddress();
      if(address==null){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text("WebView page baseUrl error")),
        );
        return;
      }
      await controller.loadRequest(Uri.parse("$address/webs/${task.alias}"));
    }

    loadRequest();
    return Scaffold(
      appBar: AppBar(
        title: Text("${task.tag}${task.name}"),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
