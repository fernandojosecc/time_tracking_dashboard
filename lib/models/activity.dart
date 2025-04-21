class Activity {
  final String title;
  final int current;
  final int previous;

  Activity({
    required this.title,
    required this.current,
    required this.previous,
  });

  factory Activity.fromMap(String timeframe, Map<String, dynamic> map) {
    return Activity(
      title: map['title'],
      current: map['timeframes'][timeframe]['current'],
      previous: map['timeframes'][timeframe]['previous'],
    );
  }
}
