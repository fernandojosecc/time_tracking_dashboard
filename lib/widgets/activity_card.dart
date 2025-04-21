import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActivityCard extends StatefulWidget {
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

  @override
  State<ActivityCard> createState() => _ActivityCardState();
}

class _ActivityCardState extends State<ActivityCard> {
  bool isHovered = false;

  String get periodLabel {
    switch (widget.timeframe) {
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
    switch (widget.title.toLowerCase()) {
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
    switch (widget.title.toLowerCase()) {
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
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform:
            isHovered
                ? (Matrix4.identity()..translate(0.0, -5.0))
                : Matrix4.identity(),
        child: Stack(
          children: [
            // Colored top container
            Container(
              decoration: BoxDecoration(
                color: getColor(),
                borderRadius: BorderRadius.circular(20),
              ),
            ),

            // Background Icon
            Positioned(
              right: 16,
              top: -8,
              child: SvgPicture.asset(getIconPath(), width: 80, height: 80),
            ),

            // Content container
            Positioned.fill(
              top: 50,
              child: Material(
                color: const Color(0xFF1c1f4a),
                borderRadius: BorderRadius.circular(20),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    print('Tapped on ${widget.title}');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.title,
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

                        Text(
                          '${widget.current} hrs',
                          style: const TextStyle(
                            fontSize: 28,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${periodLabel} - ${widget.previous} hrs',
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
      ),
    );
  }
}
