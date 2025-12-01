import 'package:carcare/pages/chat/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class PromoCard extends StatelessWidget {
  const PromoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.15,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primaryContainer,
            Theme.of(context).colorScheme.secondaryContainer,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 0,
            left: -30,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context)
                    .colorScheme
                    .primary
                    .withValues(alpha: 0.1),
              ),
            ),
          ),
          Positioned(
            bottom: -40,
            right: -20,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context)
                    .colorScheme
                    .secondary
                    .withValues(alpha: 0.08),
              ),
            ),
          ),
          Positioned(
            top: 20,
            right: 100,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context)
                    .colorScheme
                    .tertiary
                    .withValues(alpha: 0.12),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 80,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context)
                    .colorScheme
                    .primary
                    .withValues(alpha: 0.15),
              ),
            ),
          ),
          Positioned(
            top: -50,
            right: 16,
            child: Image.asset(
              'lib/assets/bot.png',
              width: 100,
              height: 100,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Protect your car\nwith Car Care AI',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.surface,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Ask My AI questions about your car\nand get analysis of the risk level.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.surface,
                      ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.purple, Colors.blue, Colors.pink],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.all(2),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: FilledButton(
                  onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      duration: const Duration(milliseconds: 500),
                      reverseDuration: const Duration(milliseconds: 500),
                      type: PageTransitionType.rightToLeft,
                      alignment: Alignment.center,
                      child: const ChatPage(),
                    ));
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  child: Text(
                    "Engage My AI",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
