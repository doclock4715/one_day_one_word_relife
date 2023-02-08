import 'package:flutter/material.dart';
import 'package:one_day_one_word_relife/pages/home_page.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  await Hive.openBox<List<int>>('knownWords');
  await Hive.openBox<List<int>>('favouriteWords');
  await Hive.openBox<List<int>>('unknownWords');
  await Hive.openBox<List<bool>>("odowAccess");
  await Hive.openBox<int>("odowAccessIndex");
  await Hive.openBox<int>("counter");
  await Hive.openBox<DateTime>("lastEnterDay");
  await Hive.openBox<bool>("firstStart");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
