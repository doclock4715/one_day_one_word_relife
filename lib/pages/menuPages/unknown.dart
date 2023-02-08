import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/gradient_box_decoration.dart';
import '../../controller/odow_controller.dart';
import '../../db/words.dart';
import '../home_page.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:share_plus/share_plus.dart';

import '../odow_page.dart';

class Unknown extends StatefulWidget {
  const Unknown({super.key});

  @override
  State<Unknown> createState() => _UnknownState();
}

class _UnknownState extends State<Unknown> {
  WordContent wordContent = WordContent();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OdowController());
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: gradientBoxDecoration(),
        ),
        title: const Text("Bilinmeyen Kelimeler"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: controller.unknown.length,
        itemBuilder: (context, i) {
          return Slidable(
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    Share.share(
                        '${wordContent.wordEnglish[controller.unknown[i]]} - ${wordContent.wordTurkish[controller.unknown[i]]}');
                  },
                  backgroundColor: Colors.indigo,
                  icon: Icons.share,
                  label: 'Paylaş',
                ),
              ],
            ),
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    setState(
                      () {
                        var temp = controller.unknown;
                        temp.removeAt(i);
                        HomePage.unknownWordsBox!.put('unknowns', temp);
                      },
                    );
                  },
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Sil',
                ),
              ],
            ),
            child: ListTile(
              title: Text(
                  '${controller.unknown[i] + 1}. ${wordContent.wordEnglish[controller.unknown[i]]} - ${wordContent.wordTurkish[controller.unknown[i]]}'),
              onTap: () {
                controller.counter.value = controller.unknown[i];
                Get.to(() => const OdowPage());
              },
            ),
          );
        },
      ),
    );
  }
}
