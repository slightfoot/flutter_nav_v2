import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'navigator_example/category.dart';
import 'navigator_example/navigator.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      // By giving the navigatorKey parameter as the same parameter we use in
      // our internal navigator the default pop action will pop on our Navigator.
      navigatorKey: _navigatorKey,
      // This just satisfies the asserts inside of MaterialApp. This is not
      // actually called because it is assigned to a Navigator widget we don't use.
      onGenerateRoute: (_) => null,
      // This is called with `child` as the Navigator. We can simply ignore
      // this parameter and give our own Navigator (inside AppNavigator) with the
      // same key to override the default one.
      builder: (BuildContext context, _ /*Widget child*/) {
        return AppNavigator(
          navigatorKey: _navigatorKey,
          initialPages: [
            // We must have at least one initial page or the Navigator widget
            // will try and parse the default initialRoute and call a
            // non-existent onGenerateRoute function.
            MaterialPage(
              name: '/',
              builder: (_) => HomeScreen(),
            ),
          ],
        );
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text('Home'),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
          childAspectRatio: 3.0,
        ),
        itemBuilder: (BuildContext context, int index) {
          final id = index + 1;
          return Builder(
            builder: (BuildContext context) {
              return Card(
                color: Colors.green,
                child: InkWell(
                  onTap: () {
                    AppNavigator.of(context).push(
                      CategoryPage.fromContext(context, id: id),
                    );
                  },
                  child: Center(
                    child: Text('Category $id'),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
