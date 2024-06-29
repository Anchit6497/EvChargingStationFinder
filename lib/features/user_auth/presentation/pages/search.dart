import 'package:flutter/material.dart';
import '../../../../baato_service.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Baato Api try',
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
  String _searchResult = '';
  final BaatoService _baatoService = BaatoService();

  void _search() async {
    try {
      final result = await _baatoService.search(_queryController.text);
      setState(() {
        _searchResult = result.toString();
      });
    } catch (error) {
      setState(() {
        _searchResult = 'Error: $error'; 
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
            Text('Search Result:'),
            SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                child: Text(_searchResult),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
