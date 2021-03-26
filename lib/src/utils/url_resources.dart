const String LINKED_IN_AUTH_BASE_API = 'https://www.linkedin.com/oauth/v2';
const String LINKED_IN_DATA_BASE_API = 'https://api.linkedin.com/v2';

String get authorizationUrl => LINKED_IN_AUTH_BASE_API + '/authorization';

String get accessTokenUrl => LINKED_IN_AUTH_BASE_API + '/accessToken';

String get profileUrl =>
    LINKED_IN_DATA_BASE_API + '/me?projection=$profileDataSuffix';

String get profileDataSuffix =>
    '(id,firstName,lastName,profilePicture(displayImage~:playableStreams))';

String get emailUrl =>
    LINKED_IN_DATA_BASE_API +
    '/emailAddress?q=members&projection=$emailDataSuffix';

String get emailDataSuffix => '(elements*(handle~))';
