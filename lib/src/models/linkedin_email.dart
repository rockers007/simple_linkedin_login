/// A Class representing a wrapper for the email address of the linked-in user.
///
/// Current structure of the email response from linked-in api is quite confusing
/// and a lot more nested to be easily accessible.
///
/// To overcome the direct need of developer to extracting user's email,
/// this class contains a direct getter for extracting [primaryEmail] without
/// going through the trouble of finding it from the response data
///
/// However just in case if in future the response data structure changes to something else,
/// developer can just iterate over the [dataEntries] manually and get the data as needed.
///
/// The developer may have to refer to the linked-in api documents to get the latest
/// data structure for response
///
/// Note: A handle is a container of raw data
class LinkedInEmail {
  LinkedInEmail({this.dataEntries});

  /// Entries of raw data elements that contains email address & some other meta data
  List<DataEntry> dataEntries;

  String get primaryEmail => dataEntries?.first?.emailHandle?.emailAddress;

  static LinkedInEmail fromJson(Map<String, dynamic> json) {
    if (json == null || json.isEmpty) {
      return null;
    }
    return LinkedInEmail(
      dataEntries: List<DataEntry>.from(
        json["elements"].map((x) => DataEntry.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        "elements": List<dynamic>.from(
          dataEntries.map((x) => x.toJson()),
        ),
      };
}

/// A class represent a data entry for email address.
///
/// it has following data:
///  - [handleID] : id of the handle
///  - [emailHandle] : handle instance containing email address value
///  - [emailHandle] : handle instance containing error data for the failure
class DataEntry {
  static const String HANDLE_ID_TAG = 'handle';
  static const String HANDLE_DATA_TAG = 'handle~';
  static const String HANDLE_ERROR_TAG = 'handle!';

  DataEntry({
    this.handleID,
    this.emailHandle,
    this.errorHandle,
  });

  String handleID;
  EmailHandle emailHandle;
  ErrorHandle errorHandle;

  static DataEntry fromJson(Map<String, dynamic> json) {
    if (json == null || json.isEmpty) {
      return null;
    }
    return DataEntry(
      handleID: json[HANDLE_ID_TAG],
      emailHandle: EmailHandle.fromJson(json[HANDLE_DATA_TAG]),
      errorHandle: ErrorHandle.fromJson(json[HANDLE_ERROR_TAG]),
    );
  }

  Map<String, dynamic> toJson() => {
        HANDLE_ID_TAG: handleID,
        HANDLE_DATA_TAG: emailHandle.toJson(),
        HANDLE_ERROR_TAG: errorHandle.toJson(),
      };
}

/// A class represent a handle (container) for email address.
///
/// it has user's [emailAddress]
class EmailHandle {
  EmailHandle({this.emailAddress});

  String emailAddress;

  static EmailHandle fromJson(Map<String, dynamic> json) {
    if (json == null || json.isEmpty) {
      return null;
    }
    return EmailHandle(
      emailAddress: json["emailAddress"],
    );
  }

  Map<String, dynamic> toJson() => {
        "emailAddress": emailAddress,
      };
}

/// A class represent a handle (container) for error.
///
/// it has error details like, [message] & [status]
class ErrorHandle {
  ErrorHandle({this.message, this.status});

  String message;
  int status;

  static ErrorHandle fromJson(Map<String, dynamic> json) {
    if (json == null || json.isEmpty) {
      return null;
    }
    return ErrorHandle(
      message: json["message"],
      status: json["status"],
    );
  }

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
  };
}
