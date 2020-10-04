import 'package:flutter/material.dart';
import 'package:fse/services/db/models/posts/supporting_models/comment.dart';
import 'package:fse/shared/string_conversions.dart';

class Comments_Dumb extends StatelessWidget {
  final List<Comment> comments;

  Comments_Dumb({
    @required this.comments,
  });

  // Note: The Json Placeholder API returns a bunch of words for 'name'
  // We are going to shorten it to two words to make it more realistic.
  String _getName(Comment comment) {
    return StringConversions.capitalizeEachWord(
        comment?.name?.split(' ')?.take(2)?.join(' ') ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.only(left: 16),
            child: Text(
              'Comments',
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ),
          SizedBox(height: 8),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image:
                      AssetImage('assets/images/crumpled_paper_background.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: ListView.separated(
                padding: EdgeInsets.all(16),
                itemBuilder: (BuildContext context, int index) {
                  final Comment comment = comments[index];
                  return Column(
                    key: Key('Comment_${comment.id}'),
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        comment.body,
                        style: Theme.of(context).textTheme.caption,
                      ),
                      SizedBox(height: 2),
                      Text(
                        '- ${_getName(comment)}, ${comment.email}',
                        style: Theme.of(context).textTheme.overline,
                      ),
                    ],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 16);
                },
                itemCount: comments?.length ?? 0,
              ),
            ),
          ),
        ]);
  }
}
