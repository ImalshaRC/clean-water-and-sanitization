import 'package:clear_water_and_sanitization/models/ArticleModel.dart';
import 'package:clear_water_and_sanitization/models/WaterDonation.dart';
import 'package:clear_water_and_sanitization/screens/Awareness/AddArticles.dart';
import 'package:clear_water_and_sanitization/screens/Awareness/UpdateArticles.dart';
import 'package:clear_water_and_sanitization/screens/DonationHandling/AddDonation.dart';
import 'package:clear_water_and_sanitization/screens/DonationHandling/UpdateDonation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ArticleList extends StatefulWidget {
  const ArticleList({Key? key}) : super(key: key);

  @override
  State<ArticleList> createState() => _UserListState();
}

class _UserListState extends State<ArticleList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Article List"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_){
                  return const AddArticle();
                }));
              },
              icon: const Icon(Icons.add),
          )
        ],
      ),
      body: StreamBuilder<List<ArticleModel>>(
        stream: readArticles(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            final articles = snapshot.data!;
            return ListView(
              padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 20),
              children: articles.map(buildArticle).toList(),
            );
          }else if(snapshot.hasError){
            if (kDebugMode) {
              print('Error --> ${snapshot.error}');
            }
            return const Center(
              child: Text("Oops Something Went Wrong..."),
            );
          }else{
            return const Center(
              child: CircularProgressIndicator(color: Colors.green),
            );
          }
        },
      ),
    );
  }

  Widget buildArticle(ArticleModel article) {

    var borderRadius = const BorderRadius.all(Radius.circular(18));
    const double ft = 19;

    return Column(
      children: [
        const SizedBox(height: 10),
        ListTile(
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          selectedTileColor: Colors.grey,
          selected: true,
          title: Column(
            children: [
              Row(
                children: [
                  const SizedBox(height: 7),
                  Text(
                      article.name,
                      style: const TextStyle(color: Colors.white, fontSize: ft)
                  ),
                  const Spacer(),
                  Text(
                      article.mobile,
                      style: const TextStyle(color: Colors.white, fontSize: ft)
                  ),
                ],
              ),
              const SizedBox(height: 23),
              Row(
                children: [
                  Text(
                    'Date: ${article.name}',
                    style: const TextStyle(color: Colors.white, fontSize: ft)
                  ),
                ],
              ),
              const SizedBox(height: 7),
              Row(
                children: [
                  ElevatedButton(
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                          return UpdateArticle(article.id);
                        }));
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        backgroundColor: Colors.green
                      ),
                      child: const Text("Update")
                  ),
                  const Spacer(),
                  ElevatedButton(
                      onPressed: (){
                        showDialog(
                          context: context,
                          builder: (context) => alertBox(article.id),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        backgroundColor: Colors.green
                      ),
                      child: const Text("Delete")
                  ),
                ],
              ),
            ],
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) {
              return UpdateArticle(article.id);
            }));
          },
        )
      ],
    );
  }

  alertBox<Widget>(String id) {
    return AlertDialog(
      title: const Text("Do you want to delete?"),
      actions: [
        ElevatedButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: const Text("No")
        ),
        ElevatedButton(
            onPressed: (){
              deleteUser(id);
              Navigator.of(context).push(MaterialPageRoute(builder: (_){
                return const ArticleList();
              }));
            },
            child: const Text("Yes")
        )
      ],
    );
  }

  Future<dynamic> deleteUser(articleId) async{
    var singleDonation = FirebaseFirestore.instance.collection('article').doc(articleId);
    try{
      await singleDonation.delete();
    }catch(err){
      if (kDebugMode) {
        print(err.toString());
      }
    }
  }

  Stream<List<ArticleModel>> readArticles() => FirebaseFirestore.instance
      .collection('article')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) =>
              ArticleModel.fromJson(doc.data()),
          ).toList(),
      );
}
