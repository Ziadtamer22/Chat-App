import 'package:chat_app/models/user.dart';
import 'package:chat_app/modules/chat_screen/controller/chat_controller.dart';
import 'package:chat_app/modules/chat_screen/views/widgets/message_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

final user = User(name: 'Ziad', image: myImage);

class ChatView extends GetView<ChatContoller> {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ChatContoller());
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(5),
          child: Container(
            height: 50,
            width: 50,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Image.network(
              groupIcon,
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: const Text(
          'Flutter Group Chating',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            GetBuilder<ChatContoller>(
              builder: (controller) => controller.messages == null
                  ? const Center(child: Text('loading...'))
                  : Expanded(
                      child: ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      itemCount: controller.messages!.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 25),
                      itemBuilder: (context, index) => MessageView(
                        msg: controller.messages![index],
                      ),
                    )),
            ),
            Row(
              children: [
                Expanded(
                  child: Material(
                    borderRadius: BorderRadius.circular(50),
                    clipBehavior: Clip.antiAlias,
                    elevation: 10,
                    child: TextField(
                      controller: controller.msgTextFiled,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'enter your message',
                        hintStyle: TextStyle(
                          color: Colors.grey.shade400,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Material(
                  color: const Color(0xFF150A2D),
                  borderRadius: BorderRadius.circular(50),
                  elevation: 10,
                  child: IconButton(
                    onPressed: controller.addMessage,
                    icon: const Icon(Icons.send),
                    color: Colors.white,
                    splashRadius: 20,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

const groupIcon =
    'https://bs-uploads.toptal.io/blackfish-uploads/components/seo/content/og_image_file/og_image/1096555/0408-FlutterMessangerDemo-Luke_Social-e8a0e8ddab86b503a125ebcad823c583.png';
