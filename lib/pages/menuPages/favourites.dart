import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/gradient_box_decoration.dart';
import '../../controller/odow_controller.dart';
import '../../db/words.dart';
import '../home_page.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:share_plus/share_plus.dart';

import '../odow_page.dart';

class Favourites extends StatefulWidget {
  const Favourites({super.key});

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  WordContent wordContent = WordContent();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OdowController());
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: gradientBoxDecoration(),
        ),
        title: const Text("Favori Kelimeler"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: controller.favourites.length,
        itemBuilder: (context, i) {
          return Slidable(
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    Share.share(
                        '${wordContent.wordEnglish[controller.favourites[i]]} - ${wordContent.wordTurkish[controller.favourites[i]]}');
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
                        var temp = controller.favourites;
                        temp.removeAt(i);
                        HomePage.favouriteWordsBox!.put('favourites', temp);
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
                  '${controller.favourites[i] + 1}. ${wordContent.wordEnglish[controller.favourites[i]]} - ${wordContent.wordTurkish[controller.favourites[i]]}'),
              onTap: () {
                controller.counter.value = controller.favourites[i];
                Get.to(() => const OdowPage());
              },
            ),
          );
        },
      ),
    );
  }
}
