# simple_linkedin_login

[![pub package](https://img.shields.io/pub/v/simple_linkedin_login.svg)](https://pub.dev/packages/simple_linkedin_login)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

Linked-in login client to help with login into a flutter app easily. Linked-in REST api is used for accessing user data.

## Features
  - A simple code to use
      * Initialize the client with a live context & linked-in app details
	    - linked-in developer console : [https://www.linkedin.com/developers/](https://www.linkedin.com/developers/)
      * Fetch Email from user's linked-in profile
        - may need to login, developer can force login
      * Fetch Profile data from user's linked-in profile
        - includes basically everything that is included in linked-in lite profile
        - may need to login, developer can force login

#####l̥ Initializing the plugin
Initialize the plugin as following:
```dart
LinkedInLoginClient.initialize(
	context,
	clientId: 'CLIENT_ID',
	clientSecret: 'CLIENT_SECRET',
	redirectUri: 'REDIRECT_URL',
	);
```

**Note**:
CLIENT_ID, CLIENT_SECRET & REDIRECT_URL must belong a ready to use linked-in app


##### Fetch Primary Email address:

```dart
 final emailData = await LinkedInLoginClient.getEmail(forceLogin: true); // force login is optional
 print('email: ${emailData.primaryEmail}');
```

##### Fetch Basic profile details:

```dart
 final profileData = await LinkedInLoginClient.getProfile(forceLogin: true); // force login is optional
 print('profile: \n name: ${profileData.fullName} \n id: ${profileData.id} '
            '\n profilePictureURL: ${profileData.profilePictureUrl}');
```

### Example code:
```dart
import 'package:flutter/material.dart';
import 'package:simple_linkedin_login/simple_linkedin_login.dart';

class UserProfile {
  final String name;
  final String email;
  final String id;
  final String profilePictureUrl;

  UserProfile({
    this.name,
    this.email,
    this.id,
    this.profilePictureUrl,
  });

  @override
  String toString() {
    return 'AppUser{name: $name, email: $email, id: $id, profilePicture: $profilePictureUrl}';
  }
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LinkedIn Login Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'LinkedIn Login'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    LinkedInLoginClient.initialize(
      context,
      clientId: CLIENT_ID,
      clientSecret: CLIENT_SECRET,
      redirectUri: REDIRECT_URL,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final userProfile = await _obtainUserData(context);
                      print(
                          '_MyHomePageState: build: userProfile: $userProfile');
                    },
                    child: Text('Login using linked in'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<UserProfile> _obtainUserData(BuildContext context) async {
    final emailData = await LinkedInLoginClient.getEmail(forceLogin: true);
    final profileData = await LinkedInLoginClient.getProfile();

    assert(emailData != null && profileData != null);

    return UserProfile(
      email: emailData.primaryEmail,
      id: profileData.id,
      name: profileData.fullName,
      profilePictureUrl: profileData.profilePictureUrl,
    );
  }
}
```

## Contribution/Support
File an issue on repository, if something is not working as expected or you want a new feature to be added.
All help and Pull requests are most welcome.

Standard coding practices & a polite attitude are expected & served.