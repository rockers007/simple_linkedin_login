/// A class representing the Authentication Success while trying to
/// login in linked in using the REST API
///
/// Instance of this class will have two properties:
///   - code: An authorization code provided by linkedin api
///   - state: A random code provided by linked in api to prevent
///     CSRF [https://en.wikipedia.org/wiki/Cross-site_request_forgery]
class AuthSuccess {
  AuthSuccess({
    this.code,
    this.state,
  });

  /// An authorization code provided by linkedin api
  String code;

  /// A random code provided by linked in api to prevent
  ///     CSRF [https://en.wikipedia.org/wiki/Cross-site_request_forgery]
  String state;

  static AuthSuccess fromJson(Map<String, dynamic> json) {
    if (json == null || json.isEmpty) {
      return null;
    }
    return AuthSuccess(
      code: json["code"],
      state: json["state"],
    );
  }

  Map<String, dynamic> toJson() => {
        "code": code,
        "state": state,
      };
}
