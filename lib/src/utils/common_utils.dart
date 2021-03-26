import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/models.dart';
import 'url_helper.dart';
import 'url_resources.dart';

typedef FromJsonToInstance<T> = T Function(Map<String, dynamic>);
typedef FromInstanceToJson<T> = Map<String, dynamic> Function(T);

T fromJsonString<T>(String jsonString, FromJsonToInstance<T> fromJson) =>
    fromJson(jsonDecode(jsonString));

String toJsonString<T>(T instance, FromInstanceToJson<T> toJson) =>
    jsonEncode(toJson(instance));

Future<String> getAccessToken({
  @required String clientId,
  @required String clientSecret,
  @required String redirectUri,
  @required String code,
  String grantType = 'authorization_code',
}) async {
  var accessTokenUrl = getAccessTokenUrl(
      clientId: clientId,
      clientSecret: clientSecret,
      redirectUri: redirectUri,
      grantType: grantType,
      code: code);

  final response = await http.get(Uri.parse(accessTokenUrl));
  final json = jsonDecode(response.body);
  if (response.statusCode == 200) {
    return json['access_token'];
  } else {
    throw LinkedInAuthError(
        errorType: LinkedInAuthErrorType.Others,
        description: json['error_description']);
  }
}

Future<LinkedInEmail> getEmailResponse({
  @required String accessToken,
}) async {
  final response = await http.get(Uri.parse(emailUrl),
      headers: {'Authorization': 'Bearer $accessToken'});

  if (response.statusCode == 200) {
    return fromJsonString<LinkedInEmail>(
      response.body,
      LinkedInEmail.fromJson,
    );
  } else {
    final error = fromJsonString<ProfileError>(
      response.body,
      ProfileError.fromJson,
    );
    throw LinkedInAuthError(
      description: error.message,
      statusCode: error.status,
    );
  }
}

Future<LinkedInProfile> getProfileResponse(
    {@required String accessToken}) async {
  final response = await http.get(Uri.parse(profileUrl),
      headers: {'Authorization': 'Bearer $accessToken'});

  if (response.statusCode == 200) {
    return fromJsonString<LinkedInProfile>(
      response.body,
      LinkedInProfile.fromJson,
    );
  } else {
    final error = fromJsonString<ProfileError>(
      response.body,
      ProfileError.fromJson,
    );
    throw LinkedInAuthError(
      description: error.message,
      statusCode: error.status,
    );
  }
}
