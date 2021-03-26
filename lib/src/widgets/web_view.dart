import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../models/models.dart';
import '../utils/url_helper.dart';

class LinkedInWebView extends StatefulWidget {
  final String clientId, clientSecret, redirectUri;
  final bool clearDataAfterSession;

  LinkedInWebView({
    @required this.clientId,
    @required this.clientSecret,
    @required this.redirectUri,
    this.clearDataAfterSession = true,
  });

  @override
  _LinkedInWebViewState createState() => _LinkedInWebViewState();
}

class _LinkedInWebViewState extends State<LinkedInWebView> {
  WebViewController _controller;

  @override
  void dispose() {
    if (widget.clearDataAfterSession) {
      _controller.clearCache();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: getAuthorizationUrl(
        clientId: widget.clientId,
        clientSecret: widget.clientSecret,
        redirectUri: widget.redirectUri,
      ),
      onWebViewCreated: (controller) => _controller = controller,
      onPageStarted: _urlChanged,
    );
  }

  void _urlChanged(String url) {
    if (url.startsWith(widget.redirectUri)) {
      Uri uri = Uri.parse(url);
      final queryParameters = uri.queryParameters;

      final hasSuccessCode = queryParameters.containsKey('code');
      final hasErrorCode = queryParameters.containsKey('error');

      dynamic result;
      if (queryParameters == null) {
        result = LinkedInAuthError(
          description:
              'Empty query parameters found in response of the process',
          errorType: LinkedInAuthErrorType.EmptyResponse,
          statusCode: EMPTY_RESPONSE_STATUS_CODE,
        );
      } else if (hasSuccessCode) {
        result = AuthSuccess.fromJson(queryParameters);
      } else if (hasErrorCode) {
        result = LinkedInAuthError.fromJson(queryParameters);
      } else {}
      Navigator.pop(context, result);
    }
  }
}
