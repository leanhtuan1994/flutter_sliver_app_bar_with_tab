import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final List<String> _tabs = ["Following", "For you", "Clubs"];

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  late final TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      floatHeaderSlivers: true,
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverSafeArea(
                top: false,
                sliver: SliverAppBar(
                  title: HomeAppHeader(),
                  backgroundColor: Colors.white,
                  floating: true,
                  pinned: true,
                  automaticallyImplyLeading: false,
                  forceElevated: innerBoxIsScrolled,
                  elevation: 0,
                  bottom: _buildHomeTabBar(),
                )),
          )
        ];
      },
      body: TabBarView(
          // physics: NeverScrollableScrollPhysics(), disable swipe to another tab view
          controller: _controller,
          children: [
            SafeArea(
                top: false,
                bottom: false,
                child: Builder(
                  builder: (context) {
                    return SmartRefresher(
                      enablePullDown: true,
                      onRefresh: _onRefresh,
                      onLoading: _onLoading,
                      header: WaterDropHeader(),
                      controller: _refreshController,
                      child: CustomScrollView(
                        // key: PageStorageKey<String>('1'),
                        slivers: [
                          SliverOverlapInjector(
                              handle: NestedScrollView
                                  .sliverOverlapAbsorberHandleFor(context)),
                          SliverPadding(
                            padding: const EdgeInsets.only(top: 8.0),
                            sliver: SliverList(
                              delegate:
                                  SliverChildBuilderDelegate((context, index) {
                                return Container(
                                  height: 120,
                                  color: Color(
                                          (Random().nextDouble() * 0xFFFFFF)
                                                  .toInt() <<
                                              0)
                                      .withOpacity(1.0),
                                );
                              }, childCount: 120),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )),
            Container(color: Colors.green),
            Container(
              color: Colors.blueGrey,
            ),
          ]),
    );
  }

  TabBar _buildHomeTabBar() {
    return TabBar(
      controller: _controller,
      indicator: UnderlineTabIndicator(
          insets: const EdgeInsets.symmetric(horizontal: 42),
          borderSide: BorderSide(
              color: Colors.amber, width: 3.0, style: BorderStyle.solid)),
      indicatorPadding: const EdgeInsets.only(left: 4, right: 4),
      tabs: _tabs
          .map((e) => Tab(
                child: Text(e),
              ))
          .toList(),
      labelColor: Colors.amber,
      unselectedLabelColor: Colors.grey,
      labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    );
  }
}

class HomeAppHeader extends StatelessWidget {
  const HomeAppHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Container(
            width: 80,
            height: 40,
            color: Colors.yellow,
          ),
          Spacer(),
          RawMaterialButton(
            elevation: 0.0,
            onPressed: () {},
            fillColor: Colors.grey[200],
            constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
            child: Icon(CupertinoIcons.search, color: Colors.black, size: 18),
            shape: CircleBorder(),
          ),
          RawMaterialButton(
            elevation: 0.0,
            onPressed: () {},
            fillColor: Colors.grey[200],
            child:
                Icon(CupertinoIcons.chat_bubble, color: Colors.black, size: 18),
            shape: CircleBorder(),
            constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
          ),
        ],
      ),
    );
  }
}
