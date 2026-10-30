class Movie {
  final String id;
  final String title;
  final String description;
  final String imagePath;
  final String ageRating;
  final String date;
  final String time;
  final double price;

  String get formattedPrice => '£${price.toStringAsFixed(2)}';

  const Movie({
    required this.id,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.ageRating,
    required this.date,
    required this.time,
    required this.price,
  });

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
