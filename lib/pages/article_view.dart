import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// The ArticleView widget shows a web page in a WebView based on the provided blogUrl .
class ArticleView extends StatefulWidget {
  final String blogUrl;

  const ArticleView({required this.blogUrl});

  @override
  State<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  late final WebViewController
      _controller; // Controller for managing the WebView

  @override
  void initState() {
    super.initState();
    // Initialize the WebViewController and load the specified URL
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode
          .unrestricted) // Allow JavaScript execution in the WebView
      ..loadRequest(
          Uri.parse(widget.blogUrl)); // Load the web page from the provided URL
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("News"),
              Text(
                "24x7",
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              )
            ],
          ),
          centerTitle: true,
          elevation: 0.0, // No elevation for the app bar
        ),
        body: Container(
          child: WebViewWidget(
              controller: _controller), // Display the web page in the WebView
        ));
  }
}
