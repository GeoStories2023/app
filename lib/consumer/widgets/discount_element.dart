import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geostories/consumer/widgets/qr_scanner_widget.dart';

class DiscountElement extends StatelessWidget {
  // TODO: Replace with generated value
  // NOTE: will be generated via Discount class
  //  probably with store name & discount date, etc.
  final String heroTag;
  final Widget text;

  const DiscountElement({
    super.key,
    required this.text,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              alignment: Alignment.center,
              title: Row(children: [
                text,
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const FaIcon(FontAwesomeIcons.times),
                ),
              ]),
              content: SizedBox(
                width: MediaQuery.of(context).size.width * .9,
                height: MediaQuery.of(context).size.width * .9,
                child: const QrScannerWidget(),
              ),
            );
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: heroTag,
              child: FaIcon(
                FontAwesomeIcons.shoppingCart,
                size: MediaQuery.of(context).size.height * .09,
              ),
            ),
            text
          ],
        ),
      ),
    );
  }
}
