import 'package:get/get.dart';
import 'package:one_day_one_word_relife/pages/home_page.dart';

import '../db/words.dart';

class OdowController extends GetxController {
  @override
  void onInit() {
    firstStart = HomePage.firstStartBox?.get('firstStart') != null
        ? HomePage.firstStartBox!.get('firstStart')!.obs
        : true.obs;
    super.onInit();
  }

  late Rx<bool> firstStart;

  WordContent wordContent = WordContent();

  var counter = HomePage.odowAccessIndex?.get('counter') != null
      ? HomePage.odowAccessIndex!.get('counter')!.obs
      : 0.obs;
  var boolCounter = HomePage.odowAccessIndex?.get('odowAccessIndex') != null
      ? HomePage.odowAccessIndex!.get('odowAccessIndex')!.obs
      : 1.obs;

  var isShownStateList = HomePage.odowAccess?.get('odowAccess') != null
      ? HomePage.odowAccess!.get('odowAccess')!.obs
      : List<bool>.generate(WordContent().wordEnglish.length, (int index) {
          if (index == 0) {
            return true;
          } else {
            return false;
          }
        }).obs;
  var known = HomePage.knownWordsBox?.get('knowns') != null
      ? HomePage.knownWordsBox!.get('knowns')!.obs
      : List<int>.generate(0, (index) => index).obs;
  var favourites = HomePage.favouriteWordsBox?.get('favourites') != null
      ? HomePage.favouriteWordsBox!.get('favourites')!.obs
      : List<int>.generate(0, (index) => index).obs;
  var unknown = HomePage.unknownWordsBox?.get('unknowns') != null
      ? HomePage.unknownWordsBox!.get('unknowns')!.obs
      : List<int>.generate(0, (index) => index).obs;

  //String olarak store???
  Rx<DateTime> lastEnterDate = HomePage.lastEnterDayBox?.get('lastEnterDay') != null
      ? HomePage.lastEnterDayBox!.get('lastEnterDay')!.obs
      : DateTime.now().obs;

  increment() {
    if (counter.value == wordContent.wordEnglish.length - 1) {
      Get.snackbar(
        "Kelime listemizin sonuna ulaşmış bulunmaktasınız. Gösterdiğiniz ilgi için çok teşekkür ederiz. Yeni kelime eklenirse uygulamayı güncelleyerek ulaşabilirsiniz. Yeni kelimelerde görüşmek üzere. Allah'a emanet olun 😊",
        "One Day One Word",
        duration: const Duration(seconds: 8),
        animationDuration: const Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM,
      );
    } else if (isShownStateList[counter.value + 1] == true) {
      counter++;
    } else {
      String s = howManyHoursTill.call().toString();
      Get.snackbar(
        'Sonraki kelimeye erişim izniniz ${s.substring(0, s.indexOf(':'))} saat ${s.substring(s.indexOf(':') + 1, s.lastIndexOf(':'))} dakika sonra verilecektir.',
        "One Day One Word",
        duration: const Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  decrement() {
    if (counter.value != 0) {
      counter.value--;
    }
  }

  Duration howManyHoursTill() {
    //alttaki kod ne işe yarıyor? lastEnterDate Hive'ını doldurmak için. İlk açılış saati ile dolduruyoruz ": DateTime.now().obs;"
    firstStart.value ? HomePage.lastEnterDayBox!.put('lastEnterDay', lastEnterDate.value) : null;
    firstStart.value = false;
    HomePage.firstStartBox!.put('firstStart', firstStart.value);
    /*    tam bir ay sonraki aynı gün olursa kod patlar gibi
    lastEnterDate.value.day != DateTime.now().day
       if (!(lastEnterDate.value.day == DateTime.now().day)) { */
    if (!(lastEnterDate.value.toString().substring(0, 11) ==
        DateTime.now().toString().substring(0, 11))) {
      var incrementDay = DateTime.now().difference(lastEnterDate.value).inDays;
      for (var i = 0; i < incrementDay; i++) {
        isShownStateList[boolCounter.value] = true;
        HomePage.odowAccess!.put('odowAccess', isShownStateList);
        boolCounter.value++;
        HomePage.odowAccessIndex!.put('odowAccessIndex', boolCounter.value);
      }
      lastEnterDate.value = lastEnterDate.value.add(Duration(days: incrementDay));
      HomePage.lastEnterDayBox!.put('lastEnterDay', lastEnterDate.value);
    }
    return lastEnterDate.value.add(const Duration(days: 1)).difference(DateTime.now());
  }
}
