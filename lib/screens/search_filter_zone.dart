import 'package:flutter/material.dart';

class SearchFilterZone extends StatefulWidget {
  final Function(String) onSearch;
  final Function() onFilter;

  SearchFilterZone({super.key, required this.onSearch, required this.onFilter,});

  @override
  _SearchFilterZoneState createState() => _SearchFilterZoneState();
}

class _SearchFilterZoneState extends State<SearchFilterZone> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1.0),
                color: Colors.grey[800],
              ),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    onPressed: () {

                    },
                  ),
                  Expanded(
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16.0),
          InkWell(
            onTap: () {

            },
            child: const Row(
              children: <Widget>[
                Icon(
                  Icons.filter_list,
                  color: Colors.white,
                ),
                SizedBox(width: 8.0),
                Text(
                  'Filter',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String getSearchQuery() {
    return searchController.text;
  }
}
