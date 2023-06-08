import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FriendSearch extends StatelessWidget {
  const FriendSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const FaIcon(FontAwesomeIcons.angleLeft),
              ),
            ),
            _content(context),
          ],
        ),
      ),
    );
  }

  Widget _content(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 42.0),
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter a username',
            ),
          ),
        ),
        const Divider(),
        _searchResults(context),
      ],
    );
  }

  Widget _friendAddElement(String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(content),
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add),
            label: const Text("Friend request"),
          ),
        ],
      ),
    );
  }

  Widget _searchResults(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .7,
      child: SingleChildScrollView(
        child: Column(
          children: [
            _friendAddElement("AAA"),
            _friendAddElement("AAA"),
            _friendAddElement("AAA"),
            _friendAddElement("AAA"),
            _friendAddElement("AAA"),
            _friendAddElement("AAA"),
            _friendAddElement("AAA"),
            _friendAddElement("AAA"),
            _friendAddElement("AAA"),
            _friendAddElement("AAA"),
            _friendAddElement("AAA"),
            _friendAddElement("AAA"),
            _friendAddElement("AAA"),
            _friendAddElement("AAA"),
            _friendAddElement("AAA"),
            _friendAddElement("AAA"),
            _friendAddElement("AAA"),
            _friendAddElement("AAA"),
            _friendAddElement("AAA"),
            _friendAddElement("AAA"),
            _friendAddElement("AAA"),
            _friendAddElement("AAA"),
            _friendAddElement("AAA"),
            _friendAddElement("AAA"),
            _friendAddElement("AAA"),
            _friendAddElement("AAA"),
            _friendAddElement("AAA"),
            _friendAddElement("AAA"),
            _friendAddElement("AAA"),
            _friendAddElement("AAA"),
            _friendAddElement("AAA"),
            _friendAddElement("AAA"),
            _friendAddElement("AAA"),
            _friendAddElement("AAA"),
            _friendAddElement("AAA"),
            _friendAddElement("AAA"),
            _friendAddElement("AAA"),
            _friendAddElement("AAA"),
            _friendAddElement("AAA"),
            _friendAddElement("AAA"),
            _friendAddElement("AAA"),
            _friendAddElement("AAA"),
          ],
        ),
      ),
    );
  }
}
