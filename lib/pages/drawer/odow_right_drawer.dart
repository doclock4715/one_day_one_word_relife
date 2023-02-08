import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/gradient_box_decoration.dart';
import '../../controller/odow_controller.dart';
import '../../db/words.dart';

class RightDrawer extends StatelessWidget {
  RightDrawer({super.key});
  final WordContent wordContent = WordContent();
  final controller = Get.put(OdowController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView.separated(
        padding: const EdgeInsets.all(0),
        itemCount: wordContent.wordEnglish.length + 1,
        itemBuilder: (context, i) {
          if (i == 0) {
            return DrawerHeader(
              decoration: gradientBoxDecoration(),
              child: const Text(
                'Kelime Listesi',
                style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 36),
              ),
            );
          } else {
            return controller.isShownStateList[i - 1]
                ? buildWords(i, context)
                :  ListTile(
                    title: Text("$i. Kelime ilerleyen günlerde erişiminize açılacaktır."),
                    onTap: null,
                    enabled: false,
                  );
          }
        },
        separatorBuilder: (context, index) {
          if (index == 0) {
            return Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                child: Text(
                  'Tüm Kelimelere Hızlı Erişim',
                  style: Theme.of(context).textTheme.headline6,
                ));
          } else {
            return const Divider();
          }
        },
      ),
    );
  }

  ListTile buildWords(int i, BuildContext context) {
    return ListTile(
      trailing: const Icon(Icons.forward),
      title: Text('$i${'. ${wordContent.wordEnglish[i - 1]} - '}${wordContent.wordTurkish[i - 1]}'),
      onTap: () {
        controller.counter.value = (i - 1);
        Navigator.pop(context);
      },
    );
  }
}
