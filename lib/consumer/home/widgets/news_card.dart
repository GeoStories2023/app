import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  final String title;
  final String content;

  const NewsCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .9,
      height: MediaQuery.of(context).size.height * .2,
      child: Card(
        color: Colors.green[100],
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 2)),
              Text(content),
            ],
          ),
        ),
      ),
    );
  }
}
