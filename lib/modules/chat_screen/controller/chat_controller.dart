import 'dart:developer';

import 'package:chat_app/models/messages.dart';
import 'package:chat_app/models/user.dart';
import 'package:chat_app/modules/chat_screen/views/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChatContoller extends GetxController {
  late TextEditingController msgTextFiled;

  List<Mssage>? messages;

  final chatCollectin = FirebaseFirestore.instance.collection('chats');

  final user = User(name: 'Ziad', image: myImage);

  @override
  void onInit() {
    super.onInit();

    msgTextFiled = TextEditingController();
    chatCollectin.orderBy('send_date').snapshots().listen((event) {
      messages = [];
      messages = event.docs.map(
        (e) {
          final msg = e.data();
          final dateInSecond =
              (msg['send_date'] as Timestamp).millisecondsSinceEpoch;
          return Mssage(
            text: msg['msg'],
            sendrName: msg['sender_name'],
            sendrImage: msg['sender_image'],
            sendDate: DateTime.fromMillisecondsSinceEpoch(dateInSecond),
          );
        },
      ).toList();

      update();
    });
  }

  getAllMessage() async {
    try {
      QuerySnapshot<Map<String, dynamic>> response =
          await chatCollectin.orderBy('send_date').get();
      List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = response.docs;

      messages = docs.map((e) {
        final msg = e.data();
        final dateInSecond =
            (msg['send_date'] as Timestamp).millisecondsSinceEpoch;
        return Mssage(
          text: msg['msg'],
          sendrName: msg['sender_name'],
          sendrImage: msg['sender_image'],
          sendDate: DateTime.fromMillisecondsSinceEpoch(dateInSecond),
        );
      }).toList();
      if (messages != null) update();
    } catch (err) {
      log(err.toString());
    }
  }

  addMessage() async {
    if (msgTextFiled.text.trim().isEmpty) return;

    await chatCollectin.add({
      'send_date': DateTime.now().toUtc(),
      'sender_image': user.image,
      'sender_name': user.name,
      'msg': msgTextFiled.text,
    });

    msgTextFiled.clear();
  }
}

final myImage =
    'https://support.hubstaff.com/wp-content/uploads/2019/08/good-pic-300x286.png';
