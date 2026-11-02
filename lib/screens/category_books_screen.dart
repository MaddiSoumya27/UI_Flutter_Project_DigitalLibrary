import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/book_provider.dart';
import '../widgets/book_card.dart';
//Shows books belonging to a selected category.
class CategoryBooksScreen extends StatelessWidget {
  final String category;

  const CategoryBooksScreen({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BookProvider>();

    final books = provider.getBooksByCategory(category);

    return Scaffold(
      appBar: AppBar(
        title: Text(category),
        centerTitle: true,
      ),

      body: books.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.menu_book_outlined,
                    size: 60,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No books found in $category',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            )
          : LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount;

                if (constraints.maxWidth >= 1000) {
                  crossAxisCount = 5;
                } else if (constraints.maxWidth >= 700) {
                  crossAxisCount = 4;
                } else if (constraints.maxWidth >= 500) {
                  crossAxisCount = 3;
                } else {
                  crossAxisCount = 2;
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(16),

                  gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    childAspectRatio: 0.62,
                  ),

                  itemCount: books.length,

                  itemBuilder: (context, index) {
                    final book = books[index];

                    return BookCard(
                      book: book,
                      onTap: () {
                        // BookCard already handles opening
                        // the book details screen.
                      },
                    );
                  },
                );
              },
            ),
    );
  }
}