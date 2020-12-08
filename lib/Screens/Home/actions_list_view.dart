import 'package:sven_hr/Screens/Leaves/leave_request_screen.dart';
import 'package:sven_hr/Screens/Login/login_controller.dart';
import 'package:sven_hr/Screens/Vacations/vacation_request_screen.dart';
import 'package:sven_hr/Screens/clock_record/clock_record_screen.dart';
import 'package:sven_hr/Screens/expense/expense_request_screen.dart';
import 'package:sven_hr/Screens/extra_work/extra_work_screen.dart';
import 'package:sven_hr/Screens/home/models/category.dart';
import 'package:sven_hr/localization/app_translations.dart';
import 'package:sven_hr/main.dart';
import 'package:flutter/material.dart';
import 'package:sven_hr/models/response/profile_screen_response.dart';
import 'package:sven_hr/utilities/app_theme.dart';
import 'package:sven_hr/utilities/constants.dart';

class ActionsListView extends StatefulWidget {
  const ActionsListView({Key key, this.callBack}) : super(key: key);

  final Function callBack;
  @override
  _ActionsListViewState createState() => _ActionsListViewState();
}

class _ActionsListViewState extends State<ActionsListView>
    with TickerProviderStateMixin {
  AnimationController animationController;
  List<Category> actionsList;
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  void setPopularCourseListArray() {
    actionsList = <Category>[
      Category(
        imagePath: 'assets/design_course/interFace3.png',
        title: AppTranslations.of(context).text(Const.LOCALE_KEY_HOLIDAYS),
        lessonCount: 12,
        money: 25,
        rating: 4.8,
      ),
      Category(
        imagePath: 'assets/design_course/interFace4.png',
        title: AppTranslations.of(context).text(Const.LOCALE_KEY_HOLIDAYS),
        lessonCount: 28,
        money: 208,
        rating: 4.9,
      ),
      Category(
        imagePath: 'assets/design_course/interFace3.png',
        title: AppTranslations.of(context).text(Const.LOCALE_KEY_HOLIDAYS),
        lessonCount: 12,
        money: 25,
        rating: 4.8,
      ),
      Category(
        imagePath: 'assets/design_course/interFace4.png',
        title: AppTranslations.of(context).text(Const.LOCALE_KEY_HOLIDAYS),
        lessonCount: 28,
        money: 208,
        rating: 4.9,
      ),
    ];
  }

  void getProfileScreens() {
    actionsList = <Category>[
      // Category(
      //   imagePath: 'assets/design_course/interFace2.png',
      //   index: Const.LOCALE_KEY_LAST_PAYSLIB,
      //   title: AppTranslations.of(context).text(Const.LOCALE_KEY_LAST_PAYSLIB),
      //   lessonCount: 22,
      //   money: 18,
      //   rating: 4.6,
      //   icon: Icon(
      //     Icons.payment,
      //     color: AppTheme.nearlyWhite,
      //   ),
      // ),
    ];
    if (LoginController.listOfProfileScreens != null) {
      for (ProfileScreenResponse screen
      in LoginController.listOfProfileScreens) {
        if (screen.screenName.compareTo(VacationRequestScreen.id) == 0) {
          Category screen = Category(
            imagePath: 'assets/design_course/vacation.png',
            index: Const.LOCALE_KEY_VACATION,
            title: AppTranslations.of(context).text(Const.LOCALE_KEY_VACATION),
          );
          actionsList.add(screen);
        }
        else if (screen.screenName.compareTo(LeaveRequestScreen.id) == 0) {
          Category screen = Category(
            imagePath: 'assets/design_course/leave.png',
            index: Const.LOCALE_KEY_LEAVES,
            title: AppTranslations.of(context).text(Const.LOCALE_KEY_LEAVES),
          );
          actionsList.add(screen);
        } else if (screen.screenName.compareTo(ClockRecordScreen.id) == 0) {
          Category screen = Category(
            imagePath: 'assets/design_course/clock_record.png',
            index: Const.LOCALE_KEY_CLOCK_RECORD,
            title:
            AppTranslations.of(context).text(Const.LOCALE_KEY_CLOCK_RECORD),
          );
          actionsList.add(screen);
        }else if (screen.screenName.compareTo(ExpenseRequestScreen.id) == 0) {
          Category screen = Category(
            imagePath: 'assets/design_course/expense.png',
            index: Const.LOCALE_KEY_EXPENSE_REQUEST,
            title:
            AppTranslations.of(context).text(Const.LOCALE_KEY_EXPENSE_REQUEST),
          );
          actionsList.add(screen);
        }else if (screen.screenName.compareTo(ExtraWorkScreen.id) == 0) {
          Category screen = Category(
            imagePath: 'assets/design_course/extra_work.png',
            index: Const.LOCALE_KEY_EXTRA_WORK_REQUEST,
            title:
            AppTranslations.of(context).text(Const.LOCALE_KEY_EXTRA_WORK_REQUEST),
          );
          actionsList.add(screen);
        }
      }
    }
  }

  Future<bool> getData() async {
    await Future.delayed(Duration.zero, () {
      getProfileScreens();
    });
    return true;
  }

  String moveTo(Category item) {
    if (item == null) return '';

    if (item.index.compareTo(Const.LOCALE_KEY_VACATION) == 0) {
      return VacationRequestScreen.id;
    } else if (item.index.compareTo(Const.LOCALE_KEY_LEAVES) == 0) {
      return LeaveRequestScreen.id;
    }else if (item.index.compareTo(Const.LOCALE_KEY_CLOCK_RECORD) == 0) {
      return ClockRecordScreen.id;
    }else if (item.index.compareTo(Const.LOCALE_KEY_EXPENSE_REQUEST) == 0) {
      return ExpenseRequestScreen.id;
    }else if (item.index.compareTo(Const.LOCALE_KEY_EXTRA_WORK_REQUEST) == 0) {
      return ExtraWorkScreen.id;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: FutureBuilder<bool>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            return GridView(
              padding: const EdgeInsets.all(8),
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              children: List<Widget>.generate(
               actionsList.length,
                (int index) {
                  final int count = actionsList.length;
                  final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: animationController,
                      curve: Interval((1 / count) * index, 1.0,
                          curve: Curves.fastOutSlowIn),
                    ),
                  );
                  animationController.forward();
                  return CategoryView(
                    callback: () {
                      Navigator.pushNamed(context, moveTo(actionsList[index]));
                    },
                    category: actionsList[index],
                    animation: animation,
                    animationController: animationController,
                  );
                },
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 32.0,
                crossAxisSpacing: 32.0,
                childAspectRatio: 0.8,
              ),
            );
          }
        },
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

  // @override
  // Widget build(BuildContext context) {
  //   return AnimatedBuilder(
  //     animation: animationController,
  //     builder: (BuildContext context, Widget child) {
  //       return FadeTransition(
  //         opacity: animation,
  //         child: Transform(
  //           transform: Matrix4.translationValues(
  //               100 * (1.0 - animation.value), 0.0, 0.0),
  //           child: InkWell(
  //             splashColor: Colors.transparent,
  //             onTap: () {
  //               callback();
  //             },
  //             child: SizedBox(
  //               width: 200,
  //               child: Stack(
  //                 children: <Widget>[
  //                   Container(
  //                     child: Row(
  //                       children: <Widget>[
  //                         const SizedBox(
  //                           width: 28,
  //                         ),
  //                         Expanded(
  //                           child: Container(
  //                             decoration: BoxDecoration(
  //                               color: AppTheme.nearlyGrey,
  //                               borderRadius: const BorderRadius.all(
  //                                   Radius.circular(16.0)),
  //                             ),
  //                             child: Row(
  //                               children: <Widget>[
  //                                 const SizedBox(
  //                                   width: 28 + 24.0,
  //                                 ),
  //                                 Expanded(
  //                                   child: Container(
  //                                     child: Column(
  //                                       children: <Widget>[
  //                                         Padding(
  //                                           padding:
  //                                           const EdgeInsets.only(top: 16),
  //                                           child: Text(
  //                                             category.title,
  //                                             textAlign: TextAlign.center,
  //                                             style: TextStyle(
  //                                               fontWeight: FontWeight.w600,
  //                                               fontSize: 16,
  //                                               letterSpacing: 0.27,
  //                                               color: AppTheme.darkerText,
  //                                             ),
  //                                           ),
  //                                         ),
  //
  //                                       ],
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                   Container(
  //                     child: Padding(
  //                       padding: const EdgeInsets.only(
  //                           top: 24, bottom: 24, left: 24, right:24),
  //                       child: Row(
  //                         children: <Widget>[
  //                           ClipRRect(
  //                             borderRadius:
  //                             const BorderRadius.all(Radius.circular(16.0)),
  //                             child: AspectRatio(
  //                                 aspectRatio: 1.0,
  //                                 child: Image.asset(category.imagePath)),
  //                           )
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation.value), 0.0),
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                callback();
              },
              child: SizedBox(
                height: 280,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppTheme.nearlyGrey,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(16.0)),
                                // border: new Border.all(
                                //     color: DesignCourseAppTheme.notWhite),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 16, left: 16, right: 16),
                                            child: Text(
                                              category.title,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                letterSpacing: 0.27,
                                                color: AppTheme
                                                    .darkerText,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8,
                                                left: 16,
                                                right: 16,
                                                bottom: 8),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: <Widget>[

                                                Container(
                                                  child: Row(


                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 48,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 48,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding:
                        const EdgeInsets.only(top: 24, right: 16, left: 16),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                            const BorderRadius.all(Radius.circular(16.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: AppTheme.grey
                                      .withOpacity(0.2),
                                  offset: const Offset(0.0, 0.0),
                                  blurRadius: 6.0),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius:
                            const BorderRadius.all(Radius.circular(16.0)),
                            child: AspectRatio(
                                aspectRatio: 1,
                                child: Image.asset(category.imagePath)),
                          ),
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
