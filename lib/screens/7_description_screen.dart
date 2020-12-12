import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pencil_reviews/components/bottom_button.dart';
import 'package:pencil_reviews/providers/items_provider.dart';
import 'package:pencil_reviews/screens/8_rating_screen.dart';

class DescriptionScreen extends StatefulWidget {
  DescriptionScreen({Key key, this.item}) : super(key: key);

  final Item item;

  @override
  _DescriptionScreenState createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen> {
  var _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    final Item item = widget.item;

    final List<Widget> phrases = item.description.map((phrase) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          phrase,
          style: Theme.of(context).textTheme.bodyText1,
          textAlign: TextAlign.start,
        ),
      );
    }).toList();

    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          body: Container(
              child: SingleChildScrollView(
                  controller: _controller,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width,
                      minHeight: MediaQuery.of(context).size.height -
                          MediaQuery.of(context).padding.vertical -
                          56,
                      maxHeight: double.infinity,
                    ),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width,
                              maxHeight:
                                  3.0 / 10 * MediaQuery.of(context).size.height,
                            ),
                            child: Card(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 4),
                              child: Image.asset(
                                'images/${item.name}',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            child: Column(
                              children: phrases,
                              crossAxisAlignment: CrossAxisAlignment.start,
                            ),
                          ),
                        ]),
                  ))),
          bottomNavigationBar: BottomButton(
            text: "Avanti",
            onPressed: () {
              if (_controller.position.pixels !=
                  _controller.position.maxScrollExtent)
                _controller.animateTo(_controller.position.maxScrollExtent,
                    duration: Duration(milliseconds: 200), curve: Curves.ease);
              else
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RatingScreen(item: item)),
                );
            },
          ),
        ),
      ),
    );
  }
}
