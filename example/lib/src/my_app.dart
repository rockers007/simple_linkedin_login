import 'package:example/src/profile_page.dart';
import 'package:example/src/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:simple_linkedin_login/simple_linkedin_login.dart';

const String CLIENT_ID = '78fiyvt2a12wcg';
const String CLIENT_SECRET = 'f2s74rjUqc6JkANb';
const String REDIRECT_URL = 'https://www.rockersinfo.com';

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
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return ProfilePage(userProfile: userProfile);
                          },
                        ),
                      );
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
