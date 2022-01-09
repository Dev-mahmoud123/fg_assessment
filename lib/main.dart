import 'package:fg_assessment/helper/chair_provider.dart';
import 'package:fg_assessment/screens/chair_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: ChairProvider(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ChairListScreen(),
      ),
    );
  }
}
