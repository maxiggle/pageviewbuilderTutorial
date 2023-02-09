import 'package:flutter/material.dart';
import 'package:pageviewbuildertutorial/bottom_nav.dart';
import 'package:pageviewbuildertutorial/promo_card.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ContentScreen(),
    );
  }
}

class ContentScreen extends StatefulWidget {
  const ContentScreen({Key? key}) : super(key: key);

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  PageController controller =
      PageController(initialPage: 0, viewportFraction: 1.1);
  int currentIndex = 0;

  List<Widget> items = [
    const SlideCard(
      cardImage: 'assets/pinky.jpg',
    ),
    const SlideCard(
      cardImage: 'assets/popsicles.jpg',
    ),
    const SlideCard(
      cardImage: 'assets/whitey.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: const BottomNavBarCurvedFb1(),
        extendBody: true,
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                height: 39,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 4),
                      color: const Color(0xff636f88).withOpacity(0.4),
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: TabBar(
                  physics: const ScrollPhysics(
                      // parent: AlwaysScrollableScrollPhysics(),
                      ),
                  controller: _tabController,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      color: Colors.grey[700]),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  tabs: const [
                    Tab(
                      text: 'All Ice-cream',
                    ),
                    Tab(
                      text: 'Favorites',
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Column(
                      children: [
                        const SizedBox(
                          height: 100,
                        ),
                        Expanded(
                          child: PageView.builder(
                            itemCount: items.length,
                            controller: controller,
                            onPageChanged: (value) {
                              setState(() {
                                currentIndex = value;
                              });
                            },
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 26),
                                child: items[index],
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        IndicatorWidget(
                          currentIndex: currentIndex,
                          length: items.length - 1,
                        ),
                        const Spacer()
                      ],
                    ),
                    const Center(child: PromoCard()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IndicatorWidget extends StatelessWidget {
  const IndicatorWidget(
      {Key? key, required this.currentIndex, required this.length})
      : super(key: key);

  final int currentIndex;
  final int length;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i <= length; i++)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            height: 8,
            width: 8,
            decoration: BoxDecoration(
                color: currentIndex == i ? Colors.blue : Colors.grey[300],
                borderRadius: BorderRadius.circular(50)),
          ),
      ],
    );
  }
}

class SlideCard extends StatelessWidget {
  const SlideCard({super.key, required this.cardImage});
  final String cardImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          // color: Colors.blue[50],
          border: Border.all(
            style: BorderStyle.solid,
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: Image(image: AssetImage(cardImage), fit: BoxFit.fitWidth)),
        ],
      ),
    );
  }
}
