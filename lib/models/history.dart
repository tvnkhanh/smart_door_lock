class History {
  final String name;
  final String imageUrl;
  final DateTime time;

  History({
    required this.name,
    required this.imageUrl,
    required this.time,
  });

  factory History.fromJson(Map<String, dynamic> json) {
    return History(
      name: json['name'],
      imageUrl: json['imageUrl'],
      time: DateTime.parse(json['time']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'time': time.toIso8601String(),
    };
  }
}
