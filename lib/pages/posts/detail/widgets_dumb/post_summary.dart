import 'package:flutter/material.dart';
import 'package:fse/services/db/models/posts/supporting_models/post.dart';
import 'package:fse/shared/styles/spacings.dart';

class PostSummary_Dumb extends StatelessWidget {
  final Post post;
  final int index;

  PostSummary_Dumb({
    @required this.post,
    @required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: Spacings.m, vertical: Spacings.xxl),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background-$index.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Text(
            post?.title ?? '',
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(color: Colors.white),
          ),
        ),
        SizedBox(
          height: Spacings.m,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: Spacings.m),
          child: Text(
            post?.body ?? '',
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
      ],
    );
  }
}
