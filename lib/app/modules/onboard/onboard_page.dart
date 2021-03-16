import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:slc_app/app/shared/constants/constants.dart';
import 'package:slc_app/app/shared/utils/prefs.dart';
import 'package:slc_app/app/shared/widgets/button_border/button_border_widget.dart';

import 'onboard_model.dart';
import 'widgets/dot_onboard/dot_onboard_widget.dart';
import 'widgets/item_onboard/item_onboard_widget.dart';

class OnboardPage extends StatefulWidget {
  final String title;
  const OnboardPage({Key key, this.title = "Onboard"}) : super(key: key);

  @override
  _OnboardPageState createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _onPageChanged(int index) {
    if (!mounted) return;
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) => body(context);

  bool inFinalPage() {
    if (_currentPage == sliderArrayList.length - 1) {
      return true;
    }
    return false;
  }

  body(context) {
    return Material(
      color: Theme.of(context).primaryColor,
      child: Stack(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 500),
            curve: Curves.fastLinearToSlowEaseIn,
            color: inFinalPage() ? Theme.of(context).accentColor : Colors.white,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                    ),
                    child: PageView.builder(
                      scrollDirection: Axis.horizontal,
                      controller: _pageController,
                      onPageChanged: _onPageChanged,
                      itemCount: sliderArrayList.length,
                      itemBuilder: (ctx, i) => Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 20,
                        ),
                        child: ItemOnboardWidget(i),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                  child: inFinalPage()
                      ? ButtonBorderWidget(
                          'Acessar',
                          () async {
                            Prefs.setBool('jaViu', true);
                            Modular.to.pushReplacementNamed('/home');
                          },
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            for (int i = 0; i < sliderArrayList.length; i++)
                              if (i == _currentPage)
                                DotOnboardWidget(true)
                              else
                                DotOnboardWidget(false),
                          ],
                        ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 50,
            right: 20,
            child: GestureDetector(
              onTap: () {
                Prefs.setBool('jaViu', true);
                Modular.to.pushReplacementNamed('/home');
              },
              child: Text(
                inFinalPage() ? "" : Constants.SKIP,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
