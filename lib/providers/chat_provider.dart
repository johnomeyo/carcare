import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:carcare/pages/chat/chat_bubble.dart';
import 'package:carcare/constants.dart';

class ChatProvider extends ChangeNotifier {
  List<ChatBubble> messages = [];

  // Fetch response from OpenAI API
  Future<void> sendMessage(String prompt) async {
    const apiKey = secretApiKey;
    var url = Uri.https("api.openai.com", "/v1/chat/completions");

    // Add user message to the list
    _addMessage(ChatBubble(message: prompt, isUserMessage: true));

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $apiKey"
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": [
            {"role": "system", "content": "You are a helpful assistant."},
            {"role": "user", "content": prompt}
          ]
        }),
      );

      if (response.statusCode == 200) {
        // Parse success response
        final responseData = jsonDecode(response.body);
        final botMessage = responseData['choices'][0]['message']['content'];
        _addMessage(ChatBubble(message: botMessage, isUserMessage: false));
      } else {
        // Handle API errors
        final errorData = jsonDecode(response.body);
        _addMessage(ChatBubble(
          message: 'ERROR: ${errorData['error']['message']}',
          isUserMessage: false,
        ));
      }
    } catch (e) {
      // Handle network or parsing errors
      _addMessage(ChatBubble(
        message: 'Failed to get response: $e',
        isUserMessage: false,
      ));
    }
  }

  // Helper method to add message and notify listeners
  void _addMessage(ChatBubble message) {
    messages.add(message);
    notifyListeners();
  }
}
