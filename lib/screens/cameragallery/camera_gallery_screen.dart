import 'dart:io';

import 'package:ASmartApp/utils/utility.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

class CameraGalleryScreen extends StatefulWidget {
  CameraGalleryScreen({Key key}) : super(key: key);

  @override
  _CameraGalleryScreenState createState() => _CameraGalleryScreenState();
}

class _CameraGalleryScreenState extends State<CameraGalleryScreen> {

  // ตัวแปรอ่านไฟล์ในเครื่อง
  File _imageFile;
  // ตัวแปรสำหรับเลือกรูป
  final picker = ImagePicker();

  // ฟังก์ชันเปิดแกเลอรี่
  _openGallery(BuildContext context) async{
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if(pickedFile != null){
        _imageFile = File(pickedFile.path);
      }else{
        print('No image selected');
      }
    });
    // ปิด popup
    Navigator.of(context).pop();
  }

  // ฟังก์ชันเปิดกล้องถ่ายภาพ
  _openCamera(BuildContext context) async{
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if(pickedFile != null){
        _imageFile = File(pickedFile.path);
      }else{
        print('No image selected');
      }
    });
    // ปิด popup
    Navigator.of(context).pop();
  }

  // สร้างหน้าต่าง popup เลือกช่องทางในการดึงรูป
  Future<void> _showBottomSheet(BuildContext context){
    return showModalBottomSheet(
      context: context, 
      builder: (BuildContext context){
        return Container(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.photo_album),
                title: Text('แกเลอรี่'),
                onTap: (){
                  _openGallery(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('กล้องถ่ายรูป'),
                onTap: (){
                  _openCamera(context);
                },
              )
            ],
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera and Upload'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              _imageFile == null ? Text('ยังไม่มีการเลือกรูปภาพ') 
              : Image.file(_imageFile, width: 400, height: 400,),
              _imageFile != null ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RaisedButton(
                    onPressed:uploadImage,
                    child: Text('Upload to firebase', style: TextStyle(color: Colors.white),),
                  ),
                  RaisedButton(
                    onPressed:clearImage,
                    child: Text('Clear Image', style: TextStyle(color: Colors.white),),
                  )
                ],
              ) : Container(),
              RaisedButton(
                onPressed: (){
                  _showBottomSheet(context);
                },
                child: Text('เลือกรูปภาพ', style: TextStyle(color: Colors.white),),
              )
            ],
          ),
        ),
      ),
    );
  }

  // ฟังก์ชันอัพโหลดไฟล์ขึ้น firebase
  Future uploadImage() async {
    StorageReference storageReference = FirebaseStorage.instance
    .ref().child('job/${Path.basename(_imageFile.path)}');
    StorageUploadTask uploadTask = storageReference.putFile(_imageFile);
    await uploadTask.onComplete;
    Utility.getInstance().showAlertDialog(
      context, 'Upload Status', 'อัพโหลดไฟล์รูปเรียบร้อยแล้ว'
    );
    clearImage(); // เคลียร์ภาพออกเมื่ออัพโหลดเสร็จ
  }

  // ฟังก์ชันเคลียร์รูปภาพออก
  void clearImage(){
    setState(() {
      _imageFile = null;
    });
  }
  
}