import 'package:flutter/material.dart';

class AppNavigator extends StatefulWidget {
  const AppNavigator({
    Key key,
    @required this.navigatorKey,
    @required this.initialPages,
  }) : super(key: key);

  final GlobalKey<NavigatorState> navigatorKey;
  final List<Page<Object>> initialPages;

  static AppNavigatorState of(BuildContext context) {
    return context.findAncestorStateOfType<AppNavigatorState>();
  }

  @override
  AppNavigatorState createState() => AppNavigatorState();
}

class AppNavigatorState extends State<AppNavigator> {
  final _stack = <Page>[];

  @override
  void initState() {
    super.initState();
    assert(widget.initialPages.isNotEmpty);
    _stack.addAll(widget.initialPages);
  }

  void push(Page page) {
    setState(() => _stack.add(page));
  }

  bool pop() {
    if (_stack.isNotEmpty) {
      setState(() => _stack.removeLast());
      return true;
    }
    return false;
  }

  bool add(Page page, Page afterPage) {
    final index = _stack.indexOf(afterPage);
    if (index == -1) {
      return false;
    }
    setState(() => _stack.insert(index + 1, page));
    return true;
  }

  bool remove(Page page) {
    final index = _stack.indexOf(page);
    if (index == -1) {
      return false;
    }
    setState(() => _stack.remove(page));
    return true;
  }

  bool _onPopPage(Route<dynamic> route, dynamic result) {
    remove(route.settings as Page);
    return route.didPop(result);
  }

  @override
  Widget build(BuildContext context) {
    // print('AppNavigator: $_stack}');
    return Navigator(
      key: widget.navigatorKey,
      onPopPage: _onPopPage,
      pages: List.of(_stack),
    );
  }
}
