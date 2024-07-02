import 'package:flutter/material.dart';
import 'package:flutter_application_1/baato_service.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Baato API Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BaatoSearchPage(),
    );
  }
}

class BaatoSearchPage extends StatefulWidget {
  @override
  _BaatoSearchPageState createState() => _BaatoSearchPageState();
}

class _BaatoSearchPageState extends State<BaatoSearchPage> {
  final TextEditingController _queryController = TextEditingController();
  List<String> _searchResults = [];
  final BaatoService _baatoService = BaatoService();

  void _search() async {
    try {
      final result = await _baatoService.search(_queryController.text);
      setState(() {
        if (result is Map<String, dynamic>) {
          // Extract relevant information from the map
          if (result.containsKey('data') && result['data'] is List) {
            _searchResults = (result['data'] as List)
                .map((item) => item.toString())
                .toList();
          } else {
            _searchResults = ['No data found'];
          }
        } else if (result is List) {
          _searchResults = result.map((item) => item.toString()).toList();
        } else {
          _searchResults = ['Unexpected result type'];
        }
      });
    } catch (error) {
      setState(() {
        _searchResults = ['Error: $error'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _queryController,
              decoration: InputDecoration(
                labelText: 'Search Station',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _search,
              child: Text('Search'),
            ),
            SizedBox(height: 16),
            Text('Search Results:'),
            SizedBox(height: 8),
            Expanded(
              child: _searchResults.isEmpty
                  ? Center(child: Text('No results'))
                  : ListView.builder(
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_searchResults[index]),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

