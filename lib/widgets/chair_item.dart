import 'dart:io';
import 'package:fg_assessment/screens/chair_edit_screen.dart';
import 'package:fg_assessment/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class ChairItem extends StatelessWidget {
  final int? id;
  final String imagePath;
  final String title;
  final String description;
  final String date;
  final String status;

  const ChairItem({
    Key? key,
    this.id,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.date,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const ChairEditScreen(),
            settings: RouteSettings(
              arguments: id,
            )));
      },
      child: Stack(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            margin: const EdgeInsetsDirectional.all(8.0),
            elevation: 2,
            child: Row(
              children: [
                // image
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: FileImage(File(imagePath)), fit: BoxFit.fill),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(text: title, fontSize: 15, fieldName: "Title"),
                      const SizedBox(
                        width: 5,
                      ),
                      CustomText(
                          text: description,
                          fontSize: 14,
                          fieldName: "Description"),
                      const SizedBox(
                        width: 5,
                      ),
                      CustomText(
                          text: status, fontSize: 14, fieldName: "Status"),
                      const SizedBox(
                        width: 5,
                      ),
                      CustomText(
                        text: date,
                        fontSize: 14,
                        fieldName: "Date_Time",
                        color: Colors.black54,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
