import 'package:flutter/material.dart';
import '../models/book.dart';
//This is the main state-management file.

//It stores the list of books and provides functions to modify and retrieve them.
//addBook(), updateProgress(), toggleFavorite(), and various getters for filtering and statistics.
class BookProvider extends ChangeNotifier {
  // ============================================================
  // BOOK LIST
  // ============================================================

  final List<Book> _books = [
    // ---------------- TECHNOLOGY ----------------

    Book(
      title: 'Clean Code',
      author: 'Robert C. Martin',
      category: 'Technology',
      totalPages: 464,
      currentPage: 464,
      description:
          'A handbook of agile software craftsmanship and clean programming practices.',
      status: 'Completed',
      isFavorite: true,
      imageUrl:
          'https://covers.openlibrary.org/b/isbn/9780132350884-L.jpg',
    ),

    Book(
      title: 'The Pragmatic Programmer',
      author: 'Andrew Hunt',
      category: 'Technology',
      totalPages: 352,
      currentPage: 150,
      description:
          'Practical advice and techniques for becoming a better software developer.',
      status: 'Currently Reading',
      isFavorite: false,
      imageUrl:
          'https://covers.openlibrary.org/b/isbn/9780135957059-L.jpg',
    ),

    Book(
      title: 'Introduction to Algorithms',
      author: 'Thomas H. Cormen',
      category: 'Technology',
      totalPages: 1312,
      currentPage: 200,
      description:
          'A comprehensive introduction to algorithms and data structures.',
      status: 'Currently Reading',
      isFavorite: true,
      imageUrl:
          'https://covers.openlibrary.org/b/isbn/9780262046305-L.jpg',
    ),

    // ---------------- SELF-HELP ----------------

    Book(
      title: 'Atomic Habits',
      author: 'James Clear',
      category: 'Self-Help',
      totalPages: 320,
      currentPage: 240,
      description:
          'A practical guide to building good habits and breaking bad ones.',
      status: 'Currently Reading',
      isFavorite: true,
      imageUrl:
          'https://covers.openlibrary.org/b/isbn/9780735211292-L.jpg',
    ),

    Book(
      title: 'Deep Work',
      author: 'Cal Newport',
      category: 'Self-Help',
      totalPages: 304,
      currentPage: 80,
      description:
          'Rules for focused success in a distracted world.',
      status: 'Currently Reading',
      isFavorite: false,
      imageUrl:
          'https://covers.openlibrary.org/b/isbn/9781455586691-L.jpg',
    ),

    Book(
      title: 'The 7 Habits of Highly Effective People',
      author: 'Stephen R. Covey',
      category: 'Self-Help',
      totalPages: 381,
      currentPage: 381,
      description:
          'A guide to personal effectiveness and developing positive habits.',
      status: 'Completed',
      isFavorite: false,
      imageUrl:
          'https://covers.openlibrary.org/b/isbn/9781982137274-L.jpg',
    ),

    // ---------------- FICTION ----------------

    Book(
      title: 'The Alchemist',
      author: 'Paulo Coelho',
      category: 'Fiction',
      totalPages: 208,
      currentPage: 0,
      description:
          'A philosophical novel about following dreams and discovering purpose.',
      status: 'Want to Read',
      isFavorite: true,
      imageUrl:
          'https://covers.openlibrary.org/b/isbn/9780062315007-L.jpg',
    ),

    Book(
      title: 'The Hobbit',
      author: 'J.R.R. Tolkien',
      category: 'Fiction',
      totalPages: 310,
      currentPage: 100,
      description:
          'A fantasy adventure following Bilbo Baggins on an unexpected journey.',
      status: 'Currently Reading',
      isFavorite: false,
      imageUrl:
          'https://covers.openlibrary.org/b/isbn/9780547928227-L.jpg',
    ),

    Book(
      title: 'Pride and Prejudice',
      author: 'Jane Austen',
      category: 'Fiction',
      totalPages: 432,
      currentPage: 432,
      description:
          'A classic novel exploring love, family and social expectations.',
      status: 'Completed',
      isFavorite: true,
      imageUrl:
          'https://covers.openlibrary.org/b/isbn/9780141439518-L.jpg',
    ),

    // ---------------- SCIENCE ----------------

    Book(
      title: 'A Brief History of Time',
      author: 'Stephen Hawking',
      category: 'Science',
      totalPages: 256,
      currentPage: 0,
      description:
          'An accessible introduction to cosmology and the nature of the universe.',
      status: 'Want to Read',
      isFavorite: false,
      imageUrl:
          'https://covers.openlibrary.org/b/isbn/9780553380163-L.jpg',
    ),

    Book(
      title: 'The Selfish Gene',
      author: 'Richard Dawkins',
      category: 'Science',
      totalPages: 360,
      currentPage: 180,
      description:
          'An exploration of evolution from the perspective of genes.',
      status: 'Currently Reading',
      isFavorite: false,
      imageUrl:
          'https://covers.openlibrary.org/b/isbn/9780198788607-L.jpg',
    ),

    Book(
      title: 'Cosmos',
      author: 'Carl Sagan',
      category: 'Science',
      totalPages: 384,
      currentPage: 384,
      description:
          'A journey through space, science, history and humanity.',
      status: 'Completed',
      isFavorite: true,
      imageUrl:
          'https://covers.openlibrary.org/b/isbn/9780345539434-L.jpg',
    ),
  ];

  // ============================================================
  // BASIC BOOK GETTERS
  // ============================================================

  /// Returns all books.
  List<Book> get books => List.unmodifiable(_books);

  /// Returns all books.
  /// Used by StatusBooksScreen.
  List<Book> getAllBooks() {
    return _books;
  }

  // ============================================================
  // SEARCH
  // ============================================================

  List<Book> searchBooks(String query) {
    if (query.trim().isEmpty) {
      return _books;
    }

    final searchQuery = query.toLowerCase().trim();

    return _books.where((book) {
      return book.title.toLowerCase().contains(searchQuery) ||
          book.author.toLowerCase().contains(searchQuery) ||
          book.category.toLowerCase().contains(searchQuery);
    }).toList();
  }

  // ============================================================
  // CATEGORY FILTERING
  // ============================================================

  List<Book> getBooksByCategory(String category) {
    return _books.where((book) {
      return book.category.toLowerCase() ==
          category.toLowerCase();
    }).toList();
  }

  // ============================================================
  // STATUS FILTERING
  // ============================================================

  List<Book> getCompletedBooks() {
    return _books.where((book) {
      return book.status == 'Completed';
    }).toList();
  }

  List<Book> getReadingBooks() {
    return _books.where((book) {
      return book.status == 'Currently Reading';
    }).toList();
  }

  List<Book> getWantToReadBooks() {
    return _books.where((book) {
      return book.status == 'Want to Read';
    }).toList();
  }

  // ============================================================
  // FAVORITES
  // ============================================================

  List<Book> get favorites {
    return _books.where((book) {
      return book.isFavorite;
    }).toList();
  }

  // ============================================================
  // STATISTICS
  // ============================================================

  int get totalBooks {
    return _books.length;
  }

  int get completedBooks {
    return _books.where((book) {
      return book.status == 'Completed';
    }).length;
  }

  int get currentlyReadingBooks {
    return _books.where((book) {
      return book.status == 'Currently Reading';
    }).length;
  }

  int get wantToReadBooks {
    return _books.where((book) {
      return book.status == 'Want to Read';
    }).length;
  }

  // IMPORTANT:
  // This must return an INTEGER because statistics_screen.dart
  // uses provider.readingBooks as a numeric value.
  int get readingBooks {
    return _books.where((book) {
      return book.status == 'Currently Reading';
    }).length;
  }

  // Total number of pages currently read across all books.
  int get totalPagesRead {
    return _books.fold(
      0,
      (sum, book) {
        return sum + book.currentPage;
      },
    );
  }

  // ============================================================
  // FAVORITE ACTION
  // ============================================================

  void toggleFavorite(Book book) {
    book.isFavorite = !book.isFavorite;

    notifyListeners();
  }

  // ============================================================
  // ADD BOOK
  // ============================================================

  void addBook(Book book) {
    _books.add(book);

    notifyListeners();
  }

  // ============================================================
  // UPDATE READING PROGRESS
  // ============================================================

  void updateProgress(Book book, int currentPage) {
    // Prevent negative values.
    if (currentPage < 0) {
      currentPage = 0;
    }

    // Prevent going beyond total pages.
    if (currentPage > book.totalPages) {
      currentPage = book.totalPages;
    }

    book.currentPage = currentPage;

    // Automatically update status.
    if (book.currentPage >= book.totalPages) {
      book.currentPage = book.totalPages;
      book.status = 'Completed';
    } else if (book.currentPage > 0) {
      book.status = 'Currently Reading';
    } else {
      book.status = 'Want to Read';
    }

    notifyListeners();
  }
}