import 'dart:io';

import 'package:fg_assessment/screens/Chair_view_Screen.dart';
import 'package:flutter/material.dart';

class ChairItem extends StatelessWidget {
  final int? id;
  final String imagePath;
  final String title;
  final String description;
  final String date;
  final String status;

  const ChairItem(
      {Key? key,
      this.id,
      required this.imagePath,
      required this.title,
      required this.description,
      required this.date,
      required this.status})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const ChairViewScreen(),
            settings: RouteSettings(arguments: id)));
      },
      child: Card(
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title),
                Text(description),
                Text(date),
                Text(status),
              ],
            )

            // column -- > Title - description -  date - time - status
          ],
        ),
      ),
    );
  }
}
