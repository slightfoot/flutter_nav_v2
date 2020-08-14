import 'package:flutter/material.dart';

class ItemScreen extends StatelessWidget {
  const ItemScreen({
    Key key,
    @required this.tag,
    @required this.id,
  }) : super(key: key);

  final String tag;
  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Hero(
          tag: tag,
          child: AppBar(
            automaticallyImplyLeading: false,
            leading: const BackButton(),
            backgroundColor: Colors.blue,
            title: Text('Item $id'),
          ),
        ),
      ),
      body: Center(
        child: Text(
          'Item $id',
          style: Theme.of(context).textTheme.headline3,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
