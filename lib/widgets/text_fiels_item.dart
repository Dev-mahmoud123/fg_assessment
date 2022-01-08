import 'package:flutter/material.dart';

import '../../widgets/custom_text_field.dart';

class TextFieldItems extends StatelessWidget {
  final TextEditingController titleController,
      descriptionController,
      statusController;

  const TextFieldItems(
      {Key? key,
      required this.titleController,
      required this.descriptionController, required this.statusController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          label: "Title",
          prefixIcon: Icons.title,
          controller: titleController,
          type: TextInputType.text,
          validator: (value) {
            if (value!.isEmpty) {
              return "Title must not be empty";
            }
            return "";
          },
        ),
        const SizedBox(
          height: 8.0,
        ),
        CustomTextField(
          label: "Description",
          controller: descriptionController,
          prefixIcon: Icons.subtitles_outlined,
          type: TextInputType.text,
          validator: (value) {
            if (value!.isEmpty) {
              return "Description must not be empty";
            }
            return "";
          },
        ),
        const SizedBox(
          height: 8.0,
        ),
        CustomTextField(
            label: 'Status',
            hintText: "Open Or Close",
            controller: statusController,
            type: TextInputType.text,
            validator: (String? value) {
              if (value!.isEmpty) {
                return "Status must not be empty";
              }
              return "";
            })
      ],
    );
  }
}
