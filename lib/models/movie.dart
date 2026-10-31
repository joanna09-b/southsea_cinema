class Movie {
  final String id;
  final String title;
  final String ageRating;
  final String description;
  final String date;
  final String time;
  final double price;
  final String imagePath;

  const Movie({
    required this.id,
    required this.title,
    required this.ageRating,
    required this.description,
    required this.date,
    required this.time,
    required this.price,
    required this.imagePath,
  });

  String get formattedPrice => '£${price.toStringAsFixed(2)}';

  factory Movie.fromJson(Map<String, dynamic> json) {
    final String id = json['id'] as String;
    final String title = json['title'] as String;
    final String ageRating = json['ageRating'] as String;
    final String description = json['description'] as String;
    final String date = json['date'] as String;
    final String time = json['time'] as String;
    final num priceNumber = json['price'] as num;
    final double price = priceNumber.toDouble();
    final String imagePath = json['imagePath'] as String;

    return Movie(
      id: id,
      title: title,
      ageRating: ageRating,
      description: description,
      date: date,
      time: time,
      price: price,
      imagePath: imagePath,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{
      'id': id,
      'title': title,
      'ageRating': ageRating,
      'description': description,
      'date': date,
      'time': time,
      'price': price,
      'imagePath': imagePath,
    };
    return data;
  }
}