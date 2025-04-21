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
      decoration: BoxDecoration(
        color: const Color(0xFF1c1f4a),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          // Top section with Jeremy's picture
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF5746ea),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/images/image-jeremy.png'),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Report for',
                      style: TextStyle(color: Colors.white54, fontSize: 14),
                    ),
                    Text(
                      'Jeremy Robson',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Timeframe selector (Daily, Weekly, Monthly)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              children:
                  ['daily', 'weekly', 'monthly'].map((timeframe) {
                    final isSelected = timeframe == selectedTimeframe;
                    return GestureDetector(
                      onTap: () => onSelect(timeframe),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
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
        ],
      ),
    );
  }
}
