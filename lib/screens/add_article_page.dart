import 'package:articles_app/controllers/article_controller.dart';
import 'package:flutter/material.dart';

class AddArticleScreen extends StatelessWidget {
  const AddArticleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Articles App"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: ArticleController.titleController,
            ),
            const SizedBox(
              height: 12,
            ),
            TextFormField(
              controller: ArticleController.bodyController,
            ),
            const SizedBox(
              height: 24,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(48),
                color: Colors.purple,
              ),
              padding: const EdgeInsets.all(12),
              child: GestureDetector(
                onTap: () async {
                  bool res = await ArticleController.addArticle();
                  if (res) {
                    Navigator.pop(context, true);
                  }
                },
                child: const Text(
                  "SAVE",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
