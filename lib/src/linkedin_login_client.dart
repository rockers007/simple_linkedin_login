import 'package:flutter/material.dart';

import 'models/models.dart';
import 'utils/utils.dart';
import 'widgets/web_view.dart';

class LinkedInLoginClient {
  static final LinkedInLoginClient _instance = LinkedInLoginClient._internal();

  LinkedInLoginClient._internal();

  /// A Method to initialize the [LinkedInLoginClient] instance.
  ///
  /// Initializing the [LinkedInLoginClient] more than once should not cause any issue,
  /// it will update previous references of data with ones that has been provided
  /// when calling `initialize` again.
  static void initialize(
    BuildContext context, {
    @required String clientId,
    @required String clientSecret,
    @required String redirectUri,
    String accessToken,
  }) {
    _instance.context = context;
    _instance.clientId = clientId;
    _instance.clientSecret = clientSecret;
    _instance.redirectUri = redirectUri;
    _instance.accessToken = accessToken;
  }

  /// Client id from LinkedIn App created to facilitate the login
  String clientId;

  /// Client secret from LinkedIn App
  String clientSecret;

  /// If your authentication is success, then you will be redirected to a web page.
  ///
  /// Since we only requires access token, which already obtained at this stage
  /// we will detect this url in the web view & close the dialog
  String redirectUri;

  /// Access token value, which we can use to skip the initial process of obtaining
  /// the token from linked in api.
  ///
  /// This token is used in all the subsequent requests for fetching user data
  /// for creating a user profile
  ///
  /// Note: The access token has an expiry of approx. 30 mins. after it was
  /// obtained. Which can not be used afterwards. In such cases you'll have to force login
  /// into linked again to obtain the access token
  String accessToken;

  /// Context is used for showing the linkedin login page.
  /// Internally it is shown using a web view inside a fullscreen dialog.
  ///
  ///
  /// Note: Make sure to provide a context which less likely turn up expired.
  /// i.e. A context which is provided from a widget that has been disposed
  /// will cause an internal exception
  ///
  /// Recommended:
  ///   Provide context just from the widget above where user will trigger the
  ///   linkedin login process. i.e a linked in login button's tap or something
  ///   similar to this.
  BuildContext context;

  static Future<String> loginForAccessToken() {
    _checkInst();
    return _instance._loginForAccessToken();
  }

  static void _checkInst() {
    if (_instance == null ||
        _instance.clientId == null ||
        _instance.clientSecret == null)
      throw LinkedInAuthError(
          description: 'You must call the initialize() first');
  }

  Future<String> _loginForAccessToken() async {
    final result = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return LinkedInWebView(
            clientId: clientId,
            clientSecret: clientSecret,
            redirectUri: redirectUri,
          );
        }).catchError((error) {
      if (error is LinkedInAuthError)
        throw error;
      else
        throw LinkedInAuthError(description: error.toString());
    });
    if (result == null) {
      throw LinkedInAuthError(description: 'unknown error');
    }
    if (result is AuthSuccess) {
      accessToken = await getAccessToken(
              clientId: clientId,
              clientSecret: clientSecret,
              redirectUri: redirectUri,
              code: result.code)
          .catchError((error) {
        if (error is LinkedInAuthError) {
          throw error;
        } else {
          throw LinkedInAuthError(description: error.toString());
        }
      });
      return accessToken;
    } else {
      throw result;
    }
  }

  static Future<LinkedInProfile> getProfile({
    bool forceLogin = false,
  }) async {
    _checkInst();
    return _instance._getProfile(
      forceLogin: forceLogin,
    );
  }

  Future<LinkedInProfile> _getProfile({
    bool forceLogin = false,
  }) async {
    if (accessToken == null || forceLogin) {
      await loginForAccessToken();
    }
    return await getProfileResponse(accessToken: accessToken)
        .catchError((error) {
      if (error is LinkedInAuthError)
        throw error;
      else
        throw LinkedInAuthError(description: error.toString());
    });
  }

  static Future<LinkedInEmail> getEmail({
    bool forceLogin = false,
  }) {
    _checkInst();
    return _instance._getEmail(
      forceLogin: forceLogin,
    );
  }

  Future<LinkedInEmail> _getEmail({
    bool forceLogin = false,
  }) async {
    if (accessToken == null || forceLogin) {
      await loginForAccessToken();
    }
    return await getEmailResponse(accessToken: accessToken).catchError((error) {
      if (error is LinkedInAuthError)
        throw error;
      else
        throw LinkedInAuthError(description: error.toString());
    });
  }
}
