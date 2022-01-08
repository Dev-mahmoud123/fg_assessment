import 'package:fg_assessment/helper/chair_provider.dart';
import 'package:fg_assessment/screens/chair_edit_screen.dart';
import 'package:fg_assessment/widgets/chair_item.dart';
import 'package:fg_assessment/widgets/no_chairs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChairListScreen extends StatelessWidget {
  const ChairListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<ChairProvider>(context).getChairs(),
      builder: (context, snapshot) {
        print(snapshot.data);
        print(snapshot.connectionState);
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Checked Chairs"),
            ),
            body: Consumer<ChairProvider>(
              builder: (context, chairProvider, child) {
                return chairProvider.chairs.isEmpty
                    ? const NoChairs()
                    : ListView.builder(itemBuilder: (context ,index){
                      final item = chairProvider.chairs[index];
                      print(item.imagePath);
                      return ChairItem(
                          id: item.id,
                          imagePath: item.imagePath,
                          title: item.title,
                          description: item.description,
                          date: item.dateTime,
                          status: item.status);
                });
              },
            ),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ChairEditScreen(),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
