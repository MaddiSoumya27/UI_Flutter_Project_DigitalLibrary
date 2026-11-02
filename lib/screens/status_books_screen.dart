
//Displays books according to their reading status.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/book_provider.dart';
import '../widgets/book_card.dart';
//Displays books according to their reading status.
class StatusBooksScreen extends StatelessWidget {
  final String status;

  const StatusBooksScreen({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BookProvider>();

    // Select books according to the selected button.
    final books = _getBooks(provider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          status == 'Total' ? 'All Books' : status,
        ),
      ),

      body: books.isEmpty
          ? _buildEmptyState()
          : Padding(
              padding: const EdgeInsets.all(16),

              child: GridView.builder(
                itemCount: books.length,

                gridDelegate:
                    const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 220,
                  mainAxisExtent: 330,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                ),

                itemBuilder: (context, index) {
                  return BookCard(
                    book: books[index],
                  );
                },
              ),
            ),
    );
  }

  // ------------------------------------------------------------
  // GET BOOKS BASED ON STATUS
  // ------------------------------------------------------------

  List _getBooks(BookProvider provider) {
    switch (status) {
      case 'Total':
        return provider.getAllBooks();

      case 'Completed':
        return provider.getCompletedBooks();

      case 'Currently Reading':
        return provider.getReadingBooks();

      case 'Want to Read':
        return provider.getWantToReadBooks();

      default:
        return [];
    }
  }

  // ------------------------------------------------------------
  // EMPTY STATE
  // ------------------------------------------------------------

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.menu_book_outlined,
            size: 70,
            color: Colors.grey.shade400,
          ),

          const SizedBox(height: 16),

          Text(
            'No books found',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'There are no books in this category.',
            style: TextStyle(
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }
}