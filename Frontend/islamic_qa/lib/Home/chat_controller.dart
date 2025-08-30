import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:speech_to_text/speech_to_text.dart' as stt;

class ChatController extends GetxController {
  final TextEditingController messageController = TextEditingController();
  List<Map<String, dynamic>> messages = [];

  final stt.SpeechToText speechToText = stt.SpeechToText();
  var isListening = false.obs;
  var recognizedText = "".obs;

  @override
  void onInit() {
    super.onInit();
    initSpeech();
  }

  Future<void> initSpeech() async {
    await speechToText.initialize();
  }

  Future<void> startListening() async {
    isListening.value = true;
    await speechToText.listen(
      onResult: (result) {
        recognizedText.value = result.recognizedWords;
        messageController.text = result.recognizedWords;
        messageController.selection = TextSelection.fromPosition(
          TextPosition(offset: messageController.text.length),
        );
      },
    );
  }

  Future<void> stopListening() async {
    isListening.value = false;
    await speechToText.stop();
  }

  Future<void> askFatwa() async {
    if (messageController.text.trim().isEmpty) return;
    // Add user message
    messages.add({"isUser": true, "text": messageController.text.trim()});
    update();
    String query = messageController.text.trim();
    messageController.clear();
    // Show temporary typing indicator
    messages.add({"isUser": false, "text": "...typing", "isTyping": true});
    update();

    try {
      String url = "${dotenv.env["BASE_URL"]}ask";
      var response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({"query": query}),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        messages.removeWhere((msg) => msg["isTyping"] == true);
        // Add AI/fatwa response
        messages.add({"isUser": false, "text": data["llmAnswer"]});

        // Update UI
        update();
      }
    } catch (e) {
      messages.removeWhere((msg) => msg["isTyping"] == true);
      messages.add({
        "isUser": false,
        "text": "Something went wrong. Please try again.",
      });
      update();
    }
  }

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }
}
