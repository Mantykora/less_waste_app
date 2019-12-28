import 'package:flutter/material.dart';
import 'package:less_waste_app/core/models/post.dart';

class PostListItem extends StatelessWidget {
  final Post post;
  final Function onTap;

  const PostListItem({this.post, this.onTap});

  @override
  Widget build(BuildContext context) {
    return       Row(
      children: <Widget>[
        Expanded(
          child: Card(
            // color: Color(0x805C892A),
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  print('Card tapped.');
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Container(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
                                child: Icon(Icons.fastfood),
                              ),
                              Text(
                                'Żywność',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: <Widget>[Text('by '), Text('Piotruś '), Icon(Icons.star)],
                        ),
                      )
                    ],
                  ),
                ),
              )),
        ),
      ],
    );
  }
}
