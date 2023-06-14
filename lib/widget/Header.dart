import 'package:flutter/material.dart';

class Header extends StatefulWidget {
  HeaderState createState() => HeaderState();
}

class HeaderState extends State<Header> {
  bool _isSearching = false;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Row(
      children: [
        Visibility(
          visible: !_isSearching,
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Container(
              height: screenSize.height * 0.05,
              width: screenSize.width * 0.105,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.grey,
              ),
            ),
          ),
        ),
        Visibility(
          visible: !_isSearching,
          child: const Spacer(),
        ),
        Visibility(
          visible: !_isSearching,
          child: const Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.notifications,
              color: Colors.black,
            ),
          ),
        ),
        Visibility(
          visible: !_isSearching,
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
              onTap: () {
                setState(() {
                  _isSearching = true;
                });
              },
              child: const Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
          ),
        ),
        Visibility(
          visible: _isSearching,
          child: const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Chercher salon...',
                contentPadding: EdgeInsets.all(10),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        Visibility(
          visible: _isSearching,
          child: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              setState(() {
                _isSearching = false;
              });
            },
          ),
        ),
      ],
    );
  }
}
