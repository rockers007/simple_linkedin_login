class LinkedInProfile {
  LinkedInProfile({
    this.id,
    this.firstName,
    this.lastName,
    this.profilePictureHandle,
  });

  String id;
  NameHandle firstName;
  NameHandle lastName;
  ProfilePictureHandle profilePictureHandle;

  String get profilePictureUrl => profilePictureHandle
      ?.profilePictureDisplayImage
      ?.elements
      ?.first
      ?.identifiers
      ?.first
      ?.identifier;

  static LinkedInProfile fromJson(Map<String, dynamic> json) {
    if (json == null || json.isEmpty) {
      return null;
    }
    return LinkedInProfile(
      id: json["id"],
      firstName: NameHandle.fromJson(json["firstName"]),
      lastName: NameHandle.fromJson(json["lastName"]),
      profilePictureHandle:
          ProfilePictureHandle.fromJson(json["profilePicture"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName.toJson(),
        "lastName": lastName.toJson(),
        "profilePicture": profilePictureHandle.toJson(),
      };
}

class NameHandle {
  NameHandle({
    this.localized,
    this.preferredLocale,
  });

  LocalizedString localized;
  PreferredLocale preferredLocale;

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

class LocalizedString {
  LocalizedString({
    this.englishUS,
  });

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

class ProfilePictureHandle {
  ProfilePictureHandle({
    this.displayImage,
    this.profilePictureDisplayImage,
  });

  String displayImage;
  DisplayImage profilePictureDisplayImage;

  static ProfilePictureHandle fromJson(Map<String, dynamic> json) {
    if (json == null || json.isEmpty) {
      return null;
    }
    return ProfilePictureHandle(
      displayImage: json["displayImage"],
      profilePictureDisplayImage: DisplayImage.fromJson(json["displayImage~"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "displayImage": displayImage,
        "displayImage~": profilePictureDisplayImage.toJson(),
      };
}

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

class Data {
  Data({
    this.comLinkedinDigitalmediaMediaartifactStillImage,
  });

  ComLinkedInDigitalMediaMediaArtifactStillImage
      comLinkedinDigitalmediaMediaartifactStillImage;

  static Data fromJson(Map<String, dynamic> json) {
    if (json == null || json.isEmpty) {
      return null;
    }
    return Data(
      comLinkedinDigitalmediaMediaartifactStillImage:
          ComLinkedInDigitalMediaMediaArtifactStillImage.fromJson(
              json["com.linkedin.digitalmedia.mediaartifact.StillImage"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "com.linkedin.digitalmedia.mediaartifact.StillImage":
            comLinkedinDigitalmediaMediaartifactStillImage.toJson(),
      };
}

class ComLinkedInDigitalMediaMediaArtifactStillImage {
  ComLinkedInDigitalMediaMediaArtifactStillImage({
    this.mediaType,
    this.rawCodecSpec,
    this.displaySize,
    this.storageSize,
    this.storageAspectRatio,
    this.displayAspectRatio,
  });

  String mediaType;
  RawCodecSpec rawCodecSpec;
  DisplaySize displaySize;
  StorageSize storageSize;
  AspectRatio storageAspectRatio;
  AspectRatio displayAspectRatio;

  static ComLinkedInDigitalMediaMediaArtifactStillImage fromJson(
      Map<String, dynamic> json) {
    if (json == null || json.isEmpty) {
      return null;
    }
    return ComLinkedInDigitalMediaMediaArtifactStillImage(
      mediaType: json["mediaType"],
      rawCodecSpec: RawCodecSpec.fromJson(json["rawCodecSpec"]),
      displaySize: DisplaySize.fromJson(json["displaySize"]),
      storageSize: StorageSize.fromJson(json["storageSize"]),
      storageAspectRatio: AspectRatio.fromJson(json["storageAspectRatio"]),
      displayAspectRatio: AspectRatio.fromJson(json["displayAspectRatio"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "mediaType": mediaType,
        "rawCodecSpec": rawCodecSpec.toJson(),
        "displaySize": displaySize.toJson(),
        "storageSize": storageSize.toJson(),
        "storageAspectRatio": storageAspectRatio.toJson(),
        "displayAspectRatio": displayAspectRatio.toJson(),
      };
}

class AspectRatio {
  AspectRatio({
    this.widthAspect,
    this.heightAspect,
    this.formatted,
  });

  double widthAspect;
  double heightAspect;
  String formatted;

  static AspectRatio fromJson(Map<String, dynamic> json) {
    if (json == null || json.isEmpty) {
      return null;
    }
    return AspectRatio(
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
    this.uom,
    this.height,
  });

  double width;
  String uom;
  double height;

  static DisplaySize fromJson(Map<String, dynamic> json) {
    if (json == null || json.isEmpty) {
      return null;
    }
    return DisplaySize(
      width: double.parse(json["width"].toString()),
      height: double.parse(json["height"].toString()),
      uom: json["uom"],
    );
  }

  Map<String, dynamic> toJson() => {
        "width": width,
        "uom": uom,
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

class ProfileError {
  ProfileError({
    this.serviceErrorCode,
    this.message,
    this.status,
  });

  int serviceErrorCode;
  String message;
  int status;

  static ProfileError fromJson(Map<String, dynamic> json) {
    if (json == null || json.isEmpty) {
      return null;
    }
    return ProfileError(
      serviceErrorCode: json["serviceErrorCode"],
      message: json["message"],
      status: json["status"],
    );
  }

  Map<String, dynamic> toJson() => {
        "serviceErrorCode": serviceErrorCode,
        "message": message,
        "status": status,
      };
}
