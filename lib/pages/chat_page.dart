import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatPage extends StatefulWidget {
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Widget> chats = [];
  bool first = true;
  LinkedHashMap<String, String> history = LinkedHashMap();

  final geminiModel = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: dotenv.env['API_KEY']!,
      safetySettings: [
        SafetySetting(HarmCategory.harassment, HarmBlockThreshold.high),
        SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.high),
      ]);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 17, 24, 37),
      resizeToAvoidBottomInset: true, // Ensures content adjusts when the keyboard appears
      body: Column(
        children: [
          SizedBox(height: 30),
          Expanded(
            child: Container(
              color: Color.fromARGB(255, 17, 24, 37),
              width: double.infinity,
              child: ListView(children: [...chats]),
            ),
          ),
          _typingBox(),
        ],
      ),
    );
  }

  Widget _typingBox() {
    TextEditingController chatController = TextEditingController();
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 58, 67, 82),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: chatController,
                minLines: 1,
                maxLines: 4,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                ),
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                _handleSendMessage(chatController.text);
                chatController.clear();
              },
              icon: Icon(Icons.send))
        ],
      ),
    );
  }

  static Widget chatFromMe(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: 300),
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  static Widget chatFromOps(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: 300),
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: MarkdownBody(
            data: text,
            styleSheet: MarkdownStyleSheet(
              p: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }

  void _handleSendMessage(String text) async {
    if (text.trim() != "") {
      setState(() {
        chats.add(chatFromMe(text.trim()));
      });
      final response = await _getResponse(text);
      setState(() {
        chats.add(chatFromOps(response));
      });
    }
  }

  Future<String> _getResponse(String text) async {
    final prompt =
        '''${first ? 'Kamu adalah bot konsultan finansial bernama Finny, ' : 'History pertanyaan dalam format Map {q:a} untuk konteks: $history'} Saya adalah seorang pengusaha menjalankan usaha UMKM.
      saya akan menanyakan pertanyaan dan jawab dengan singkat, dengan maksimal 3 paragraf saja, jawab dengan teks biasa: $text''';
    final response = await geminiModel.generateContent([Content.text(prompt)]);
    if (history.length == 2) {
      history.remove(history.keys.first);
    }
    history[text] = response.text!;
    first = false;
    print(response.text);
    return response.text!;
  }
}
