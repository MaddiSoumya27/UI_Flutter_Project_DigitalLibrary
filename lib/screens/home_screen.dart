
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/book_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/book_card.dart';
import '../widgets/category_card.dart';
import 'status_books_screen.dart';
import 'settings_screen.dart';
import 'add_book_screen.dart';
import '../screens/category_books_screen.dart';

//This is the main dashboard of BookNest
/// HomeScreen is the dashboard of BookNest. It combines multiple widgets such as Row, Column, Cards, GridView and ListView to display the user's reading information.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // ------------------------------------------------------------
  // OPEN STATUS SCREEN
  // ------------------------------------------------------------

  void _openStatusBooks(
    BuildContext context,
    String status,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StatusBooksScreen(
          status: status,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BookProvider>();
    final themeProvider = context.watch<ThemeProvider>();

    final books = provider.books;

    final readingBooks = provider.getReadingBooks();

    return Scaffold(
      // --------------------------------------------------------
      // BODY
      // --------------------------------------------------------

      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // --------------------------------------------------
            // HEADER
            // --------------------------------------------------

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  20,
                  20,
                  10,
                ),

                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                  children: [
                    Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [
                        Text(
                          'Hello, Soumya !',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          'Ready to continue reading?',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                color: Colors.grey,
                              ),
                        ),
                      ],
                    ),

                    // Settings button
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const SettingsScreen(),
                          ),
                        );
                      },

                      icon: Icon(
                        themeProvider.isDarkMode
                            ? Icons.dark_mode
                            : Icons.settings_outlined,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // --------------------------------------------------
            // SEARCH BAR
            // --------------------------------------------------

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),

                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/library',
                    );
                  },

                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 15,
                    ),

                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .surfaceContainerHighest,

                      borderRadius:
                          BorderRadius.circular(16),
                    ),

                    child: Row(
                      children: [
                        const Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),

                        const SizedBox(width: 12),

                        Text(
                          'Search your books...',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // --------------------------------------------------
            // STATISTICS TITLE
            // --------------------------------------------------

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  20,
                  20,
                  12,
                ),

                child: Text(
                  'Your Reading',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),

            // --------------------------------------------------
            // CLICKABLE STATISTICS
            // --------------------------------------------------

            SliverToBoxAdapter(
              child: SizedBox(
                height: 125,

                child: ListView(
                  scrollDirection: Axis.horizontal,

                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),

                  children: [
                    // TOTAL
                    _buildStatCard(
                      context,
                      icon: Icons.menu_book_rounded,
                      title: 'Total',
                      value: provider.totalBooks.toString(),
                      status: 'Total',
                    ),

                    // COMPLETED
                    _buildStatCard(
                      context,
                      icon: Icons.check_circle_rounded,
                      title: 'Completed',
                      value:
                          provider.completedBooks.toString(),
                      status: 'Completed',
                    ),

                    // CURRENTLY READING
                    _buildStatCard(
                      context,
                      icon: Icons.auto_stories_rounded,
                      title: 'Continue Reading',
                      value:
                          provider.currentlyReadingBooks
                              .toString(),
                      status: 'Currently Reading',
                    ),

                    // WANT TO READ
                    _buildStatCard(
                      context,
                      icon: Icons.bookmark_rounded,
                      title: 'Want to Read',
                      value:
                          provider.wantToReadBooks.toString(),
                      status: 'Want to Read',
                    ),
                  ],
                ),
              ),
            ),

            // --------------------------------------------------
            // CONTINUE READING
            // --------------------------------------------------

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  28,
                  20,
                  12,
                ),

                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                  children: [
                    Text(
                      'Continue Reading',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),

                    TextButton(
                      onPressed: () {
                        _openStatusBooks(
                          context,
                          'Currently Reading',
                        );
                      },

                      child: const Text('See All'),
                    ),
                  ],
                ),
              ),
            ),

            // --------------------------------------------------
            // READING BOOKS
            // --------------------------------------------------

            SliverToBoxAdapter(
              child: readingBooks.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(
                        child: Text(
                          'No books currently being read.',
                        ),
                      ),
                    )
                  : SizedBox(
                      height: 300,

                      child: ListView.builder(
                        scrollDirection:
                            Axis.horizontal,

                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),

                        itemCount:
                            readingBooks.length,

                        itemBuilder:
                            (context, index) {
                          return SizedBox(
                            width: 190,

                            child: Padding(
                              padding:
                                  const EdgeInsets.only(
                                right: 14,
                              ),

                              child: BookCard(
                                book:
                                    readingBooks[index],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ),

            // --------------------------------------------------
            // CATEGORIES
            // --------------------------------------------------

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  28,
                  20,
                  12,
                ),

                child: Text(
                  'Categories',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: SizedBox(
                height: 150,

                child: ListView(
                  scrollDirection: Axis.horizontal,

                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),

                  children: [
                    CategoryCard(
  title: 'Technology',
  icon: Icons.computer,
  color: Colors.blue,
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const CategoryBooksScreen(
          category: 'Technology',
        ),
      ),
    );
  },
),

                   CategoryCard(
  title: 'Self-Help',
  icon: Icons.self_improvement,
  color: Colors.green,
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const CategoryBooksScreen(
          category: 'Self-Help',
        ),
      ),
    );
  },
),

                   CategoryCard(
  title: 'Fiction',
  icon: Icons.auto_stories,
  color: Colors.purple,
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const CategoryBooksScreen(
          category: 'Fiction',
        ),
      ),
    );
  },
),

                    CategoryCard(
  title: 'Science',
  icon: Icons.science,
  color: Colors.orange,
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const CategoryBooksScreen(
          category: 'Science',
        ),
      ),
    );
  },
),
                  ],
                ),
              ),
            ),

            // --------------------------------------------------
            // YOUR LIBRARY
            // --------------------------------------------------

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  28,
                  20,
                  12,
                ),

                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                  children: [
                    Text(
                      'Your Library',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),

                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/library',
                        );
                      },

                      child: const Text('See All'),
                    ),
                  ],
                ),
              ),
            ),

            // --------------------------------------------------
            // BOOK GRID
            // --------------------------------------------------

            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                20,
                0,
                20,
                100,
              ),

              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return BookCard(
                      book: books[index],
                    );
                  },

                  childCount: books.length,
                ),

                gridDelegate:
                    const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 220,
                  mainAxisExtent: 330,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                ),
              ),
            ),
          ],
        ),
      ),

      // --------------------------------------------------------
      // ADD BOOK BUTTON
      // --------------------------------------------------------

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  const AddBookScreen(),
            ),
          );
        },

        icon: const Icon(Icons.add),

        label: const Text('Add Book'),
      ),
    );
  }

  // ============================================================
  // STAT CARD
  // ============================================================

  Widget _buildStatCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    required String status,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),

      child: InkWell(
        borderRadius: BorderRadius.circular(20),

        onTap: () {
          _openStatusBooks(
            context,
            status,
          );
        },

        child: Container(
          width: 170,

          padding: const EdgeInsets.all(16),

          decoration: BoxDecoration(
            color: Theme.of(context)
                .colorScheme
                .surface,

            borderRadius:
                BorderRadius.circular(20),

            border: Border.all(
              color: Theme.of(context)
                  .dividerColor
                  .withOpacity(0.3),
            ),

            boxShadow: [
              BoxShadow(
                blurRadius: 8,
                offset: const Offset(0, 3),
                color: Colors.black.withOpacity(0.05),
              ),
            ],
          ),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.all(8),

                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.1),

                      borderRadius:
                          BorderRadius.circular(10),
                    ),

                    child: Icon(
                      icon,
                      size: 20,
                      color: Theme.of(context)
                          .colorScheme
                          .primary,
                    ),
                  ),

                  const Spacer(),

                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 13,
                    color: Colors.grey,
                  ),
                ],
              ),

              const Spacer(),

              Text(
                value,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}