class LinkedInEmail {
  LinkedInEmail({
    this.dataEntries,
  });

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

class EmailHandle {
  EmailHandle({
    this.emailAddress,
  });

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

class ErrorHandle {
  ErrorHandle({
    this.message,
    this.status,
  });

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
