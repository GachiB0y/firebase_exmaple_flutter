import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase/domain/service/firebase_service.dart';
import 'package:flutter_firebase/ui/screens/drawer_widget.dart';
import 'package:flutter_firebase/ui/screens/image_widget.dart';
import 'package:image_picker/image_picker.dart';

class UserInfoScreen extends StatefulWidget {
  UserInfoScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;


  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  bool showUserDetails = false;
  File? image;

  Future pickImage(ImageSource source) async{
    try{
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: source);
      if (image == null) return;

      final iamgeTemporary = File(image.path);

      setState(() {
        this.image = iamgeTemporary;
      });
    }on PlatformException catch(e){
      print("Failed pick image: #e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drawer Demo'),
        automaticallyImplyLeading: false,
      ),
      drawer: DrawerWidget(user: widget.user,image: image,),
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
           image !=null ? AvatarWidget(image: image!,onClicked: (source) =>pickImage(source) ,) : const SizedBox.shrink(),
            TextButton(
              onPressed: () {
                FirebaseService().logOut();
              },
              child: Text('Logout'),
            ),
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
        ),
      ),
    );
  }
}