import 'package:http/http.dart' as http;

class HttpService {
  http.Client httpClient;

  static const String jsonPlaceholderPostsUrl =
      'https://jsonplaceholder.typicode.com/posts';

  static String jsonPlaceholderPostCommentsUrl(int postId) =>
      'https://jsonplaceholder.typicode.com/posts/$postId/comments';
}
