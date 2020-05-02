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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
    return ChangeNotifierProvider<User>(
        create: (context) => new User(age: 32, name: 'Sarah', email: 'sarah@email.com'),
        child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Top(),
              Bottom(),
            ],
          ),
        ),
      ),
    );
  }
}

class Top extends StatelessWidget {
  final TextEditingController controller = new TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          TextField(
            controller: controller,
            onChanged: Provider.of<User>(context).setFirstName,
          ),
          RaisedButton(
            child: Text("Submit"),
            onPressed: Provider.of<User>(context).setFirstName(controller.text).update,
          ),
        ],
      ),
    );
  }
}

class Bottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(Provider.of<User>(context).name),
    );
  }
}