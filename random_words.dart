import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class RandomWords extends StatefulWidget {
  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _randomWordPair = <WordPair>[];
  final _savedPairs = Set<WordPair>();
  Widget _buildList(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(30),
      itemBuilder: (context, item) {
        if (item.isOdd) return Divider();
        final index = item ~/ 2;
        if (index >= _randomWordPair.length) {
          _randomWordPair.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_randomWordPair[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    final savedAlready = _savedPairs.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: TextStyle(fontSize: 20),
      ),
      trailing: Icon(
        savedAlready ? Icons.favorite : Icons.favorite_border,
        color: savedAlready ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (savedAlready) {
            _savedPairs.remove(pair);
          } else {
            _savedPairs.add(pair);
          }
        });
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      final Iterable<ListTile> tiles = _savedPairs.map((WordPair pair) {
        return ListTile(
          title: Text(
            pair.asPascalCase,
            style: TextStyle(fontSize: 20),
          ),
        );
      });
      final List<Widget> divied =
          ListTile.divideTiles(context: context, tiles: tiles).toList();

      return Scaffold(
        appBar: AppBar(
          title: Text("Saved  Pairs"),
        ),
        body: ListView(
          children: divied,
        ),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [IconButton(onPressed: _pushSaved, icon: Icon(Icons.list))],
          title: Text(
            "Word Pairs",
            style: TextStyle(fontSize: 30),
          ),
          centerTitle: true,
        ),
        body: _buildList(context));
  }
}
