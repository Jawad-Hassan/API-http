import 'package:articles_app/controllers/article_controller.dart';
import 'package:articles_app/controllers/auth_controller.dart';
import 'package:articles_app/models/article_model.dart';
import 'package:articles_app/screens/add_article_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<ArticleModel>> getArticles;

  @override
  void initState() {
    getArticles = ArticleController.fetchArticles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Articles App"),
        actions: [
          IconButton(
            onPressed: () {
              AuthController.signOut();
            },
            icon: const Icon(
              Icons.login_outlined,
              size: 40,
            ),
          )
        ],
      ),
      body: FutureBuilder<List<ArticleModel>>(
        future: getArticles,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.data == null || snapshot.hasError) {
            return const Center(
              child: Text(
                "Nai chalunga",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            );
          } else if (snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "No data found",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            );
          } else {
            List<ArticleModel> articles = snapshot.data!;
            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, i) {
                ArticleModel article = articles.elementAt(i);
                return ListTile(
                  title: Text(article.title),
                  subtitle: Text(article.body),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool res = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddArticleScreen(),
            ),
          );

          if (res) {
            setState(() {
              getArticles = ArticleController.fetchArticles();
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
