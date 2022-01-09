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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checked Chairs'),
      ),
      body: FutureBuilder(
        future: Provider.of<ChairProvider>(context).getChairs(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Consumer<ChairProvider>(
              builder: (context, chairProvider, child) {
                return chairProvider.chairs.isEmpty
                    ? const NoChairs()
                    : ListView.builder(
                        itemCount: chairProvider.chairs.length,
                        itemBuilder: (context, index) {
                          final item = chairProvider.chairs[index];
                          return Dismissible(
                            key: Key(item.id.toString()),
                            background: Container(
                              color: Colors.red,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              alignment: Alignment.centerRight,
                              child: const Text(
                                'Delete',
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.white),
                              ),
                            ),
                            onDismissed: (direction) {
                              chairProvider.deleteChair(item.id);
                            },
                            child: ChairItem(
                              id: item.id,
                              imagePath: item.imagePath,
                              title: item.title,
                              description: item.description,
                              date: item.date,
                              status: item.status,
                            ),
                          );
                        },
                      );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
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
}
