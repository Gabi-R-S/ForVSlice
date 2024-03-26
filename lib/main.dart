import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
*/
final db = FirebaseFirestore.instance;

Future<int> getNumPosts() async {
  int num = 0;
  await db
      .collection('Teste1')
      .doc('GeneralData')
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    dynamic data = documentSnapshot.data();
    num = data["num"];
    // Get value of field date from document dashboard/totalVisitors
  });

  return num;
}

Future<void> setNumPosts(int num) async {
  await db.collection('Teste1').doc('GeneralData').update({"num": num});
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).catchError(() {
    print("error!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    exit(-1);
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({super.key});

  @override
  State<MainPage> createState() => MainPageState();
}

class SecondPage extends StatefulWidget {
  SecondPage({super.key});

  @override
  State<SecondPage> createState() => SecondPageState();
}

class MainPageState extends State<MainPage> {
  MainPageState();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PostList(),
            TextButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SecondPage()),
                  );

                  setState(() {});
                },
                child: Text("Add new post"))
          ],
        ),
      ),
    );
  }
}

class SecondPageState extends State<SecondPage> {
  SecondPageState();

  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  Future<void> MakePost() async {
    int num = await getNumPosts();
    print(num);
    num++;
    await db.collection("Teste1").doc("T$num").set({
      "title": titleController.text,
      "content": contentController.text,
      "deleted": false,
    });

    await setNumPosts(num);
    print("something should have happened");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          Container(
              width: 500,
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Title:',
                ),
              )),
          Container(
              width: 500,
              child: TextField(
                controller: contentController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Post body:',
                ),
              )),
          TextButton(
              onPressed: () async {
                await MakePost();
                Navigator.pop(context);
              },
              child: Text("Create Post")),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Back"))
        ],
      ),
    ));
  }
}

class PostList extends StatelessWidget {
  const PostList({super.key});

//this isn't ending...
  Future<List<Post>> CreatePosts() async {
    List<Post> posts = [];
    int num = await getNumPosts();
    print(num);
    var collection = db.collection('Teste1');
    for (int i = 1; i <= num; i++) {
      dynamic title = "", content = "";
      bool deleted = false;
      await collection
          .doc('T$i')
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        dynamic data = documentSnapshot.data();
        title = data['title'];
        deleted = data['deleted'];
        content = data['content'];
      });

      if (!deleted) {
        posts.add(Post(title, content));
      }
    }
    return posts;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Post>>(
      future: CreatePosts(),
      builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Text('Loading....');
          default:
            if (snapshot.hasError)
              return Text('Error: ${snapshot.error}');
            else
              return Container(
                  height: 500, //removing this will crash the app
                  width: 500,
                  child: ListView(
                    children: snapshot.data ?? [],
                  ));
        }
      },
    );
  }
}

class Post extends StatelessWidget {
  const Post(this._title, this._content, {super.key});

  final String _title;
  final String _content;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      width: 600,
      child: Column(
        children: [
          Container(
            color: Colors.orange,
            child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(_title,
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                )),
          ),
          Align(
            heightFactor: 1.5,
            child: Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(_content,
                    style: TextStyle(color: Colors.deepOrangeAccent))),
            alignment: Alignment.topLeft,
          ),
        ],
      ),
    );
  }
}
