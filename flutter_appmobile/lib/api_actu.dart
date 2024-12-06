import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<dynamic>> fetchNews(String query) async {
  final searchQuery = query.isNotEmpty ? query : 'Nantes';
  final url = 'https://newsapi.org/v2/everything?q=$searchQuery&apiKey=02baeb30753f49f683f7c326fb956b77';
  print('Fetching news from: $url'); 

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return data['articles'];
  } else {
    print('Failed to load news: ${response.statusCode} ${response.reasonPhrase}');
    throw Exception('Failed to load news');
  }
}