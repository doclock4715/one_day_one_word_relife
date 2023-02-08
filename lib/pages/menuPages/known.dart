import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/gradient_box_decoration.dart';
import '../../controller/odow_controller.dart';
import '../../db/words.dart';
import '../home_page.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:share_plus/share_plus.dart';

import '../odow_page.dart';

class Known extends StatefulWidget {
  const Known({super.key});

  @override
  State<Known> createState() => _KnownState();
}

class _KnownState extends State<Known> {
  WordContent wordContent = WordContent();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OdowController());
    return Scaffold(
      appBar: AppBar(
        /* bu tuşa basınca kelimelerin listelinişi karışıkl değilde küçükten nüyüğe yapsın 
        istiyorum. tuşa basmak yerine otomotikde olur ama önemli olan sort algoritmasını
        yazabilmek
        actions: [
          IconButton(onPressed:(){
            for (var i = 0; i < controller.known.length; i++) {
              int min = controller.known[0];
              

            }
            
          } , icon: Icon(Icons.abc))
        ], */
        flexibleSpace: Container(
          decoration: gradientBoxDecoration(),
        ),
        title: const Text("Bilinen Kelimeler"),
        centerTitle: true,
      ),
      body: ListView.builder(
        //listedeki kelimeler öönce 8 sonra 2 geldiyse basılırken 2 önce 8 sonra mı olsa?
        itemCount: controller.known.length,
        itemBuilder: (context, i) {
          return Slidable(
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    Share.share(
                        '${wordContent.wordEnglish[controller.known[i]]} - ${wordContent.wordTurkish[controller.known[i]]}');
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
                        var temp = controller.known;
                        temp.removeAt(i);
                        HomePage.knownWordsBox!.put('knowns', temp);
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
                  '${controller.known[i] + 1}. ${wordContent.wordEnglish[controller.known[i]]} - ${wordContent.wordTurkish[controller.known[i]]}'),
              onTap: () {
                controller.counter.value = controller.known[i];
                Get.to(() => const OdowPage());
              },
            ),
          );
        },
      ),
    );
  }
}
