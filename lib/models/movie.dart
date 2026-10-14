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


  Movie({
    required this.id,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.ageRating,
    required this.date,
    required this.time,
    required this.price, 
  });
}
