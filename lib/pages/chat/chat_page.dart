import 'package:carcare/providers/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'presentation/widgets/empty_state.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final promptController = TextEditingController();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat with My AI'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Consumer<ChatProvider>(
                builder: (context, chatProvider, child) {
                  if (chatProvider.messages.isEmpty) {
                    return const EmptyState(
                      imagePath: 'lib/assets/bot.png',
                      title: 'Start a Conversation',
                      description: 'Ask me anything about your car maintenance, diagnostics, or get risk analysis for potential issues.',
                    );
                  }
                  
                  return ListView.builder(
                    itemCount: chatProvider.messages.length,
                    itemBuilder: (context, index) {
                      return chatProvider.messages[index];
                    },
                  );
                },
              ),
            ),
            ChatInputField(promptController: promptController),
          ],
        ),
      ),
    );
  }
}


class ChatInputField extends StatelessWidget {
  final TextEditingController promptController;

  const ChatInputField({super.key, required this.promptController});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: promptController,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                filled: true,
                fillColor: theme.colorScheme.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            backgroundColor: theme.colorScheme.primary,
            radius: 25,
            child: IconButton(
              icon: const Icon(Icons.arrow_upward),
              color: theme.colorScheme.onPrimary,
              onPressed: () {
                var input = promptController.text.trim();
                if (input.isEmpty) return;
                
                context.read<ChatProvider>().sendMessage(input);
                promptController.clear();
              },
            ),
          ),
        ],
      ),
    );
  }
}