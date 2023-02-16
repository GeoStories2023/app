import 'package:flutter/material.dart';

class ContributorCard extends StatefulWidget {
  final AssetImage image;
  final String contributorName;
  final Widget child;

  // Optional back of the card which is displayed when the card is clicked.
  final Widget? backSide;

  const ContributorCard({
    super.key,
    required this.image,
    required this.contributorName,
    required this.child,
    this.backSide,
  });

  @override
  State<StatefulWidget> createState() => _ContributorCardState();
}

class _ContributorCardState extends State<ContributorCard>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * .75,
          child: Card(
            elevation: 5.0,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          "assets/dev_group_image.jpg",
                          width: MediaQuery.of(context).size.width * .2,
                        ),
                      ),
                      Text(
                        widget.contributorName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(child: widget.child),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
