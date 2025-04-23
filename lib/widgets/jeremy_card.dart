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
    final double cardHeight = isMobile ? 360 : cardWidth * 1.35;

    return SizedBox(
      width: cardWidth,
      height: cardHeight,
      child: Column(
        children: [
          Flexible(
            flex: 4,
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
                    style: TextStyle(color: Colors.white70, fontSize: 20),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Jeremy Robson',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF1c1f4a),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Builder(
                builder: (context) {
                  final isMobile = MediaQuery.of(context).size.width < 800;

                  final items =
                      ['daily', 'weekly', 'monthly'].map((timeframe) {
                        final isSelected = timeframe == selectedTimeframe;
                        return GestureDetector(
                          onTap: () => onSelect(timeframe),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: isMobile ? 0 : 10,
                              horizontal: isMobile ? 12 : 30,
                            ),
                            child: Text(
                              timeframe[0].toUpperCase() +
                                  timeframe.substring(1),
                              style: TextStyle(
                                color:
                                    isSelected ? Colors.white : Colors.white60,
                                fontWeight:
                                    isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        );
                      }).toList();

                  return isMobile
                      ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: items,
                      )
                      : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: items,
                      );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
