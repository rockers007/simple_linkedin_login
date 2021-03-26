const String USER_CANCELLED_LOGIN = 'user_cancelled_login';
const String USER_CANCELLED_AUTHORIZATION = 'user_cancelled_authorize';
const String EMPTY_RESPONSE = 'empty_auth_response';

const int EMPTY_RESPONSE_STATUS_CODE = -1;

enum LinkedInAuthErrorType {
  // User did not proceed with login
  LoginCancelledByUser,

  // User did not proceed with app authorization
  AuthorizationCancelledByUser,

  // Empty response
  EmptyResponse,

  // Some other reason of failure of login
  Others,
}

/// A class representing the Authentication error while trying to
/// login in linked in using the REST API
///
/// There may be several types of authentication errors, in here mainly
/// Following errors are kept in focus:
///   - Login cancelled by user, when user does not proceed with login
///   - Authorization cancelled by user, hen user does not grant access to data for an app
///
/// Failure/Errors other than these are considered under the [LinkedInAuthErrorType.Others]
class LinkedInAuthError {
  LinkedInAuthError({
    this.errorType = LinkedInAuthErrorType.Others,
    this.description,
    this.statusCode,
  });

  /// Type of error returned in the api response
  LinkedInAuthErrorType errorType;

  /// Error description
  String description;

  /// Status code for the request, may contain the error code
  ///
  /// value: [EMPTY_RESPONSE_STATUS_CODE] means a non-empty response was expected but was found empty
  int statusCode;

  static LinkedInAuthError fromJson(Map<String, dynamic> json) {
    if (json == null || json.isEmpty) {
      return null;
    }
    return LinkedInAuthError(
      errorType: mapAuthErrorToType(json["error"]),
      description: json["error_description"],
    );
  }

  Map<String, dynamic> toJson() => {
        "error": mapAuthTypeToError(errorType),
        "error_description": description,
      };

  static LinkedInAuthErrorType mapAuthErrorToType(error) {
    switch (error) {
      case USER_CANCELLED_LOGIN:
        return LinkedInAuthErrorType.LoginCancelledByUser;
      case USER_CANCELLED_AUTHORIZATION:
        return LinkedInAuthErrorType.AuthorizationCancelledByUser;
      case EMPTY_RESPONSE:
        return LinkedInAuthErrorType.EmptyResponse;
      default:
        return LinkedInAuthErrorType.Others;
    }
  }

  static String mapAuthTypeToError(LinkedInAuthErrorType error) {
    switch (error) {
      case LinkedInAuthErrorType.LoginCancelledByUser:
        return USER_CANCELLED_LOGIN;
      case LinkedInAuthErrorType.AuthorizationCancelledByUser:
        return USER_CANCELLED_AUTHORIZATION;
      case LinkedInAuthErrorType.EmptyResponse:
        return EMPTY_RESPONSE;
      default:
        return 'Others';
    }
  }
}
