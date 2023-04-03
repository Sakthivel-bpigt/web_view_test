import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewPage extends StatefulWidget {
  const WebviewPage({Key? key}) : super(key: key);

  @override
  State<WebviewPage> createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  WebViewController? _controller;

  String tradingView = '''
  <!DOCTYPE>
<html>  
<head>
</head>
<body>  
<!-- TradingView Widget BEGIN -->
<div class="tradingview-widget-container">
  <div id="tradingview_83327"></div>
  <div class="tradingview-widget-copyright"><a href="https://www.tradingview.com/symbols/NASDAQ-AAPL/" rel="noopener" target="_blank"><span class="blue-text">AAPL stock chart</span></a> by TradingView</div>
  <script type="text/javascript" src="https://s3.tradingview.com/tv.js"></script>
  <script type="text/javascript">
  new TradingView.widget(
  {
  "autosize": true,
  "symbol": "NASDAQ:AAPL",
  "interval": "D",
  "timezone": "Etc/UTC",
  "theme": "light",
  "style": "1",
  "locale": "en",
  "toolbar_bg": "#f1f3f6",
  "enable_publishing": false,
  "allow_symbol_change": true,
  "container_id": "tradingview_83327"
}
  );
  </script>
</div>
<!-- TradingView Widget END -->  
</body>
</html>  
''';

  @override
  void initState() {
    super.initState();
    final String contentBase64 =
        base64Encode(const Utf8Encoder().convert(tradingView));
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
            // onProgress: (int progress) {
            //   // Update loading bar.
            // },
            // onPageStarted: (String url) {},
            // onPageFinished: (String url) {},
            // onWebResourceError: (WebResourceError error) {},
            // onNavigationRequest: (NavigationRequest request) {
            //   if (request.url.startsWith('https://www.youtube.com/')) {
            //     return NavigationDecision.prevent;
            //   }
            //   return NavigationDecision.navigate;
            // },
            ),
      )
      ..loadRequest(Uri.parse('data:text/html;base64,$contentBase64'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Trading view in flutter app"),
      ),
      body: WebViewWidget(controller: _controller!),
    );
  }
}
