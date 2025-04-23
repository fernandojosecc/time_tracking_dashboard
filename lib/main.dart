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
    final isMobile = MediaQuery.of(context).size.width < 800;

    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(16),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: dummyData.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isMobile ? 1 : 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.4,
      ),
      itemBuilder: (context, index) {
        final data = dummyData[index];
        final tf = data['timeframes'][selectedTimeframe];
        return ActivityCard(
          key: ValueKey('${data['title']}_$selectedTimeframe'),
          title: data['title'],
          current: tf['current'],
          previous: tf['previous'],
          timeframe: selectedTimeframe,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                        activityCardsGrid(),
                      ],
                    )
                    : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        JeremyCard(
                          selectedTimeframe: selectedTimeframe,
                          onSelect:
                              (tf) => setState(() => selectedTimeframe = tf),
                        ),
                        const SizedBox(width: 20),
                        Expanded(child: activityCardsGrid()),
                      ],
                    ),
          ),
        ),
      ),
    );
  }
}
