import 'package:sven_hr/Screens/Leaves/leave_request_screen.dart';
import 'package:sven_hr/Screens/Leaves/leaves_transaction_screen.dart';
import 'package:sven_hr/Screens/Vacations/vacation_request_screen.dart';
import 'package:sven_hr/localization/app_translations.dart';
import 'package:sven_hr/utilities/app_theme.dart';
import 'package:sven_hr/Screens/Home/models/category.dart';
import 'package:sven_hr/main.dart';
import 'package:flutter/material.dart';
import 'package:sven_hr/utilities/constants.dart';

class CategoryListView extends StatefulWidget {
  const CategoryListView({Key key, this.callBack}) : super(key: key);

  final Function callBack;
  @override
  _CategoryListViewState createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<CategoryListView>
    with TickerProviderStateMixin {
  AnimationController animationController;
  List<Category> categoryList;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
  }

  void setCategoryListArray() {
    categoryList = <Category>[
      Category(
        imagePath: 'assets/design_course/interFace1.png',
        index: Const.LOCALE_KEY_VACATION,
        title: AppTranslations.of(context).text(Const.LOCALE_KEY_VACATION),
        lessonCount: 24,
        money: 25,
        rating: 4.3,
        icon: Icon(
          Icons.add,
          color: AppTheme.nearlyWhite,
        ),
      ),
      Category(
        imagePath: 'assets/design_course/interFace2.png',
        index: Const.LOCALE_KEY_LEAVES,
        title: AppTranslations.of(context).text(Const.LOCALE_KEY_LEAVES),
        lessonCount: 22,
        money: 18,
        rating: 4.6,
        icon: Icon(
          Icons.add,
          color: AppTheme.nearlyWhite,
        ),
      ),
      Category(
        imagePath: 'assets/design_course/interFace1.png',
        index: Const.LOCALE_KEY_CLOCK_RECORD,
        title: AppTranslations.of(context).text(Const.LOCALE_KEY_CLOCK_RECORD),
        lessonCount: 24,
        money: 25,
        rating: 4.3,
        icon: Icon(
          Icons.alarm_add,
          color: AppTheme.nearlyWhite,
        ),
      ),
      Category(
        imagePath: 'assets/design_course/interFace2.png',
        index: Const.LOCALE_KEY_LAST_PAYSLIB,
        title: AppTranslations.of(context).text(Const.LOCALE_KEY_LAST_PAYSLIB),
        lessonCount: 22,
        money: 18,
        rating: 4.6,
        icon: Icon(
          Icons.payment,
          color: AppTheme.nearlyWhite,
        ),
      ),
    ];
  }

  Future<bool> getData() async {
    await Future.delayed(Duration.zero, () {
      setCategoryListArray();
    });
    return true;
  }

  String moveTo(Category item) {
    if (item == null) return '';

    if (item.index.compareTo(Const.LOCALE_KEY_VACATION) == 0) {
      return VacationRequestScreen.id;
    } else if (item.index.compareTo(Const.LOCALE_KEY_LEAVES) == 0) {
      return LeaveRequestScreen.id;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      child: Container(
        height: 134,
        width: double.infinity,
        child: FutureBuilder<bool>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return ListView.builder(
                padding: const EdgeInsets.only(
                    top: 0, bottom: 0, right: 16, left: 16),
                itemCount: categoryList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final int count =
                      categoryList.length > 10 ? 10 : categoryList.length;
                  final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                              parent: animationController,
                              curve: Interval((1 / count) * index, 1.0,
                                  curve: Curves.fastOutSlowIn)));
                  animationController.forward();

                  return CategoryView(
                    category: categoryList[index],
                    animation: animation,
                    animationController: animationController,
                    callback: () {
                      // widget.callBack();
                      Navigator.pushNamed(context, moveTo(categoryList[index]));
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class CategoryView extends StatelessWidget {
  const CategoryView(
      {Key key,
      this.category,
      this.animationController,
      this.animation,
      this.callback})
      : super(key: key);

  final VoidCallback callback;
  final Category category;
  final AnimationController animationController;
  final Animation<dynamic> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                100 * (1.0 - animation.value), 0.0, 0.0),
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                callback();
              },
              child: SizedBox(
                width: 280,
                child: Stack(
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          const SizedBox(
                            width: 48,
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppTheme.nearlyGrey,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(16.0)),
                              ),
                              child: Row(
                                children: <Widget>[
                                  const SizedBox(
                                    width: 48 + 24.0,
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 16),
                                            child: Text(
                                              category.title,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                letterSpacing: 0.27,
                                                color: AppTheme.darkerText,
                                              ),
                                            ),
                                          ),
                                          const Expanded(
                                            child: SizedBox(),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 16, right: 16),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: AppTheme.nearlyBlue,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(8.0)),
                                              ),
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: category.icon),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 24, bottom: 24, left: 16, right: 16),
                        child: Row(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16.0)),
                              child: AspectRatio(
                                  aspectRatio: 1.0,
                                  child: Image.asset(category.imagePath)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
