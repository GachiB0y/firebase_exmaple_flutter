import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/domain/service/firebase_service.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  bool showUserDetails = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drawer Demo'),
        automaticallyImplyLeading: false,
      ),
      drawer: Drawer(
        child: new ListView(
          children: <Widget>[
            new DrawerHeader(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              child: UserAccountsDrawerHeader (
                decoration: BoxDecoration(color: Colors.orange),
                accountName: Text('User name: ${widget.user.displayName}'),
                accountEmail:  Text('User email: ${widget.user.email}'),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('img/1.png'),
                ),
                onDetailsPressed: (){
                  setState(() {
                  showUserDetails = !showUserDetails;
                });},
              ),
            ),
            Expanded(child: Container(
              child: showUserDetails ?
                  TextButton(onPressed: (){}, child: Text('Change avatar'))
                  : null,
            )),
             ListTile(
                title: new Text("О себе"),
                onTap: (){}
            ),
             ListTile(
                title: new Text("Настройки"),
                onTap: (){}
            )
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<User?>(
              stream: FirebaseService().auth.userChanges(),
              builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
                if (snapshot.data == null) {
                  return Text('User not found');
                }
                final user = snapshot.data!;
                user.reload();
                if (user.emailVerified) {
                  return Text('Email: is Verify: ${user.emailVerified}');
                } else {
                  return Column(
                    children: [
                      Text('Email: is Verify: ${user.emailVerified}'),
                      TextButton(
                        onPressed: () {
                          FirebaseService().onVerifyEmail();
                        },
                        child: Text('Verify Email'),
                      ),
                    ],
                  );
                }
              },
            ),
            TextButton(
              onPressed: () {
                FirebaseService().logOut();
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}