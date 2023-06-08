import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geostories/consumer/profile/profile_bloc.dart';
import 'package:geostories/repositories/i_consumer_repo.dart';

import '../widgets/profile_header.dart';
import 'widgets/adventure_continue_list.dart';
import 'widgets/news_list.dart';

class ConsumerHome extends StatefulWidget {
  const ConsumerHome({super.key});

  @override
  State<ConsumerHome> createState() => _ConsumerHomeState();
}

class _ConsumerHomeState extends State<ConsumerHome> {
  bool _nameChangeRequired = false;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _checkNameChange(context);
    super.initState();
  }

  void _checkNameChange(BuildContext context) async {
    IConsumerRepo repo = BlocProvider.of<ProfileBloc>(context).consumerRepo;
    bool askUsername = await repo.hasToChangeName();
    setState(() {
      _nameChangeRequired = askUsername;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _nameChangeRequired ? _nameChange(context) : _homePage(context),
      ),
    );
  }

  Widget _homePage(BuildContext context) {
    var bloc = BlocProvider.of<ProfileBloc>(context);
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 10, left: 10),
            child: ProfileHeader(),
          ),
          const Padding(padding: EdgeInsets.only(top: 10)),
          const NewsList(),
          const Padding(padding: EdgeInsets.only(top: 10)),
          FutureBuilder(
            future: bloc.consumerRepo.isPremium(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data == false) {
                  return SvgPicture.asset(
                    "assets/premium_ad_banner.svg",
                    fit: BoxFit.scaleDown,
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                  );
                }
              }
              return Container();
            },
          ),
          const Padding(padding: EdgeInsets.only(top: 10)),
          const AdventureContinueList(),
        ],
      ),
    );
  }

  Widget _nameChange(BuildContext context) {
    IConsumerRepo repo = BlocProvider.of<ProfileBloc>(context).consumerRepo;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _controller,
          onSubmitted: (name) async {
            await repo.changeName(name);
            setState(() {
              _nameChangeRequired = false;
            });
          },
          decoration: const InputDecoration(hintText: "new username..."),
        ),
        Row(
          children: [
            TextButton(
              onPressed: () async {
                await repo.changeName(_controller.text);
                setState(() {
                  _nameChangeRequired = false;
                });
              },
              child: const Text("Submit"),
            ),
          ],
        )
      ],
    );
  }
}
