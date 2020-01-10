import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool clicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        child: Wrap(
          children: <Widget>[
            HiddenBottomNavigationBar(
              open: clicked,
              child: Container(
                color: Colors.blue,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.favorite),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.favorite_border),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.settings),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            buildRow()
          ],
        ),
      ),
    );
  }

  Row buildRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.account_balance_wallet),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              clicked = !clicked;
            });
          },
          icon: Icon(clicked ? Icons.expand_more : Icons.expand_less),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.save),
        ),
      ],
    );
  }
}

class HiddenBottomNavigationBar extends StatefulWidget {
  final Widget child;
  final bool open;

  HiddenBottomNavigationBar({this.open = false, this.child});

  @override
  _HiddenBottomNavigationBarState createState() =>
      _HiddenBottomNavigationBarState();
}

class _HiddenBottomNavigationBarState extends State<HiddenBottomNavigationBar>
    with SingleTickerProviderStateMixin {
  AnimationController openController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    initAnimations();
  }

  initAnimations() {
    openController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    Animation curve =
        CurvedAnimation(parent: openController, curve: Curves.easeInBack);
    animation = Tween(begin: 0.0, end: 1.0).animate(curve)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void didUpdateWidget(HiddenBottomNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.open) {
      openController.forward();
    } else {
      openController.reverse();
    }
  }

  @override
  void dispose() {
    openController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        axisAlignment: 1.0, sizeFactor: animation, child: widget.child);
  }
}
