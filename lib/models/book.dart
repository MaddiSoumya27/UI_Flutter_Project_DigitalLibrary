class Book {
  String title;
  String author;
  String category;
  int totalPages;
  int currentPage;
  String description;
  bool isFavorite;
  String status;
  String imageUrl;
//Contains the Book model.
//It defines information about every book
  Book({
    required this.title,
    required this.author,
    required this.category,
    required this.totalPages,
    this.currentPage = 0,
    this.description = '',
    this.isFavorite = false,
    this.status = 'Want to Read',
    this.imageUrl = '',
  });

  double get progress {
    if (totalPages == 0) return 0;

    return (currentPage / totalPages).clamp(0.0, 1.0);
  }
}