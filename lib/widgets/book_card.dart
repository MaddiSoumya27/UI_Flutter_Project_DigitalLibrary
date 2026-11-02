import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/book.dart';
import '../providers/book_provider.dart';
import '../screens/book_details_screen.dart';
//This is a reusable custom widget for displaying a book.
class BookCard extends StatelessWidget {
  final Book book;
  final VoidCallback? onTap;

  const BookCard({
    super.key,
    required this.book,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.read<BookProvider>();

    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),

      child: InkWell(
        onTap: onTap ??
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      BookDetailsScreen(book: book),
                ),
              );
            },

        borderRadius: BorderRadius.circular(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==================================================
            // BOOK COVER
            // ==================================================

            Expanded(
              flex: 6,

              child: Stack(
                children: [
                  Positioned.fill(
                    child: book.imageUrl.isNotEmpty
                        ? Image.network(
                            book.imageUrl,
                            fit: BoxFit.contain,

                            errorBuilder:
                                (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey.shade200,
                                child: const Center(
                                  child: Icon(
                                    Icons.menu_book,
                                    size: 50,
                                    color: Colors.grey,
                                  ),
                                ),
                              );
                            },
                          )
                        : Container(
                            color: Colors.grey.shade200,
                            child: const Center(
                              child: Icon(
                                Icons.menu_book,
                                size: 50,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                  ),

                  // ==================================================
                  // FAVORITE BUTTON
                  // ==================================================

                  Positioned(
                    top: 8,
                    right: 8,

                    child: Material(
                      color: Theme.of(context)
                          .colorScheme
                          .surface
                          .withOpacity(0.9),

                      shape: const CircleBorder(),

                      child: IconButton(
                        onPressed: () {
                          provider.toggleFavorite(book);
                        },

                        icon: Icon(
                          book.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                        ),

                        color: book.isFavorite
                            ? Colors.red
                            : Colors.grey,

                        iconSize: 20,
                        padding: const EdgeInsets.all(8),
                        constraints: const BoxConstraints(),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ==================================================
            // BOOK INFORMATION
            // ==================================================

            Expanded(
              flex: 4,

              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  12,
                  8,
                  12,
                  10,
                ),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    // TITLE
                    Text(
                      book.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,

                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(height: 3),

                    // AUTHOR
                    Text(
                      book.author,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,

                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),

                    const Spacer(),

                    // PROGRESS
                    LinearProgressIndicator(
                      value: book.progress,
                      minHeight: 5,

                      borderRadius:
                          BorderRadius.circular(10),
                    ),

                    const SizedBox(height: 6),

                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,

                      children: [
                        Text(
                          '${(book.progress * 100).round()}%',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        // STATUS
                        Flexible(
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(
                              horizontal: 7,
                              vertical: 3,
                            ),

                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.10),

                              borderRadius:
                                  BorderRadius.circular(20),
                            ),

                            child: Text(
                              book.status,
                              maxLines: 1,
                              overflow:
                                  TextOverflow.ellipsis,

                              style: TextStyle(
                                fontSize: 9,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary,

                                fontWeight:
                                    FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}