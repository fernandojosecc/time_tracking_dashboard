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
    return Container(
      height: 400, // Match the height of other cards
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFF1c1f4a), // Outer container background
      ),
      child: Column(
        children: [
          // Top section (Jeremy info)
          Expanded(
            flex: 3,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF5746ea),
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(
                      'assets/images/image-jeremy.png',
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Report for',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  const SizedBox(height: 5),
                  const Text(
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

          // Bottom section (timeframe switcher)
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
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
