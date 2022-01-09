import 'dart:io';
import 'package:fg_assessment/helper/chair_provider.dart';
import 'package:fg_assessment/widgets/text_fiels_item.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../models/chair.dart';

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
  bool firstTime = true;
  late Chair selectedChair;
  late int? id;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (firstTime) {
      id = ModalRoute.of(context)?.settings.arguments as int?;
      if (id != null) {
        selectedChair =
            Provider.of<ChairProvider>(context, listen: false).getChair(id!);
        titleController.text = selectedChair.title;
        descriptionController.text = selectedChair.description;
        statusController.text = selectedChair.status;

        if (selectedChair.imagePath != null) {
          _image = File(selectedChair.imagePath);
        }
      }
      firstTime = false;
    }
  }

  void getImageFromCamera() async {
    final imageFile = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50);
    if (imageFile != null) {
      var tmpFile = File(imageFile.path);
      setState(() {
        _image = tmpFile;
      });
    }
  }

  void saveChair() {
    String imagePath = _image!.path;
    String title = titleController.text;
    String description = descriptionController.text;
    String status = statusController.text;

    if (id != null) {
      Provider.of<ChairProvider>(context, listen: false).addOrUpdateNote(
          id!, imagePath, title, description, status, ChairMode.update);
      Navigator.of(context).pop();
    } else {
      int id = DateTime.now().millisecondsSinceEpoch;
      Provider.of<ChairProvider>(context, listen: false).addOrUpdateNote(
          id, imagePath, title, description, status, ChairMode.add);
      Navigator.of(context).pop();
    }
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
                            image: FileImage(_image!), fit: BoxFit.cover),
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
                onPressed: saveChair,
                child: const Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
