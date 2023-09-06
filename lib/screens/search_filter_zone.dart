import 'package:flutter/material.dart';

class SearchFilterZone extends StatefulWidget {
  final Function(String) onSearch;
  final Function() onFilter;

  SearchFilterZone({
    required this.onSearch,
    required this.onFilter,
  });

  @override
  _SearchFilterZoneState createState() => _SearchFilterZoneState();
}

class _SearchFilterZoneState extends State<SearchFilterZone> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.grey[800], // Dark background color
              ),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.white, // White icon color
                    ),
                    onPressed: () {
                      // Implement search functionality here
                    },
                  ),
                  Expanded(
                    child: TextField(
                      style: TextStyle(color: Colors.white), // White text color
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        hintStyle: TextStyle(color: Colors.grey[400]), // Light gray hint text color
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 16.0),
          InkWell(
            onTap: () {
              // Implement filter functionality here
            },
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.filter_list,
                  color: Colors.white, // White icon color
                ),
                SizedBox(width: 8.0),
                Text(
                  'Filter',
                  style: TextStyle(color: Colors.white), // White text color
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
