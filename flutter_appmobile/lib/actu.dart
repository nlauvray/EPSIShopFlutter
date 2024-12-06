import 'package:flutter/material.dart';
import 'api_actu.dart';

class Actu extends StatefulWidget {
  const Actu({super.key});

  @override
  _ActuState createState() => _ActuState();
}

class _ActuState extends State<Actu> {
  late Future<List<dynamic>> futureNews;
  String query = '';

  @override
  void initState() {
    super.initState();
    futureNews = fetchNews(query);
  }

  void searchNews(String keyword) {
    setState(() {
      query = keyword;
      futureNews = fetchNews(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Actu'),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Rechercher...',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icon(Icons.search),
              ),
              onSubmitted: (value) {
                searchNews(value);
              },
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: futureNews,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No news found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final article = snapshot.data![index];
                final imageUrl = article['urlToImage'] ?? 'https://via.placeholder.com/150';
                final title = article['title'] ?? 'No title';
                final description = article['description'] ?? 'No description';

                return Card(
                  margin: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(imageUrl),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(description),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}