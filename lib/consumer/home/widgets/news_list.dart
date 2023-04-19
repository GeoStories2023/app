import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'news_card.dart';

class NewsList extends StatefulWidget {
  const NewsList({super.key});

  @override
  State<StatefulWidget> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  final CarouselController _controller = CarouselController();
  int _currPage = 0;
  final List<Widget> _pages = [
    const NewsCard(title: "Nils", content: "Macht zeug"),
    const NewsCard(title: "Noah", content: "Clicky bunti"),
    const NewsCard(title: "Janis", content: "REST-API"),
    const NewsCard(title: "Julius", content: "REST-API"),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var l10n = AppLocalizations.of(context);
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              "${l10n!.home_news} 📢",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () => _controller.previousPage(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeIn,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: FaIcon(FontAwesomeIcons.angleLeft),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .80,
                height: 150,
                child: CarouselSlider(
                  carouselController: _controller,
                  items: _pages,
                  options: CarouselOptions(
                    viewportFraction: 1,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currPage = index;
                      });
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () => _controller.nextPage(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeIn,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: FaIcon(FontAwesomeIcons.angleRight),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _pages.asMap().entries.map((e) {
              return GestureDetector(
                onTap: () {
                  _controller.jumpToPage(e.key);
                },
                child: Container(
                  width: 12.0,
                  height: 12.0,
                  margin: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 4.0,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black.withOpacity(
                      _currPage == e.key ? 1 : .4,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
