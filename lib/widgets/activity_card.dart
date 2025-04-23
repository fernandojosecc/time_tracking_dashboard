import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// This widget shows one activity card (Work, Play, etc.)
/// It displays the current and previous hours, and lets the user edit them.
class ActivityCard extends StatelessWidget {
  final String title; // Title of the activity (e.g. "Work")
  final int current; // Current hours for the selected timeframe
  final int previous; // Previous hours (e.g. yesterday, last week, etc.)
  final String timeframe; // "daily", "weekly", or "monthly"
  final VoidCallback onEdit; // Called when the user taps the edit button

  const ActivityCard({
    super.key,
    required this.title,
    required this.current,
    required this.previous,
    required this.timeframe,
    required this.onEdit,
  });

  /// This gives the label like "Yesterday", "Last Week", etc.
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

  /// Returns the background color depending on the activity type
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

  /// Returns the icon path (SVG image) based on the activity title
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
    // Make the card responsive to screen size
    final screenWidth = MediaQuery.of(context).size.width;
    final double cardWidth =
        screenWidth < 600 ? screenWidth * 0.9 : screenWidth * 0.25;
    final double cardHeight = cardWidth * 0.85;

    return SizedBox(
      width: cardWidth,
      height: cardHeight,
      child: Stack(
        children: [
          // Background color section (e.g. blue for play)
          Container(
            decoration: BoxDecoration(
              color: getColor(),
              borderRadius: BorderRadius.circular(20),
            ),
          ),

          // Top-right background icon (like the little SVG)
          Positioned(
            right: 16,
            top: -8,
            child: SvgPicture.asset(getIconPath(), width: 80, height: 80),
          ),

          // Main content area
          Positioned.fill(
            top: 50, // Shift it down so the icon overlaps above
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
                      // Title and Edit button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(color: Colors.white70),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  size: 18,
                                  color: Colors.white38,
                                ),
                                onPressed:
                                    onEdit, // Calls the function passed from parent
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Shows current hours
                      Text(
                        '$current hrs',
                        style: const TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Shows previous hours (e.g. "Last Week - 32 hrs")
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
