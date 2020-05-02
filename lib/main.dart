import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class User with ChangeNotifier {
  User({this.name, this.email, this.age});
  User setFirstName(String newName) {
    this.name = newName;
    notifyListeners();
    return this;
  }
  update() {
    notifyListeners();
  }
  String name;
  String email;
  int age;
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<User>(
        create: (context) => new User(age: 32, name: 'Sarah', email: 'sarah@email.com'),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: MyHomePage(title: 'Flutter Demo Home Page'),
        ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      title: Text(widget.title),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Bottom(context),
        ],
      ),
    ),
      );
  }
}

class Top extends StatelessWidget {
  final TextEditingController controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              controller: controller,
              onChanged: (newName) => user.setFirstName(newName),
            ),
            RaisedButton(
              child: Text("Submit"),
              onPressed: () { 
                user.setFirstName(controller.text); 
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Bottom extends StatelessWidget {
  Bottom(this.parent);
  final BuildContext parent;
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Text(user.name),
          FlatButton(
            child: Text("Go"),
            onPressed: () => Navigator.of(parent).push(new MaterialPageRoute(builder: (parent) => new Top())),
          ),
        ],
      ),
    );
  }
}