import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebView extends StatelessWidget {
  WebView({super.key});

  late final WebViewCookieManager cookieManager = WebViewCookieManager();

  @override
  Widget build(BuildContext context) {
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {print(error);},
          onWebResourceError: (WebResourceError error) {print(error);},
          onNavigationRequest: (NavigationRequest request) {
            // if (request.url.startsWith('https://xusenlin.com/')) {
            //   return NavigationDecision.prevent;
            // }
            return NavigationDecision.navigate;
          },
        ),
      );

    Future<void> _onSetCookie() async {
      await cookieManager.setCookie(
        const WebViewCookie(
          name: 'foo1232',
          value: 'bar',
          domain: 'mw.xxx.com',
        ),
      );
      await controller.loadRequest(Uri.parse(
        'https://mw.xxx.com/256',
      ));
    }


    _onSetCookie();
    return WebViewWidget(controller: controller);
  }
}
