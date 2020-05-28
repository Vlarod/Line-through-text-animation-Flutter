import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EV',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: ListItem(),
      ),
    );
  }
}

class ListItem extends StatefulWidget {
  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> with TickerProviderStateMixin {
  bool completed = false;
  AnimationController animationController;
  Animation animation;

  @override
  void initState() {
    animationController = new AnimationController(
      duration: new Duration(milliseconds: 250),
      vsync: this,
    );

    final curve =
        new CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation = new Tween(begin: 0.0, end: 1.0).animate(curve)
      ..addListener(() {
        setState(() {});
      });

    animationController.forward(from: 0.0);

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String text = "Ujo Vlado ma ojazdeny bavorak";
    return Column(
      children: <Widget>[
        SizedBox(
          height: 200,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            Container(
                transform: new Matrix4.identity()..scale(animation.value, 1.0),
                child: !completed
                    ? IconButton(
                        icon: Icon(
                          Icons.fiber_manual_record,
                          size: 14,
                        ),
                        onPressed: _onTap,
                      )
                    : IconButton(
                        icon: Icon(
                          Icons.done_outline,
                          size: 14,
                          
                        ),
                        onPressed: null)),
            Container(
              padding: EdgeInsets.all(20),
              child: Stack(
                children: <Widget>[
                  Text(
                    text,
                    style: TextStyle(fontSize: 14),
                  ),
                  Container(
                    transform: new Matrix4.identity()
                      ..scale(animation.value, 1.0),
                    child: Text(
                      text,
                      style: TextStyle(
                        color: Colors.transparent,
                        decorationColor: Colors.black,
                        decorationStyle: TextDecorationStyle.solid,
                        decoration: completed
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        fontSize: 14,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  _onTap() {
    setState(() => completed = !completed);
    animationController.forward(from: 0.0);
  }
}
