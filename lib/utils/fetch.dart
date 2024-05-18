import 'dart:io';

import 'package:html/parser.dart';
import 'dart:convert';

class RedditRequester {
  RedditRequester() {
    _httpClient = HttpClient();
    _httpClient.userAgent =
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3";
  }

  final _randomURL = "https://old.reddit.com/r/random";

  late final HttpClient _httpClient;

  Future<List<String>> getRandomSubReddits() async {
    final List<String> subreddits = [];

    for (var i = 0; i < 4; i++) {
      final req = await _httpClient.headUrl(Uri.parse(_randomURL));
      req.followRedirects = false;
      final resp = await req.close();

      // get the URL of the random subreddit
      // split on https://old.reddit.com/r/ to get the subreddit name (and then split on / to get the subreddit name)
      final subreddit = resp.headers
          .value('location')!
          .split('https://old.reddit.com/r/')[1]
          .split('/')[0];

      // if the subreddit is already in the list, try again
      if (subreddits.contains(subreddit)) {
        i--;
        continue;
      }

      subreddits.add(subreddit);
      // sleep for 1 second to prevent 429 errors
      await Future.delayed(const Duration(seconds: 1));
    }

    return subreddits;
  }

  Future<String> getRandomPost(String subreddit) async {
    final url = "https://old.reddit.com/r/$subreddit/random";

    final request = await _httpClient.getUrl(Uri.parse(url));

    request.persistentConnection = false;

    final response = await request.close();

    var body = await response.transform(utf8.decoder).join();

    // convert to an html object so we can use querySelector
    final document = parse(body);

    // get the title of the post
    final title = document.querySelector('a.title.may-blank')!.text;

    return title;
  }
}
