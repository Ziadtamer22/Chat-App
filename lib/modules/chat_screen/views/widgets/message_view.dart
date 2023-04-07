import 'package:chat_app/models/messages.dart';
import 'package:chat_app/modules/chat_screen/views/chat_screen.dart';
import 'package:flutter/material.dart';

class MessageView extends StatelessWidget {
  const MessageView({super.key, required this.msg});

  final Mssage msg;

  @override
  Widget build(BuildContext context) {
    bool isMe = msg.sendrName == user.name;
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!isMe)
          Container(
            height: 25,
            width: 25,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Image.network(
              msg.sendrImage ?? '',
              fit: BoxFit.cover,
            ),
          ),
        const SizedBox(width: 10),
        Material(
          elevation: 5,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadiusDirectional.only(
            topStart: const Radius.circular(15),
            topEnd: const Radius.circular(15),
            bottomStart:
                isMe ? const Radius.circular(15) : const Radius.circular(0),
            bottomEnd:
                isMe ? const Radius.circular(0) : const Radius.circular(15),
          ),
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.only(
                  topStart: const Radius.circular(15),
                  topEnd: const Radius.circular(15),
                  bottomStart: isMe
                      ? const Radius.circular(15)
                      : const Radius.circular(0),
                  bottomEnd: isMe
                      ? const Radius.circular(0)
                      : const Radius.circular(15),
                ),
                color: Colors.white,
              ),
              child: Text(
                msg.text ?? '',
                style: const TextStyle(
                  fontSize: 16,
                ),
              )),
        ),
        const SizedBox(width: 10),
        if (isMe)
          Container(
            height: 25,
            width: 25,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Image.network(
              msg.sendrImage ?? '',
              fit: BoxFit.cover,
            ),
          ),
      ],
    );
  }
}
