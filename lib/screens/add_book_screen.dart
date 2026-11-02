import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/book.dart';
import '../providers/book_provider.dart';
//Allows the user to add a new book.

//This is the main file demonstrating Forms and Validation.
class AddBookScreen extends StatefulWidget {
  const AddBookScreen({super.key});

  @override
  State<AddBookScreen> createState() =>
      _AddBookScreenState();
}

class _AddBookScreenState
    extends State<AddBookScreen> {
  final formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final authorController = TextEditingController();
  final pagesController = TextEditingController();
  final imageController = TextEditingController();
  final descriptionController = TextEditingController();

  String category = 'Technology';
  String status = 'Want to Read';

  @override
  void dispose() {
    titleController.dispose();
    authorController.dispose();
    pagesController.dispose();
    imageController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add New Book',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),

      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _field(
              controller: titleController,
              label: 'Book Title',
              icon: Icons.title_rounded,
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return 'Please enter book title';
                }
                return null;
              },
            ),

            const SizedBox(height: 14),

            _field(
              controller: authorController,
              label: 'Author',
              icon: Icons.person_outline_rounded,
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return 'Please enter author name';
                }
                return null;
              },
            ),

            const SizedBox(height: 14),

            DropdownButtonFormField<String>(
              value: category,
              decoration: const InputDecoration(
                labelText: 'Category',
                prefixIcon:
                    Icon(Icons.category_outlined),
              ),
              items: const [
                'Technology',
                'Self-Help',
                'Fiction',
                'Science',
              ]
                  .map(
                    (item) => DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    category = value;
                  });
                }
              },
            ),

            const SizedBox(height: 14),

            _field(
              controller: pagesController,
              label: 'Total Pages',
              icon: Icons.numbers_rounded,
              keyboardType:
                  TextInputType.number,
              validator: (value) {
                final pages =
                    int.tryParse(value ?? '');

                if (pages == null ||
                    pages <= 0) {
                  return 'Enter valid page count';
                }

                return null;
              },
            ),

            const SizedBox(height: 14),

            DropdownButtonFormField<String>(
              value: status,
              decoration: const InputDecoration(
                labelText: 'Reading Status',
                prefixIcon:
                    Icon(Icons.bookmark_outline),
              ),
              items: const [
                'Want to Read',
                'Currently Reading',
                'Completed',
              ]
                  .map(
                    (item) => DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    status = value;
                  });
                }
              },
            ),

            const SizedBox(height: 14),

            _field(
              controller: imageController,
              label: 'Book Cover Image URL',
              icon: Icons.image_outlined,
            ),

            const SizedBox(height: 14),

            _field(
              controller: descriptionController,
              label: 'Description',
              icon: Icons.description_outlined,
              maxLines: 4,
            ),

            const SizedBox(height: 25),

            FilledButton.icon(
              onPressed: _addBook,
              icon: const Icon(Icons.add_rounded),
              label: const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 14,
                ),
                child: Text(
                  'Add Book',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: maxLines == 1
            ? Icon(icon)
            : Padding(
                padding: const EdgeInsets.only(
                  bottom: 65,
                ),
                child: Icon(icon),
              ),
      ),
    );
  }

  void _addBook() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final pages =
        int.parse(pagesController.text);

    final book = Book(
      title: titleController.text.trim(),
      author: authorController.text.trim(),
      category: category,
      totalPages: pages,
      currentPage:
          status == 'Completed' ? pages : 0,
      status: status,
      description:
          descriptionController.text.trim(),
      imageUrl: imageController.text.trim(),
    );

    context.read<BookProvider>().addBook(book);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Book added successfully 📚'),
      ),
    );

    Navigator.pop(context);
  }
}