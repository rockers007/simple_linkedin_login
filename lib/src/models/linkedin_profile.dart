/// A Class representing a wrapper for the Profile data of the linked-in user.
///
/// Current structure of the profile response from linked-in api is quite confusing
/// and a lot more nested to be easily accessible.
///
/// To overcome the direct need of developer to extracting user's profile data,
/// this class contains a direct getters for extracting [id], [firstName], [lastName],
/// [preferredLocale], [preferredLanguage] and [profilePictureUrl] without going
/// through the trouble of finding it from the response data
///
/// While [id] is easily accessible the complex part of this data
/// is [firstNameHandle], [lastNameHandle] & [profilePictureHandle] at the moment.
///
/// Just in case if in future the response data structure changes to something else,
/// developer can just process the related handle object manually and get the data as needed.
///
/// The developer may have to refer to the linked-in api documents to get the latest
/// data structure for response
///
/// Note: A handle is a container of raw data
class LinkedInProfile {
  LinkedInProfile({
    this.id,
    this.firstNameHandle,
    this.lastNameHandle,
    this.profilePictureHandle,
  });

  /// Unique Identifier assigned to user by linked-in
  String id;

  /// Raw data element that contains user's first name & some other meta data
  NameHandle firstNameHandle;

  /// Raw data element that contains user's last name & some other meta data
  NameHandle lastNameHandle;

  /// Entries of raw data elements that contains profile picture & some other meta data
  ProfilePictureHandle profilePictureHandle;

  /// getter for first name value
  String get firstName => firstNameHandle?.name;

  /// getter for last name value
  String get lastName => lastNameHandle?.name;

  /// getter for preferred locale
  String get preferredLocale => firstNameHandle?.country;

  /// getter for preferred language
  String get preferredLanguage => firstNameHandle?.language;

  /// getter for profile picture url value
  String get profilePictureUrl => profilePictureHandle?.profilePictureUrl;

  static LinkedInProfile fromJson(Map<String, dynamic> json) {
    if (json == null || json.isEmpty) {
      return null;
    }
    return LinkedInProfile(
      id: json["id"],
      firstNameHandle: NameHandle.fromJson(json["firstName"]),
      lastNameHandle: NameHandle.fromJson(json["lastName"]),
      profilePictureHandle:
          ProfilePictureHandle.fromJson(json["profilePicture"]),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "firstName": firstNameHandle.toJson(),
        "lastName": lastNameHandle.toJson(),
        "profilePicture": profilePictureHandle.toJson(),
      };
}

/// A class represent a handle (container) for first name of the user.
class NameHandle {
  NameHandle({
    this.localized,
    this.preferredLocale,
  });

  LocalizedString localized;
  PreferredLocale preferredLocale;

  String get name => localized?.englishUS;

  String get country => preferredLocale?.country;

  String get language => preferredLocale?.language;

  static NameHandle fromJson(Map<String, dynamic> json) {
    if (json == null || json.isEmpty) {
      return null;
    }
    return NameHandle(
      localized: LocalizedString.fromJson(json["localized"]),
      preferredLocale: PreferredLocale.fromJson(json["preferredLocale"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "localized": localized.toJson(),
        "preferredLocale": preferredLocale.toJson(),
      };
}

/// A container for localized strings, with various localizations
///
/// Currently only one localization is supported: English-US
class LocalizedString {
  LocalizedString({
    this.englishUS,
  });

  /// Name in English-US localization
  String englishUS;

  static LocalizedString fromJson(Map<String, dynamic> json) {
    if (json == null || json.isEmpty) {
      return null;
    }
    return LocalizedString(
      englishUS: json["en_US"],
    );
  }

  Map<String, dynamic> toJson() => {
    "en_US": englishUS,
  };
}

/// A container for user's preferred country & language
class PreferredLocale {
  PreferredLocale({
    this.country,
    this.language,
  });

  String country;
  String language;

  static PreferredLocale fromJson(Map<String, dynamic> json) {
    if (json == null || json.isEmpty) {
      return null;
    }
    return PreferredLocale(
      country: json["country"],
      language: json["language"],
    );
  }

  Map<String, dynamic> toJson() => {
        "country": country,
        "language": language,
      };
}

/// A container for user's profile picture with raw data & a getter [profilePictureUrl]
/// to easily access the profile picture url
class ProfilePictureHandle {
  ProfilePictureHandle({
    this.displayImage,
    this.profilePictureDisplayImageHandle,
  });

  String displayImage;
  DisplayImage profilePictureDisplayImageHandle;

  String get profilePictureUrl => profilePictureDisplayImageHandle
      ?.elements?.first?.identifiers?.first?.identifier;

  static ProfilePictureHandle fromJson(Map<String, dynamic> json) {
    if (json == null || json.isEmpty) {
      return null;
    }
    return ProfilePictureHandle(
      displayImage: json["displayImage"],
      profilePictureDisplayImageHandle:
          DisplayImage.fromJson(json["displayImage~"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "displayImage": displayImage,
        "displayImage~": profilePictureDisplayImageHandle.toJson(),
      };
}

/// A top level intermediate container for raw data of user's profile picture
///
/// Not going into much details, refer to linked-in api's response document for
/// understanding the usage of this class
class DisplayImage {
  DisplayImage({
    this.paging,
    this.elements,
  });

  Paging paging;
  List<Element> elements;

  static DisplayImage fromJson(Map<String, dynamic> json) {
    if (json == null || json.isEmpty) {
      return null;
    }
    return DisplayImage(
      paging: Paging.fromJson(json["paging"]),
      elements:
          List<Element>.from(json["elements"].map((x) => Element.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "paging": paging.toJson(),
        "elements": List<dynamic>.from(elements.map((x) => x.toJson())),
      };
}

/// A middle level intermediate container for raw data of user's profile picture
///
/// Not going into much details, refer to linked-in api's response document for
/// understanding the usage of this class
class Element {
  Element({
    this.artifact,
    this.authorizationMethod,
    this.data,
    this.identifiers,
  });

  String artifact;
  String authorizationMethod;
  Data data;
  List<Identifier> identifiers;

  static Element fromJson(Map<String, dynamic> json) {
    if (json == null || json.isEmpty) {
      return null;
    }
    return Element(
      artifact: json["artifact"],
      authorizationMethod: json["authorizationMethod"],
      data: Data.fromJson(json["data"]),
      identifiers: List<Identifier>.from(
          json["identifiers"].map((x) => Identifier.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "artifact": artifact,
        "authorizationMethod": authorizationMethod,
        "data": data.toJson(),
        "identifiers": List<dynamic>.from(identifiers.map((x) => x.toJson())),
      };
}

/// A low level container for raw data of user's profile picture
///
/// Not going into much details, refer to linked-in api's response document for
/// understanding the usage of this class
class Data {
  Data({this.artifactStillImage});

  ArtifactStillImage artifactStillImage;

  static Data fromJson(Map<String, dynamic> json) {
    if (json == null || json.isEmpty) {
      return null;
    }
    return Data(
      artifactStillImage: ArtifactStillImage.fromJson(
          json["com.linkedin.digitalmedia.mediaartifact.StillImage"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "com.linkedin.digitalmedia.mediaartifact.StillImage":
            artifactStillImage.toJson(),
      };
}

/// A Container for still image provided in the response of the profile picture
///
/// Also Contains meta data about the image.
class ArtifactStillImage {
  ArtifactStillImage({
    this.mediaType,
    this.rawCodecSpec,
    this.displaySize,
    this.storageSize,
    this.storageAspect,
    this.displayAspect,
  });

  String mediaType;
  RawCodecSpec rawCodecSpec;
  DisplaySize displaySize;
  StorageSize storageSize;
  DimensionAspect storageAspect;
  DimensionAspect displayAspect;

  static ArtifactStillImage fromJson(Map<String, dynamic> json) {
    if (json == null || json.isEmpty) {
      return null;
    }
    return ArtifactStillImage(
      mediaType: json["mediaType"],
      rawCodecSpec: RawCodecSpec.fromJson(json["rawCodecSpec"]),
      displaySize: DisplaySize.fromJson(json["displaySize"]),
      storageSize: StorageSize.fromJson(json["storageSize"]),
      storageAspect: DimensionAspect.fromJson(json["storageAspectRatio"]),
      displayAspect: DimensionAspect.fromJson(json["displayAspectRatio"]),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        "mediaType": mediaType,
        "rawCodecSpec": rawCodecSpec.toJson(),
        "displaySize": displaySize.toJson(),
        "storageSize": storageSize.toJson(),
        "storageAspectRatio": storageAspect.toJson(),
        "displayAspectRatio": displayAspect.toJson(),
      };
}

class DimensionAspect {
  DimensionAspect({this.widthAspect, this.heightAspect, this.formatted});

  double widthAspect;
  double heightAspect;
  String formatted;

  static DimensionAspect fromJson(Map<String, dynamic> json) {
    if (json == null || json.isEmpty) {
      return null;
    }
    return DimensionAspect(
      widthAspect: double.parse(json["widthAspect"].toString()),
      heightAspect: double.parse(json["heightAspect"].toString()),
      formatted: json["formatted"],
    );
  }

  Map<String, dynamic> toJson() => {
    "widthAspect": widthAspect,
    "heightAspect": heightAspect,
    "formatted": formatted,
  };
}

class DisplaySize {
  DisplaySize({
    this.width,
    this.height,
  });

  double width;
  double height;

  static DisplaySize fromJson(Map<String, dynamic> json) {
    if (json == null || json.isEmpty) {
      return null;
    }
    return DisplaySize(
      width: double.parse(json["width"].toString()),
      height: double.parse(json["height"].toString()),
    );
  }

  Map<String, dynamic> toJson() => {
    "width": width,
    "height": height,
  };
}

class RawCodecSpec {
  RawCodecSpec({
    this.name,
    this.type,
  });

  String name;
  String type;

  static RawCodecSpec fromJson(Map<String, dynamic> json) {
    if (json == null || json.isEmpty) {
      return null;
    }
    return RawCodecSpec(
      name: json["name"],
      type: json["type"],
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "type": type,
  };
}

class StorageSize {
  StorageSize({
    this.width,
    this.height,
  });

  double width;
  double height;

  static StorageSize fromJson(Map<String, dynamic> json) {
    if (json == null || json.isEmpty) {
      return null;
    }
    return StorageSize(
      width: double.parse(json["width"].toString()),
      height: double.parse(json["height"].toString()),
    );
  }

  Map<String, dynamic> toJson() => {
    "width": width,
    "height": height,
  };
}

class Identifier {
  Identifier({
    this.identifier,
    this.index,
    this.mediaType,
    this.file,
    this.identifierType,
    this.identifierExpiresInSeconds,
  });

  String identifier;
  int index;
  String mediaType;
  String file;
  String identifierType;
  int identifierExpiresInSeconds;

  static Identifier fromJson(Map<String, dynamic> json) {
    if (json == null || json.isEmpty) {
      return null;
    }
    return Identifier(
      identifier: json["identifier"],
      index: json["index"],
      mediaType: json["mediaType"],
      file: json["file"],
      identifierType: json["identifierType"],
      identifierExpiresInSeconds: json["identifierExpiresInSeconds"],
    );
  }

  Map<String, dynamic> toJson() => {
    "identifier": identifier,
    "index": index,
    "mediaType": mediaType,
    "file": file,
    "identifierType": identifierType,
    "identifierExpiresInSeconds": identifierExpiresInSeconds,
  };
}

class Paging {
  Paging({
    this.count,
    this.start,
    this.links,
  });

  int count;
  int start;
  List<dynamic> links;

  static Paging fromJson(Map<String, dynamic> json) {
    if (json == null || json.isEmpty) {
      return null;
    }
    return Paging(
      count: json["count"],
      start: json["start"],
      links: List<dynamic>.from(json["links"].map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "count": count,
        "start": start,
        "links": List<dynamic>.from(links.map((x) => x)),
      };
}

/// A class presenting an error occurred while fetching profile data
/// from the linked-in api
///
/// It contains data like,
///  - [message]: describing the error
///  - [statusCode]: status code
///  - [errorCode]: error code
///
///
class ProfileError {
  ProfileError({
    this.message,
    this.statusCode,
    this.errorCode,
  });

  String message;
  int statusCode;
  int errorCode;

  static ProfileError fromJson(Map<String, dynamic> json) {
    if (json == null || json.isEmpty) {
      return null;
    }
    return ProfileError(
      message: json["message"],
      statusCode: json["status"],
      errorCode: json["serviceErrorCode"],
    );
  }

  Map<String, dynamic> toJson() =>
      {
        "message": message,
        "status": statusCode,
        "serviceErrorCode": errorCode,
      };
}
