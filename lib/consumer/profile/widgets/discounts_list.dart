import 'package:flutter/material.dart';

import '../../widgets/discount_element.dart';

class DiscountsList extends StatelessWidget {
  const DiscountsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * .9,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * .15,
          child: Wrap(
            children: const [
              DiscountElement(
                text: Text("Aldi"),
                heroTag: "aldi",
              ),
              DiscountElement(
                text: Text("Lidl"),
                heroTag: "lidl",
              ),
              DiscountElement(
                text: Text("Netto"),
                heroTag: "netto",
              ),
              DiscountElement(
                text: Text("Penny"),
                heroTag: "penny",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
