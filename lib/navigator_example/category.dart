import 'package:flutter/material.dart';

import 'item.dart';
import 'navigator.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = CategoryPage.of(context).id;
    return Material(
      color: Colors.green,
      child: FadeTransition(
        opacity: ModalRoute.of(context).animation,
        child: Scaffold(
          backgroundColor: Colors.green.shade200,
          appBar: AppBar(
            backgroundColor: Colors.green,
            title: Text('Category $id'),
          ),
          body: GridView.builder(
            padding: EdgeInsets.all(8.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
            ),
            itemBuilder: (BuildContext context, int index) {
              final id = index + 1;
              return Hero(
                tag: 'item_$id',
                child: Card(
                  color: Colors.blue,
                  child: InkWell(
                    onTap: () {
                      AppNavigator.of(context).push(MaterialPage(
                        name: '/item/$id',
                        builder: (_) => ItemScreen(
                          tag: 'item_$id',
                          id: id,
                        ),
                      ));
                    },
                    child: Center(
                      child: Text('Item $id'),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class CategoryPage extends Page<void> {
  CategoryPage({
    @required this.source,
    @required this.id,
  });

  factory CategoryPage.fromContext(BuildContext context, {@required int id}) {
    final box = context.findRenderObject() as RenderBox;
    final overlay = Overlay.of(context).context.findRenderObject();
    return CategoryPage(
      source: box.localToGlobal(Offset.zero, ancestor: overlay) & box.size,
      id: id,
    );
  }

  final Rect source;
  final int id;

  LocalKey get key => Key('page_category_$id');

  String get name => '/category/$id';

  static CategoryPage of(BuildContext context) {
    return ModalRoute.of(context).settings as CategoryPage;
  }

  @override
  Route<void> createRoute(BuildContext context) => CategoryRoute(page: this);
}

class CategoryRoute extends PageRoute<void> {
  CategoryRoute({
    @required this.page,
  }) : super(settings: page);

  final CategoryPage page;

  @override
  Color get barrierColor => null;

  @override
  String get barrierLabel => null;

  @override
  final bool maintainState = true;

  @override
  final Duration transitionDuration = const Duration(milliseconds: 350);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    final overlayBox = Overlay.of(context).context.findRenderObject() as RenderBox;
    final rectAnimation = RectTween(
      begin: page.source,
      end: overlayBox.localToGlobal(Offset.zero) & overlayBox.size,
    ).animate(animation);
    return ClipRect(
      clipper: RevealRectClipper(rectAnimation),
      child: child,
    );
  }

  @override
  Widget buildPage(BuildContext context, _, __) => CategoryScreen();
}

class RevealRectClipper extends CustomClipper<Rect> {
  const RevealRectClipper(this.rect) : super(reclip: rect);

  final Animation<Rect> rect;

  @override
  Rect getClip(Size size) => rect.value;

  @override
  bool shouldReclip(RevealRectClipper oldClipper) => oldClipper.rect != rect;
}
