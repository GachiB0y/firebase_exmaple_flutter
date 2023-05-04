import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase/ui/screens/image_widget.dart';
import 'package:image_picker/image_picker.dart';
class DrawerWidget extends StatefulWidget {
  final User user;
  File? image;

  DrawerWidget({Key? key, required this.user}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  bool showUserDetails = false;

  Future pickImage(ImageSource source) async{
    try{
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: source);
      if (image == null) return;

      final iamgeTemporary = File(image.path);

      setState(() {
        widget.image = iamgeTemporary;
      });
    }on PlatformException catch(e){
      print("Failed pick image: #e");
    }
  }

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
              currentAccountPicture: widget.image !=null ? AvatarWidget(image: widget.image!,onClicked: (source) =>pickImage(source) ,) : const SizedBox.shrink(),
              // CircleAvatar(
              //     child:widget.image!= null ? Image.file(widget.image!) : FlutterLogo(size: 100,),
              // ),
              onDetailsPressed: (){
                setState(() {
                  showUserDetails = !showUserDetails;
                });},
            ),
          ),
          Expanded(child:
              Container(
                child:  showUserDetails ? Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        pickImage(ImageSource.camera);
                      },
                      child: Text('Pick Camera'),
                    ),
                    TextButton(
                      onPressed: () {
                        pickImage(ImageSource.gallery);
                      },
                      child: Text('Pick Gallery'),
                    ),
                  ],
                ) : null ,
              ),
          ),
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
