import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inherited Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<CountProvider>.value(value: CountProvider()),
        ],
        child: DefaultTabController(
          length: 3,
          child: DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                title: Text('Provider Demo'),
                centerTitle: true,
                bottom: TabBar(
                  tabs: [
                    Tab(icon: Icon(Icons.add)),
                    Tab(icon: Icon(Icons.person)),
                    Tab(icon: Icon(Icons.message)),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  MyCountPage(),
                  MyUserPage(),
                  MyEventPage(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyCountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CountProvider _state = Provider.of<CountProvider>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('ChangeNotifierProvider Example',
                style: TextStyle(fontSize: 20)),
            SizedBox(height: 50),
            Text('${_state.counterValue}',
                style: Theme.of(context).textTheme.headline4),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  color: Colors.red,
                  onPressed: () => _state._decrementCount(),
                ),
                Consumer<CountProvider>(
                  builder: (context, value, child) {
                    return IconButton(
                      icon: Icon(Icons.add),
                      color: Colors.green,
                      onPressed: () => value._incrementCount(),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MyUserPage extends StatelessWidget {}

class MyEventPage extends StatelessWidget {}

class CountProvider extends ChangeNotifier {
  int _count = 0;
  int get counterValue => _count;

  void _incrementCount() {
    _count++;
    notifyListeners();
  }

  void _decrementCount() {
    _count--;
    notifyListeners();
  }
}

class UserProvider {}

class EventProvider {}

class User {}

class UserList {}
