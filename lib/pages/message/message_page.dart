// ignore_for_file: non_constant_identifier_names, constant_identifier_names

library message_page;

import 'package:commuication/main.dart';
import 'package:commuication/models/conf/message_args.dart';
import 'package:commuication/models/extn/date_time_extention.dart';
import 'package:commuication/models/message.dart';
import 'package:commuication/models/screen_type.dart';
import 'package:commuication/providers/chat/chat_screen_provider.dart';
import 'package:commuication/providers/chat/message_screen_provider.dart';
import 'package:commuication/static/app_colors.dart';
import 'package:commuication/static/fonts.dart';
import 'package:commuication/static/text_theme.dart';
import 'package:commuication/widgets/send_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

part './_message.dart';

class MessagePage extends StatefulWidget {
  static const String KEY = "__MessagePage__";

  const MessagePage({super.key, required this.screenType});
  final ScreenType screenType;
  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final List<Message> messages = [];
  final _messageController = TextEditingController();
  bool canSend = false;
  User currentUser = User.phone;
  final FocusNode _focusNode = FocusNode();
  late final MessageScreenArgs args;
  late final MessagePageProvider provider;
  void _addMessage() {
    messages.add(
      Message(text: _messageController.text.trim(), user: currentUser),
    );
    _togleUser();
    setState(() {});
    _messageController.clear();
  }

  void _togleUser() {
    if (currentUser == User.phone) {
      currentUser = User.laptop;
    } else {
      currentUser = User.phone;
    }
  }

  @override
  void initState() {
    super.initState();
    _messageController.addListener(() {
      canSend = _messageController.text.trim().isNotEmpty;
      setState(() {});
    });
    provider = Provider.of<MessagePageProvider>(context, listen: false);
    args = provider.args;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MessagePageProvider>(
      builder: (context, value, child) {
        final args = value.args;
        return Column(
          children: [
            AppBar(
              leading: widget.screenType != ScreenType.desktop
                  ? BackButton(
                      onPressed: () {
                        final router = Provider.of<ChatScreenProvider>(context,
                            listen: false);
                        router.back();
                      },
                    )
                  : null,
              title: Text(args.roomName),
              backgroundColor: AppColors.backgroundColor,
              elevation: 0.5,
              shadowColor: Colors.white,
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(
                  bottom: 15,
                  left: 10,
                  right: 10,
                  top: 1,
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        color: AppColors.backgroundColor,
                        child: ListView.separated(
                          padding: const EdgeInsets.only(top: 10, bottom: 20),
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                          itemBuilder: (_, index) => _MessageWidget(
                            message: messages[index],
                          ),
                          itemCount: messages.length,
                          scrollDirection: Axis.vertical,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          InkWell(
                            splashFactory: InkSparkle.splashFactory,
                            radius: 25,
                            onTap: () {
                              _togleUser();
                              setState(() {});
                            },
                            child: CircleAvatar(
                              backgroundColor: AppColors.black,
                              child: Icon(
                                currentUser == User.laptop
                                    ? Icons.laptop
                                    : Icons.phone_android_rounded,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.lightBackground,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 0),
                              child: TextFormField(
                                focusNode: _focusNode,
                                onFieldSubmitted: (value) {
                                  _sendMessage();
                                },
                                controller: _messageController,
                                cursorColor: Colors.white,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Write text",
                                  hintStyle: TextStyle(
                                    color: Colors.grey.withOpacity(0.5),
                                    fontFamily: Fonts.regular,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SendButton(
                            onPressed: _sendMessage,
                            disable: canSend,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      _addMessage();
      _focusNode.requestFocus();
    }
  }
}
