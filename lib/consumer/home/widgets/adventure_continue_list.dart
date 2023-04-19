import 'package:flutter/material.dart';

import 'adventure_continue_element.dart';

class AdventureContinueList extends StatelessWidget {
  const AdventureContinueList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 4),
          child: Text(
            "Continue your story 📖",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        Divider(
          height: 20,
          color: Colors.grey[300],
        ),
        const AdventureContinueElement(
          "Story of Bremen",
          chapterName: "Stadtmusikanten",
          progress: .25,
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 2)),
        const AdventureContinueElement(
          "German Capital",
          chapterName: "Brandenburger Tor",
          progress: .8,
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 2)),
      ],
    );
  }
}
