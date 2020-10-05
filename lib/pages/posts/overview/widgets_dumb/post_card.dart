import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fse/services/db/models/posts/supporting_models/post.dart';
import 'package:fse/shared/styles/spacings.dart';

class Post_Card_Dumb extends StatelessWidget {
  static String keyPrefix = 'Post_Card_dumb';

  final Post post;
  final int index;
  final bool isFavorite;
  final AsyncCallback onCardTapAsync;
  final AsyncCallback onFavoriteTapAsync;

  Post_Card_Dumb({
    @required this.post,
    @required this.index,
    @required this.isFavorite,
    @required this.onCardTapAsync,
    @required this.onFavoriteTapAsync,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      key: Key('$keyPrefix\_${post.id}'),
      children: <Widget>[
        GestureDetector(
          onTap: () async {
            await onCardTapAsync();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/background-$index.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: Spacings.m, vertical: Spacings.xl),
                child: Text(
                  post.title,
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: Colors.white),
                ),
              ),
              SizedBox(height: Spacings.s),
              Container(
                padding: EdgeInsets.symmetric(horizontal: Spacings.m),
                child: Text(
                  post.body,
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
              SizedBox(height: Spacings.m),
            ],
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: GestureDetector(
            onTap: () async {
              await onFavoriteTapAsync();
            },
            child: Container(
              padding: EdgeInsets.all(Spacings.s),
              decoration: BoxDecoration(
                color: Colors.white54,
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(Spacings.s)),
              ),
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
