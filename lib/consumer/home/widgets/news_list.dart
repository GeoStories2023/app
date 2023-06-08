import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geostories/bloc/news_bloc.dart';

import '../../../bloc/models/news.dart';
import 'news_card.dart';

class NewsList extends StatefulWidget {
  const NewsList({super.key});

  @override
  State<StatefulWidget> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    var bloc = BlocProvider.of<NewsBloc>(context);
    bloc.add(NewsLoad());
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
                child: BlocBuilder<NewsBloc, NewsState>(
                  builder: (context, state) {
                    if (state is NewsLoaded) {
                      return _newsCarousell(state.news);
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
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
        ],
      ),
    );
  }

  Widget _newsCarousell(List<News> news) {
    List<Widget> newsCards =
        news.map((e) => NewsCard(title: e.title, content: e.content)).toList();
    return CarouselSlider(
      carouselController: _controller,
      items: newsCards,
      options: CarouselOptions(
        viewportFraction: 1,
        enlargeCenterPage: true,
      ),
    );
  }
}
