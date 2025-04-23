import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

  String get periodLabel {
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

  String getIconPath() {
    switch (title.toLowerCase()) {
      case 'work':
        return 'assets/images/icon-work.svg';
      case 'play':
        return 'assets/images/icon-play.svg';
      case 'study':
        return 'assets/images/icon-study.svg';
      case 'exercise':
        return 'assets/images/icon-exercise.svg';
      case 'social':
        return 'assets/images/icon-social.svg';
      case 'self care':
        return 'assets/images/icon-self-care.svg';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double cardWidth =
        screenWidth < 600 ? screenWidth * 0.9 : screenWidth * 0.25;
    final double cardHeight = cardWidth * 0.85;

    return SizedBox(
      width: cardWidth,
      height: cardHeight,
      child: Stack(
        children: [
          // Background color
          Container(
            decoration: BoxDecoration(
              color: getColor(),
              borderRadius: BorderRadius.circular(20),
            ),
          ),

          // Top-right icon
          Positioned(
            right: 16,
            top: -8,
            child: SvgPicture.asset(getIconPath(), width: 80, height: 80),
          ),

          // Foreground content container
          Positioned.fill(
            top: 50,
            child: Material(
              color: const Color(0xFF1c1f4a),
              borderRadius: BorderRadius.circular(20),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  print('Tapped on $title');
                },
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top row: Title + Ellipsis
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(color: Colors.white70),
                          ),
                          SvgPicture.asset(
                            'assets/images/icon-ellipsis.svg',
                            width: 20,
                            height: 5,
                            colorFilter: const ColorFilter.mode(
                              Colors.white54,
                              BlendMode.srcIn,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Current hours
                      Text(
                        '$current hrs',
                        style: const TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Previous label
                      Text(
                        '$periodLabel - $previous hrs',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
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
