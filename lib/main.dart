import 'package:flutter/material.dart';
import 'data/dummy_data.dart';
import 'widgets/activity_card.dart';

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
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String selectedTimeframe = 'weekly';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            ToggleButtons(
              borderRadius: BorderRadius.circular(12),
              isSelected: [
                selectedTimeframe == 'daily',
                selectedTimeframe == 'weekly',
                selectedTimeframe == 'monthly',
              ],
              onPressed: (index) {
                setState(() {
                  selectedTimeframe = ['daily', 'weekly', 'monthly'][index];
                });
              },
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text('Daily'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text('Weekly'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text('Monthly'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 1,
                padding: const EdgeInsets.all(16),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children:
                    dummyData.map((data) {
                      final timeframe = data['timeframes'][selectedTimeframe];
                      return ActivityCard(
                        title: data['title'],
                        current: timeframe['current'],
                        previous: timeframe['previous'],
                        timeframe: selectedTimeframe,
                      );
                    }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
