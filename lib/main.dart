import 'package:flutter/material.dart';
import 'package:flutter_multitable_sqflite/database_client.dart';
import 'package:flutter_multitable_sqflite/story.dart';
import 'package:flutter_multitable_sqflite/user.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  _database() async {
    DatabaseClient db = DatabaseClient();
    await db.create();

    User admin = new User();
    admin.username = "admin";

    admin = await db.upsertUser(admin);

    Story story = Story();
    story.title = "Breaking Story!";
    story.body = "Some great content...";
    story.user_id = admin.id;

    story = await db.upsertStory(story);

    Story stories = await db.fetchStoryAndUser(story.id);
  print('stories>>>>>>'+ stories.toString());

    List<Story> latestStories = await db.fetchLatestStories(5);
    print('latestStories>>>>>'+ latestStories.toString());
    
    }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hello')),
      body: Center(child: Text('Sql database'),
      ),
      floatingActionButton: FloatingActionButton(onPressed: ()=>_database,),
    );
  
  }
}

