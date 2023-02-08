import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/gradient_box_decoration.dart';
import '../controller/odow_controller.dart';
import '../db/words.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'drawer/odow_right_drawer.dart';
import 'home_page.dart';

class OdowPage extends StatefulWidget {
  const OdowPage({super.key});

  @override
  State<OdowPage> createState() => _OdowPageState();
}

class _OdowPageState extends State<OdowPage> {
  final FlutterTts flutterTts = FlutterTts();
  WordContent wordContent = WordContent();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OdowController(), permanent: true);
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: gradientBoxDecoration(),
        ),
        title: const Text("One Day One Word"),
        centerTitle: true,
      ),
      endDrawer: RightDrawer(),
      body: Obx(
        () => ListView(
          padding: const EdgeInsets.all(8),
          children: [
            Text(
              '${controller.counter.value + 1}. ${wordContent.wordEnglish[controller.counter.value]}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 34),
            ),
            const SizedBox(height: 10),
            buildPronunciationRow(context, controller.counter.value),
            const SizedBox(height: 10),
            Text(
              wordContent.wordTurkish[controller.counter.value],
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 34),
            ),
            const SizedBox(height: 15),
            Text(
              wordContent.wordMeaning[controller.counter.value],
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: controller.decrement,
              icon: const Icon(Icons.arrow_back_sharp),
            ),
            IconButton(
              onPressed: () => checkButtonOnPressed(controller.counter.value, controller),
              icon: const Icon(Icons.check_sharp),
              color: Colors.green,
            ),
            IconButton(
              onPressed: () => starButtonOnPressed(controller.counter.value, controller),
              icon: const Icon(Icons.star_border_sharp),
              color: Colors.yellow,
            ),
            IconButton(
              onPressed: () => cancelButtonOnPressed(controller.counter.value, controller),
              icon: const Icon(Icons.cancel_outlined),
              color: Colors.red,
            ),
            IconButton(
              onPressed: controller.increment,
              icon: const Icon(Icons.arrow_forward_sharp),
            ),
          ],
        ),
      ),
    );
  }

  Row buildPronunciationRow(BuildContext context, int wordCounter) {
    void speak({required String accentName}) {
      flutterTts.setLanguage(accentName);
      flutterTts.speak(wordContent.wordEnglish[wordCounter]);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            icon: const Icon(Icons.volume_up_sharp), onPressed: () => speak(accentName: 'en-US')),
        Text('Amerikan Aksanı', style: Theme.of(context).textTheme.subtitle1),
        const SizedBox(width: 20),
        IconButton(
            icon: const Icon(Icons.volume_up_sharp), onPressed: () => speak(accentName: 'en-GB')),
        Text('İngiliz Aksanı', style: Theme.of(context).textTheme.subtitle1),
      ],
    );
  }

  void checkButtonOnPressed(int wordCounter, OdowController controller) {
    var currentNumber = wordCounter;
    if (!controller.known.contains(currentNumber)) {
      controller.known.add(currentNumber);
      HomePage.knownWordsBox!.put('knowns', controller.known);
      Get.snackbar(
        "Bilinen kelimeler listesine eklendi.",
        "One Day One Word",
        duration: const Duration(seconds: 1,milliseconds: 500),
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      Get.snackbar(
        "Bilinen kelimeler listesine önceden eklenmişti.",
        "One Day One Word",
        duration: const Duration(seconds: 1,milliseconds: 500),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void starButtonOnPressed(int wordCounter, OdowController controller) {
    var currentNumber = wordCounter;
    if (!controller.favourites.contains(currentNumber)) {
      controller.favourites.add(currentNumber);
      HomePage.favouriteWordsBox!.put('favourites', controller.favourites);
      Get.snackbar(
        "Favori kelimeler listesine eklendi.",
        "One Day One Word",
        duration: const Duration(seconds: 1,milliseconds: 500),
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      Get.snackbar(
        "Favori kelimeler listesine önceden eklenmişti.",
        "One Day One Word",
         duration: const Duration(seconds: 1,milliseconds: 500),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void cancelButtonOnPressed(int wordCounter, OdowController controller) {
    var currentNumber = wordCounter;
    if (!controller.unknown.contains(currentNumber)) {
      controller.unknown.add(currentNumber);
      HomePage.unknownWordsBox!.put('unknowns', controller.unknown);
      Get.snackbar(
        "Bilinmeyen kelimeler listesine eklendi.",
        "One Day One Word",
         duration: const Duration(seconds: 1,milliseconds: 500),
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      Get.snackbar(
        "Bilinmeyen kelimeler listesine önceden eklenmişti.",
        "One Day One Word",
        duration: const Duration(seconds: 1,milliseconds: 500),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
