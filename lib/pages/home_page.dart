import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:one_day_one_word_relife/pages/drawer/left_drawer.dart';
import 'package:one_day_one_word_relife/pages/wordLevelPages/a1_page.dart';
import '../controller/odow_controller.dart';
import 'odow_page.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  static Box<List<bool>>? odowAccess;
  static Box<int>? odowAccessIndex;
  static Box<int>? counter;
  static Box<List<int>>? knownWordsBox;
  static Box<List<int>>? favouriteWordsBox;
  static Box<List<int>>? unknownWordsBox;
  static Box<DateTime>? lastEnterDayBox;
  static Box<bool>? firstStartBox;
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    HomePage.odowAccess = Hive.box<List<bool>>('odowAccess');
    HomePage.odowAccessIndex = Hive.box<int>('odowAccessIndex');
    HomePage.counter = Hive.box<int>('counter');
    HomePage.knownWordsBox = Hive.box<List<int>>('knownWords');
    HomePage.favouriteWordsBox = Hive.box<List<int>>('favouriteWords');
    HomePage.unknownWordsBox = Hive.box<List<int>>('unknownWords');
    HomePage.lastEnterDayBox = Hive.box<DateTime>('lastEnterDay');
    HomePage.firstStartBox = Hive.box<bool>('firstStart');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OdowController(), permanent: true);
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Colors.purple, Colors.blue],
            ),
          ),
        ),
        title: const Text("One Day One Word"),
        centerTitle: true,
      ),
      drawer: const LeftDrawer(),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(12, 16, 12, 8),
        children: [
          const Center(
            child: Text(
              "Yeni kelime için kalan süre",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w400),
            ),
          ),
          Center(
            child: SlideCountdownSeparated(
              onDone: () {
                Get.to(() => const HomePage());
              },
              durationTitle: const DurationTitle(
                  days: "Gün", hours: "Saat", minutes: "Dakika", seconds: "Saniye"),
              duration: controller.howManyHoursTill(),
              separatorType: SeparatorType.symbol,
              textStyle:
                  const TextStyle(color: Colors.black, fontSize: 26, fontWeight: FontWeight.w400),
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              separatorStyle:
                  const TextStyle(color: Colors.black, fontSize: 26, fontWeight: FontWeight.w400),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              Get.to(() => const OdowPage());
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(10),
              ),
              height: MediaQuery.of(context).orientation == Orientation.portrait
                  ? screenHeight * 0.17
                  : screenHeight * 0.29,
              child: Row(
                //Icons can be added.
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Shimmer.fromColors(
                      baseColor: Colors.black,
                      highlightColor: Colors.white,
                      child: const Text(
                        "One Day One Word Grubu Kelimeler Listesi",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 15),
          const Center(
            child: Text(
              "Seviyelerine göre kelimeler",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Get.to(() => const A1Page());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffaabcca),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: screenHeight * 0.20,
                    child: Center(
                      child: Shimmer.fromColors(
                        baseColor: Colors.black,
                        highlightColor: Colors.white,
                        child: const Text(
                          "A1 Seviyesi Kelimeler Listesi",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 22, color: Colors.black, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Get.defaultDialog(title: "Plan Aşamasında", middleText: "One Day One Word");
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffffd200),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: screenHeight * 0.20,
                    child: const Center(
                      child: Text(
                        "A2 Seviyesi Kelimeler Listesi",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 22, color: Colors.black, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Get.defaultDialog(title: "Plan Aşamasında", middleText: "One Day One Word");
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xff50C878),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: screenHeight * 0.20,
                    child: const Center(
                      child: Text(
                        "B1 Seviyesi Kelimeler Listesi",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 22, color: Colors.black, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Get.defaultDialog(title: "Plan Aşamasında", middleText: "One Day One Word");
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffb9f2ff),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: screenHeight * 0.20,
                    child: const Center(
                      child: Text(
                        "B2 Seviyesi Kelimeler Listesi",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 22, color: Colors.black, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
