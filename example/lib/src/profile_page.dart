import 'package:flutter/material.dart';

import 'user_profile.dart';

/// This is the page which displays the user data
/// when login or sign up is successful
class ProfilePage extends StatefulWidget {
  final UserProfile userProfile;

  const ProfilePage({
    Key key,
    @required this.userProfile,
  })  : assert(userProfile != null, 'user cannot be null'),
        super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Center(
          child: Text(
            'Profile',
            style: textTheme(context).subtitle2.copyWith(
                  fontSize: 24,
                ),
          ),
        ),
        backgroundColor: Theme.of(context).cardColor,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // User's profile picture, if url is not found then it will show a default picture
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: _buildProfilePic(),
                ),
                SizedBox(
                  height: 24,
                ),
                buildText(context, userProfile.name),
                SizedBox(height: 16.0),
                buildText(
                  context,
                  'id: ${userProfile.id}',
                  style: textTheme(context).subtitle2.copyWith(
                        fontSize: 16,
                      ),
                ),
                buildText(
                  context,
                  'email: ${userProfile.email}',
                  style: textTheme(context).subtitle2.copyWith(
                        fontSize: 16,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextTheme textTheme(BuildContext context) => Theme.of(context).textTheme;

  UserProfile get userProfile => widget.userProfile;

  Widget buildText(BuildContext context, String text, {TextStyle style}) {
    return Text(
      text ?? '--',
      style: style ?? textTheme(context).headline4,
    );
  }

  Widget _buildProfilePic() {
    String profilePictureUrl = userProfile.profilePictureUrl;
    if (profilePictureUrl == null || profilePictureUrl.isEmpty) {
      return Container(
        color: Colors.blueAccent.withOpacity(0.5),
        width: 150,
        height: 150,
      );
    }
    return Image.network(
      profilePictureUrl,
      fit: BoxFit.cover,
      height: 150,
      width: 150,
    );
  }
}
