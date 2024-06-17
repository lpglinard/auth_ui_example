import 'package:auth_example/auth_service_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key, required this.title});
  final String title;

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  int _counter = 0;
  final Stream<QuerySnapshot<Map<String, dynamic>>> _news =
  FirebaseFirestore.instance.collection("noticias")
      .where("categorias", arrayContains: "Cotidiano")
      .orderBy("title", descending: false)
      .snapshots();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _news,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data?.docs.length ?? 0,
              itemBuilder: (context, position) {
                return ListTile(
                  title: Text(snapshot.data?.docs.elementAt(position).get("title")),
                  subtitle: Text(snapshot.data?.docs.elementAt(position).get("subtitle")),
                  trailing: TextButton(onPressed: () { 
                  }, child: Text("Saiba mais"),
                    
                  ),
                );
              }
          );
        }
        return Text("Sem notícias");
      },


      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<AuthService>(context, listen: false).signOut();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}