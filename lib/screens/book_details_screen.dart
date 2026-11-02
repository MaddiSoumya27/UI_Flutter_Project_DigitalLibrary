import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/book.dart';
import '../providers/book_provider.dart';
//Shows detailed information about one book.
class BookDetailsScreen extends StatelessWidget {
  final Book book;

  const BookDetailsScreen({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BookProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Details'),
        actions: [
          IconButton(
            onPressed: () {
              provider.toggleFavorite(book);
            },
            icon: Icon(
              book.isFavorite
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
              color: book.isFavorite
                  ? Colors.red
                  : null,
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          20,
          10,
          20,
          30,
        ),
        child: Column(
          children: [
            // COVER
            Container(
              height: 300,
              width: 210,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 25,
                    offset: const Offset(0, 12),
                    color: Colors.black.withOpacity(0.15),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  book.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 25),

            Text(
              book.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w800,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              book.author,
              style: TextStyle(
                fontSize: 15,
                color: Theme.of(context)
                    .colorScheme
                    .onSurfaceVariant,
              ),
            ),

            const SizedBox(height: 15),

            Wrap(
              spacing: 8,
              children: [
                Chip(
                  avatar: const Icon(
                    Icons.category_outlined,
                    size: 16,
                  ),
                  label: Text(book.category),
                ),
                Chip(
                  label: Text(book.status),
                ),
              ],
            ),

            const SizedBox(height: 25),

            // PROGRESS
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Reading Progress',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '${(book.progress * 100).round()}%',
                          style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .primary,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    LinearProgressIndicator(
                      value: book.progress,
                      minHeight: 8,
                      borderRadius:
                          BorderRadius.circular(10),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      '${book.currentPage} / ${book.totalPages} pages',
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // UPDATE PROGRESS
            FilledButton.icon(
              onPressed: () {
                _showProgressDialog(context);
              },
              icon: const Icon(
                Icons.edit_rounded,
              ),
              label: const Text(
                'Update Progress',
              ),
            ),

            const SizedBox(height: 25),

            // DESCRIPTION
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'About this book',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
            ),

            const SizedBox(height: 8),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                book.description,
                style: TextStyle(
                  height: 1.5,
                  color: Theme.of(context)
                      .colorScheme
                      .onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showProgressDialog(BuildContext context) {
    final controller = TextEditingController(
      text: book.currentPage.toString(),
    );

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Update Reading Progress'),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Current page',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                final page =
                    int.tryParse(controller.text);

                if (page != null &&
                    page >= 0 &&
                    page <= book.totalPages) {
                  context
                      .read<BookProvider>()
                      .updateProgress(
                        book,
                        page,
                      );

                  Navigator.pop(dialogContext);
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}