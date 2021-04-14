import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../models/models.dart';
import '../utils/url_helper.dart';

/// A widget wrapping flutter web view plugin
/// to show the login & authorization pages
///
class LinkedInWebView extends StatefulWidget {
  final String clientId, clientSecret, redirectUri;

  LinkedInWebView({
    @required this.clientId,
    @required this.clientSecret,
    @required this.redirectUri,
  });

  @override
  _LinkedInWebViewState createState() => _LinkedInWebViewState();
}

class _LinkedInWebViewState extends State<LinkedInWebView> {
  @override
  void dispose() {
    super.dispose();
  }

  String get clientId => widget.clientId;

  String get clientSecret => widget.clientSecret;

  String get redirectUri => widget.redirectUri;

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: getAuthorizationUrl(
        clientId: clientId,
        clientSecret: clientSecret,
        redirectUri: redirectUri,
      ),
      onPageStarted: _urlChanged,
      onWebViewCreated: (controller) {
        final cookieManager = CookieManager();
        cookieManager.clearCookies();
      },
    );
  }

  void _urlChanged(String url) {
    // extract URI
    Uri uri = Uri.parse(url);

    if (url.startsWith(redirectUri)) {
      // extract query parameters, for access code
      final queryParameters = uri.queryParameters;
      //handle redirection
      _handleRedirection(queryParameters);
    } else if (url.contains(AUTH_CANCEL_LINK_SUFFIX)) {
      // handle cancellation
      _handleAuthCancel();
    } else if (url.contains(LOGIN_CANCEL_LINK_SUFFIX)) {
      // handle cancellation
      _handleLoginCancel();
    }
  }

  void _handleLoginCancel() {
    dynamic result = LinkedInAuthError(
      errorType: LinkedInAuthErrorType.LoginCancelledByUser,
      description: 'Login cancelled by user',
    );
    Navigator.pop(context, result);
  }

  void _handleAuthCancel() {
    dynamic result = LinkedInAuthError(
      errorType: LinkedInAuthErrorType.AuthorizationCancelledByUser,
      description: 'Authorization cancelled by user',
    );
    Navigator.pop(context, result);
  }

  void _handleRedirection(Map<String, String> queryParameters) {
    final hasSuccessCode = queryParameters.containsKey('code');
    final hasErrorCode = queryParameters.containsKey('error');

    dynamic result;

    if (queryParameters == null) {
      result = LinkedInAuthError(
        description: 'Empty query parameters found in response of the process',
        errorType: LinkedInAuthErrorType.EmptyResponse,
        statusCode: EMPTY_RESPONSE_STATUS_CODE,
      );
    } else if (hasSuccessCode) {
      result = AuthSuccess.fromJson(queryParameters);
    } else if (hasErrorCode) {
      result = LinkedInAuthError.fromJson(queryParameters);
    }
    Navigator.pop(context, result);
  }
}
