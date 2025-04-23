import 'package:flutter/material.dart';
import 'data/dummy_data.dart';
import 'widgets/activity_card.dart';
import 'widgets/jeremy_card.dart';

void main() {
  runApp(const TimeTrackingApp()); // Start the app
}

// This is the main app widget
class TimeTrackingApp extends StatelessWidget {
  const TimeTrackingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hide debug label
      title: 'Time Tracking Dashboard',
      theme: ThemeData(
        fontFamily: 'Rubik',
        scaffoldBackgroundColor: const Color(0xFF0f1424), // Background color
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        ), // Default text style
      ),
      home: const DashboardScreen(), // First screen to show
    );
  }
}

// This is the screen where the dashboard is displayed
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String selectedTimeframe = 'weekly'; // Default timeframe to show
  List<Map<String, dynamic>> localData = List.from(
    dummyData,
  ); // Make a copy of the activity data

  // Show a popup to edit the hours for a specific card
  void showEditDialog(int index) {
    final tf = localData[index]['timeframes'][selectedTimeframe];
    final currentController = TextEditingController(
      text: tf['current'].toString(),
    );
    final previousController = TextEditingController(
      text: tf['previous'].toString(),
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Edit ${localData[index]['title']} (${selectedTimeframe[0].toUpperCase()}${selectedTimeframe.substring(1)})',
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: currentController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Current Hours'),
              ),
              TextField(
                controller: previousController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Previous Hours'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // Close the dialog
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  // Update the hours with new values
                  localData[index]['timeframes'][selectedTimeframe]['current'] =
                      int.tryParse(currentController.text) ?? tf['current'];
                  localData[index]['timeframes'][selectedTimeframe]['previous'] =
                      int.tryParse(previousController.text) ?? tf['previous'];
                });
                Navigator.pop(context); // Close the dialog after saving
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  // This creates the grid of cards (Work, Play, etc.)
  Widget activityCardsGrid() {
    final isMobile = MediaQuery.of(context).size.width < 800;

    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(16),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: localData.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isMobile ? 1 : 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.4,
      ),
      itemBuilder: (context, index) {
        final tf = localData[index]['timeframes'][selectedTimeframe];
        return ActivityCard(
          key: ValueKey('${localData[index]['title']}_$selectedTimeframe'),
          title: localData[index]['title'],
          current: tf['current'],
          previous: tf['previous'],
          timeframe: selectedTimeframe,
          onEdit:
              () => showEditDialog(index), // Called when tapping the edit icon
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
            // Show mobile layout (stacked) or desktop layout (side-by-side)
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
