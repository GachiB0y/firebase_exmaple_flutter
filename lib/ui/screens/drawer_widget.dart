import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class DrawerWidget extends StatefulWidget {
  final User user;
  const DrawerWidget({Key? key, required this.user}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  bool showUserDetails = false;


  @override
  Widget build(BuildContext context) {
    return Drawer(
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
    );
  }
}
