import 'package:flutter/material.dart';

import 'url_resources.dart';

const String PROFILE_SCOPE_LITE = 'r_liteprofile%20r_emailaddress';
const String DUMMY_STATE_VALUE = 'DCEeFWf45A53sdfKef424';

/// A utility methods to get url for requesting access token
String getAccessTokenUrl({
  @required String clientId,
  @required String clientSecret,
  @required String redirectUri,
  @required String code,
  @required String grantType,
}) {
  return '$accessTokenUrl?'
      'client_id=$clientId&'
      'client_secret=$clientSecret&'
      'grant_type=$grantType&'
      'code=$code&'
      'redirect_uri=$redirectUri';
}

/// A utility methods to get url for authorization of the linked-in app
/// for login
String getAuthorizationUrl({
  @required String clientId,
  @required String clientSecret,
  @required String redirectUri,
  String responseType = 'code',
  String state = DUMMY_STATE_VALUE,
  String scope = PROFILE_SCOPE_LITE,
}) {
  return '$authorizationUrl?'
      'client_id=$clientId&'
      'client_secret=$clientSecret&'
      'response_type=$responseType&'
      'state=$state&'
      'scope=$scope&'
      'redirect_uri=$redirectUri';
}
