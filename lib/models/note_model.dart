class Note {
  final int? id;
  final String title;
  final String description;
  final String habits;
  final String address;
  final String date;
  bool isFavorite;

  Note(
      {required this.title,
      required this.description,
      this.id,
      required this.habits,
      required this.address,
      required this.date,
      this.isFavorite = true});

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        habits: json['habits'],
        address: json['address'],
        date: json['date'],
        isFavorite: json['isFavorite'] == 1,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'habits': habits,
        'address': address,
        'date': date,
        'isFavorite': isFavorite ? 1 : 0,
      };
}
