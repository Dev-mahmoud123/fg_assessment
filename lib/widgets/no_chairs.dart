 import 'package:flutter/material.dart';

class NoChairs extends StatelessWidget {
   const NoChairs({Key? key}) : super(key: key);

   @override
   Widget build(BuildContext context) {
     return const Center(
       child: Text("There is no Checked Chairs available\n tap on add button to add Chair", style: TextStyle(
         color: Colors.black54,
         fontSize: 18,
         fontWeight: FontWeight.bold
       ),
         softWrap: true,
       ),
     );
   }
 }
