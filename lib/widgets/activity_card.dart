import 'package:flutter/material.dart';

class ActivityCard extends StatelessWidget {
  final String title;
  final int current;
  final int previous;
  final String timeframe;

  const ActivityCard({
    super.key,
    required this.title,
    required this.current,
    required this.previous,
    required this.timeframe,
  });

  String getPeriodLabel() {
    switch (timeframe) {
      case 'daily':
        return 'Yesterday';
      case 'weekly':
        return 'Last Week';
      case 'monthly':
        return 'Last Month';
      default:
        return '';
    }
  }

  Color getColor() {
    switch (title.toLowerCase()) {
      case 'work':
        return const Color(0xFFff8b64);
      case 'play':
        return const Color(0xFF56c2e6);
      case 'study':
        return const Color(0xFFff5e7d);
      case 'exercise':
        return const Color(0xFF4acf81);
      case 'social':
        return const Color(0xFF7536d3);
      case 'self care':
        return const Color(0xFFf1c65b);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: getColor(),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 10,
            top: 10,
            child: Icon(Icons.more_horiz, color: Colors.white),
          ),
          Positioned.fill(
            top: 60,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1c1f4a),
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(color: Colors.white70)),
                  const SizedBox(height: 8),
                  Text(
                    '$current hrs',
                    style: const TextStyle(fontSize: 28, color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${getPeriodLabel()} - ${previous}hrs',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
