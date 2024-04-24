import 'package:articles_app/models/article_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ArticleController {
  static TextEditingController titleController = TextEditingController();
  static TextEditingController bodyController = TextEditingController();

  static Future<List<ArticleModel>> fetchArticles() async {
    CollectionReference articlesCollection =
        FirebaseFirestore.instance.collection("articles");
    QuerySnapshot snapshot = await articlesCollection.get();
    return snapshot.docs.map((e) => ArticleModel.fromMap(e)).toList();
    // List<ArticleModel> articles = [];
    // for (int i = 0; i < snapshot.docs.length; i++) {
    //   ArticleModel article = ArticleModel.fromMap(
    //     snapshot.docs.elementAt(i)
    //   );
    //   articles.add(article);
    // }
    //
    // return articles;
  }

  static Future<bool> addArticle() async {
    try {
      CollectionReference articlesCollection =
      FirebaseFirestore.instance.collection("articles");
      ArticleModel article = ArticleModel(
          id: "",
          title: titleController.text,
          body: bodyController.text,
      );
      DocumentReference docRef = await articlesCollection.add(article.toMap());
      String articleId = docRef.id;
      await docRef.update({
        'id': articleId,
      });
      titleController.clear();
      bodyController.clear();
      return true;
    } catch (e) {
      print("Error");
      return false;
    }
  }
}
