import 'package:flutter/material.dart';

import 'url_resources.dart';

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

String getAuthorizationUrl(
    {@required String clientId,
    @required String clientSecret,
    @required String redirectUri,
    String responseType = 'code',
    String state = 'DCEeFWf45A53sdfKef424',
    String scope = 'r_liteprofile%20r_emailaddress'}) {
  return '$authorizationUrl?'
      'client_id=$clientId&'
      'client_secret=$clientSecret&'
      'response_type=$responseType&'
      'state=$state&'
      'scope=$scope&'
      'redirect_uri=$redirectUri';
}
