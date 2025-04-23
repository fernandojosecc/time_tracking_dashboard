import 'package:flutter/material.dart';

class JeremyCard extends StatelessWidget {
  final String selectedTimeframe;
  final Function(String) onSelect;

  const JeremyCard({
    super.key,
    required this.selectedTimeframe,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;

    final double cardWidth = isMobile ? screenWidth * 0.9 : screenWidth * 0.25;
    final double cardHeight = isMobile ? 360 : cardWidth * 2 + 16;

    return SizedBox(
      width: cardWidth,
      height: cardHeight,
      child: Column(
        children: [
          Flexible(
            flex: 3,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF5746ea),
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(
                      'assets/images/image-jeremy.png',
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Report for',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Jeremy Robson',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF1c1f4a),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                    ['daily', 'weekly', 'monthly'].map((timeframe) {
                      final isSelected = timeframe == selectedTimeframe;
                      return GestureDetector(
                        onTap: () => onSelect(timeframe),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            timeframe[0].toUpperCase() + timeframe.substring(1),
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.white60,
                              fontWeight:
                                  isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
