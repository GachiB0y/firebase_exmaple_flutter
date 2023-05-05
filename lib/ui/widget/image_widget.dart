import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AvatarWidget extends StatelessWidget {
  final File image;
  final ValueChanged<ImageSource> onClicked;
  const AvatarWidget({Key? key, required this.image, required this.onClicked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          buildImage(context),
          Positioned(
            bottom: 0,
              right: 4,
              child: Icon(Icons.photo_camera_front_rounded,color: Colors.white,)
          ),
        ],
      ),
    );
  }

  Widget buildImage(BuildContext context){
    final imagePath = this.image.path;
    final image = imagePath.contains('https://') ? NetworkImage(imagePath) : FileImage(File(imagePath));

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
            image: image as ImageProvider,
          fit: BoxFit.cover,
          width: 140,
          height: 140,
          child: InkWell(
            onTap: () async {
              final source = await showImageSource(context);

              if(source == null) return;
              onClicked(source);
            },
          ),
        ),
      ),
    );
  }

  Future<ImageSource?> showImageSource(BuildContext context) async{
    if (Platform.isIOS){
      return showCupertinoModalPopup<ImageSource>(
          context: context,
          builder: (context) => CupertinoActionSheet(
            actions: [
              CupertinoActionSheetAction(onPressed: () => Navigator.of(context).pop(ImageSource.camera) ,  child: const Text("Camera")),
              CupertinoActionSheetAction(onPressed: () => Navigator.of(context).pop(ImageSource.gallery) ,  child: const Text("Gallery")),
            ],
          ),
      );
    }else{
      return showModalBottomSheet(
          context: context,
          builder: (context) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Camera"),
                onTap: () => Navigator.of(context).pop(ImageSource.camera) ,
              ),ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Gallery"),
                onTap: () => Navigator.of(context).pop(ImageSource.gallery) ,
              ),
            ],
          ),
      );
    }
  }
}
