import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WeatherSearchDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Buscar ciudad';

  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('results');

    //para construir el resultado
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    throw UnimplementedError();
  }

  Widget _emptyContainer() {
    return Container(
      child: Center(
        child: FaIcon(FontAwesomeIcons.search, color: Colors.blue, size: 50),
      ),
    );
  }
}
