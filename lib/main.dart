import 'package:flutter/material.dart';
import 'data/dummy_data.dart';
import 'widgets/activity_card.dart';
import 'widgets/jeremy_card.dart';

void main() {
  runApp(const TimeTrackingApp());
}

class TimeTrackingApp extends StatelessWidget {
  const TimeTrackingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Time Tracking Dashboard',
      theme: ThemeData(
        fontFamily: 'Rubik',
        scaffoldBackgroundColor: const Color(0xFF0f1424),
        textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.white)),
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String selectedTimeframe = 'weekly';

  Widget activityCardsGrid() {
    return GridView.count(
      crossAxisCount: MediaQuery.of(context).size.width < 600 ? 1 : 3,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      padding: const EdgeInsets.only(top: 20),
      childAspectRatio: 1.3,
      children:
          dummyData.map((data) {
            final tf = data['timeframes'][selectedTimeframe];
            return ActivityCard(
              title: data['title'],
              current: tf['current'],
              previous: tf['previous'],
              timeframe: selectedTimeframe,
            );
          }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child:
              isMobile
                  ? Column(
                    children: [
                      JeremyCard(
                        selectedTimeframe: selectedTimeframe,
                        onSelect:
                            (tf) => setState(() => selectedTimeframe = tf),
                      ),
                      const SizedBox(height: 20),
                      Expanded(child: activityCardsGrid()),
                    ],
                  )
                  : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: JeremyCard(
                          selectedTimeframe: selectedTimeframe,
                          onSelect:
                              (tf) => setState(() => selectedTimeframe = tf),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(flex: 3, child: activityCardsGrid()),
                    ],
                  ),
        ),
      ),
    );
  }
}
