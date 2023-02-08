import 'package:flutter/material.dart';
import 'package:one_day_one_word_relife/db/a1.dart';

class A1Page extends StatelessWidget {
  const A1Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("A1 Seviyesi Kelimeler Listesi"),
        backgroundColor: const Color(0xffaabcca),
      ),
      body: ListView.builder(
        itemCount: A1Words().a1.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
                '${index + 1}. ${A1Words().a1[index].wordEnglish} - ${A1Words().a1[index].wordTurkish}${A1Words().a1[index].wordTurkish2 ?? ""}${A1Words().a1[index].wordTurkish3 ?? ""}'),
          );
        },
      ),
    );
  }
}
