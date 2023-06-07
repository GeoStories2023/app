import 'package:flutter/material.dart';

import '../../widgets/discount_element.dart';

class DiscountsList extends StatelessWidget {
  const DiscountsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _header(context),
        const Divider(),
        _discounts(context),
      ],
    );
  }

  Widget _discounts(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * .9,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * .15,
          child: const Wrap(
            children: [
              DiscountElement(
                text: Text("Café Thiering"),
                heroTag: "cafe",
              ),
              DiscountElement(
                text: Text("Blumen Ewert"),
                heroTag: "blumen",
              ),
              DiscountElement(
                text: Text("Ebbelwoi Sterz"),
                heroTag: "ebbelwoi",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 5),
          child: Text(
            "Your Discounts",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
      ],
    );
  }
}
