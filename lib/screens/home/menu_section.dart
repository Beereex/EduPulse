import 'package:flutter/material.dart';

class MenuSection extends StatelessWidget {
  final Map<String, dynamic> menuData;
  final List<Icon> icons;

  MenuSection({required this.menuData, required this.icons});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: Colors.transparent,
      elevation: 0.1,
      child: Column(
        children: <Widget>[
          for (var entry in menuData.entries)
            InkWell(
              onTap: () {
                final selectedItem = entry.value;
                if (selectedItem != null) {
                  if (selectedItem is Widget) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => selectedItem,
                      ),
                    );
                  }
                }
              },
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: icons[menuData.keys.toList().indexOf(entry.key)],
                    title: Text(
                      entry.key,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  /*if (entry != menuData.entries.last)
                    Divider(
                      color: Colors.grey,
                      height: 1,
                    ),*/
                ],
              ),
            ),
        ],
      ),
    );
  }
}
