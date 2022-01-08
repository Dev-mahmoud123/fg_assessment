import 'dart:io';

import 'package:fg_assessment/helper/chair_provider.dart';
import 'package:fg_assessment/screens/Chair_view_Screen.dart';
import 'package:fg_assessment/widgets/text_fiels_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class ChairEditScreen extends StatefulWidget {
  const ChairEditScreen({Key? key}) : super(key: key);

  @override
  State<ChairEditScreen> createState() => _ChairEditScreenState();
}

class _ChairEditScreenState extends State<ChairEditScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  File? _image;

  void getImageFromCamera() async {
    final imageFile = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50);
    if (imageFile != null) {
      var tmpFile = File(imageFile.path);
      print(imageFile.path);
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = basename(appDir.path);
      tmpFile = await tmpFile.copy("${appDir.path}/$fileName");
      setState(() {
        _image = tmpFile;
      });
    }
  }

  void saveChair() {
    String imagePath =  _image!.path;
    String title = titleController.text;
    String description = descriptionController.text;
    String status = statusController.text;
    String date = DateTime.now().millisecondsSinceEpoch.toString();
    int id = 0;
    Provider.of<ChairProvider>(this.context, listen: false).addOrUpdateNote(
       id, imagePath, title, description, date, status, ChairMode.add);
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
    statusController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Chair"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _image == null
                  ? const SizedBox.shrink()
                  : Container(
                      height: 250.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: FileImage(_image!), fit: BoxFit.fill),
                      ),
                    ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: getImageFromCamera,
                child: const Text("Pick image by camera"),
              ),
              Form(
                key: formKey,
                child: TextFieldItems(
                  titleController: titleController,
                  descriptionController: descriptionController,
                  statusController: statusController,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed:saveChair,
                child: const Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
