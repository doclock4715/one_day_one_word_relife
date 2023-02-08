import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_day_one_word_relife/components/gradient_box_decoration.dart';
import 'package:one_day_one_word_relife/pages/menuPages/favourites.dart';
import 'package:one_day_one_word_relife/pages/menuPages/unknown.dart';
import '../menuPages/known.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(padding: const EdgeInsets.all(0), children: [
        DrawerHeader(
          decoration: gradientBoxDecoration(),
          child: const Text(
            'Menü',
            style: TextStyle(
              fontSize: 34,
              color: Colors.white,
            ),
          ),
        ),
        buildMenuItem(
          context,
          icon: const Icon(Icons.check_circle_sharp, color: Colors.green),
          stringTitle: "Bilinen Kelimeler",
          onTap: () => Get.to(() => const Known()),
        ),
        buildMenuItem(
          context,
          icon: Icon(Icons.star_sharp, color: Colors.yellow[600]),
          stringTitle: "Favori Kelimeler",
          onTap: () => Get.to(() => const Favourites()),
        ),
        buildMenuItem(
          context,
          icon: const Icon(Icons.cancel_sharp, color: Colors.red),
          stringTitle: "Bilinmeyen Kelimeler",
          onTap: () => Get.to(() => const Unknown()),
        ),
        buildMenuItem(
          context,
          icon: const Icon(Icons.help_outline),
          stringTitle: "Quiz",
          onTap: () => Get.defaultDialog(title: "Plan Aşamasında", middleText: "One Day One Word"),
          /*  onTap: () => Get.to(() => const OdowPage()), */
        )
      ]),
    );
  }

  ListTile buildMenuItem(BuildContext context,
      {required Icon icon, required String stringTitle, required VoidCallback onTap}) {
    return ListTile(leading: icon, title: Text(stringTitle), onTap: onTap);
  }
}
