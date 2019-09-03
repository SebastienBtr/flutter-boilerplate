import 'package:flutter_boilerplate/translations.dart';
import 'package:flutter/material.dart';

// A simple search bar widget
class SearchBar extends StatelessWidget {
  const SearchBar({this.onChange, this.onSubmit});

  // Function to call when the value in the searchBar changes
  final ValueSetter<String> onChange;
  // Function to call when the user press enter
  final ValueSetter<String> onSubmit;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      constraints: const BoxConstraints(
        maxHeight: 37,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(40),
          ),
        ),
        child: TextField(
          onChanged: onChange,
          onSubmitted: onSubmit,
          decoration: InputDecoration(
            hintText: Translations.of(context).text('Search'),
            hintStyle: TextStyle(fontSize: 14),
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search),
          ),
        ),
      ),
    );
  }
}
