import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sven_hr/Screens/Vacations/models/vacation_list_item.dart';
import 'package:sven_hr/Screens/Vacations/vacation_transaction_controller.dart';
import 'package:sven_hr/Screens/screen_loader.dart';
import 'package:sven_hr/components/multi_selectionlist_vew.dart';
import 'package:sven_hr/dao/lov_value.dart';
import 'package:sven_hr/dao/vacation_type.dart';
import 'package:sven_hr/localization/app_translations.dart';
import 'package:sven_hr/main.dart';
import 'package:sven_hr/utilities/app_theme.dart';
import 'package:sven_hr/utilities/constants.dart';

class VacationsTransaction extends StatefulWidget {
  static final id = "VacationsTransaction";
  @override
  _VacationsTransactionState createState() => _VacationsTransactionState();
}

class ListItem {
  int value;
  String name;

  ListItem(this.value, this.name);
}

class _VacationsTransactionState extends State<VacationsTransaction>
    with TickerProviderStateMixin {
  AnimationController animationController;
  LovValue statusValue;
  VacationType typeValue;
  VacationTransactionController _vacationTransactionController;
  List<LovValue> statusList;
  List<VacationType> typeList;
  String fromDate;
  String toDate;
  bool showSpinner = false;
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _vacationTransactionController = VacationTransactionController();
    LoadVacationStatus();
    LoadVacationType();
    getLastMonthVacationTransaction();
    super.initState();
  }

  void getLastMonthVacationTransaction() async {
    await _vacationTransactionController.getDefualtSearch().then((value) {
      setState(() {
        print(value);
      });
    });
  }

  void reset(){
    statusList.forEach((element) {element.isSelected =false;});
    typeList.forEach((element) {element.isSelected =false;});

  }

  void LoadVacationStatus() async {
    statusList = List();

    await _vacationTransactionController.loadVacationStatus().then((value) {
      setState(() {
        statusList.addAll(value);
        statusValue = statusList[0];
      });
    });
  }

  void LoadVacationType() async {
    typeList = List();

    await _vacationTransactionController.loadVacationTypes().then((value) {
      setState(() {
        typeList.addAll(value);
        typeValue = typeList[0];
      });
    });
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 10));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenLoader(
      screenName: AppTranslations.of(context).text(Const.LOCALE_KEY_VACATION),
      screenWidget: VacationScreen(),
    );
  }

  Widget VacationScreen() {
    final format = DateFormat(Const.DATE_FORMAT);
    bool _isPressed = false;
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
                // color: AppTheme.kPrimaryLightColor.withOpacity(.6),
                borderRadius: BorderRadius.circular(30)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text(
                          AppTranslations.of(context).text(Const.LOCALE_KEY_FILTER_BY),
                          style: TextStyle(color: AppTheme.kPrimaryColor),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isPressed = true;
                              showDialog(
                                  context: context,
                                  builder: (ctx) {
                                    return MultiSelectionLOVListView(
                                      lovs: statusList,
                                    );
                                  });
                            });
                          },
                          child: Container(
                            width: 60,
                            height: 30,
                            decoration: BoxDecoration(
                              color: _isPressed
                                  ? AppTheme.kPrimaryColor.withOpacity(0.2)
                                  : AppTheme.nearlyWhite,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              border: Border.all(
                                  color: AppTheme.grey.withOpacity(0.2)),
                            ),
                            child: Center(
                                child: Text(
                                  AppTranslations.of(context).text(Const.LOCALE_KEY_SATAUS),
                              style: TextStyle(color: AppTheme.kPrimaryColor),
                              textAlign: TextAlign.center,
                            )),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isPressed = true;
                              showDialog(
                                  context: context,
                                  builder: (ctx) {
                                    return MultiSelectionTypeListView(
                                      types: typeList,
                                    );
                                  });
                            });
                          },
                          child: Container(
                            width: 60,
                            height: 30,
                            decoration: BoxDecoration(
                              color: _isPressed
                                  ? AppTheme.kPrimaryColor.withOpacity(0.2)
                                  : AppTheme.nearlyWhite,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              border: Border.all(
                                  color: AppTheme.grey.withOpacity(0.2)),
                            ),
                            child: Center(
                                child: Text(
                                  AppTranslations.of(context).text(Const.LOCALE_KEY_TYPE),
                              style: TextStyle(color: AppTheme.kPrimaryColor),
                              textAlign: TextAlign.center,
                            )),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.autorenew,
                          color: AppTheme.kPrimaryColor,
                        ),
                        tooltip: 'Reset',
                        hoverColor: AppTheme.kPrimaryColor,
                        splashColor: AppTheme.kPrimaryColor,
                        onPressed: () {
                          setState(() {
                            reset();
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 0, child: Text(AppTranslations.of(context).text(Const.LOCALE_KEY_FROM), style: AppTheme.subtitle)),
                      Expanded(
                        child: DateTimeField(
                          textAlign: TextAlign.center,
                          style: AppTheme.subtitle,
                          format: format,
                          onChanged: (value) {
                            setState(() {
                              if (value != null)
                                fromDate = format.format(value);
                              else
                                fromDate = "";
                            });
                          },
                          onShowPicker: (context, currentValue) {
                            return showDatePicker(
                                context: context,
                                firstDate: DateTime(1900),
                                initialDate: currentValue ?? DateTime.now(),
                                lastDate: DateTime(2100));
                          },
                        ),
                      ),
                      Expanded(
                          flex: 0, child: Text(AppTranslations.of(context).text(Const.LOCALE_KEY_TO), style: AppTheme.subtitle)),
                      Expanded(
                        child: DateTimeField(
                          textAlign: TextAlign.center,
                          style: AppTheme.subtitle,
                          format: format,
                          onChanged: (value) {
                            setState(() {
                              if (value != null)
                                toDate = format.format(value);
                              else
                                toDate = "";
                            });
                          },
                          onShowPicker: (context, currentValue) {
                            return showDatePicker(
                                context: context,
                                firstDate: DateTime(1900),
                                initialDate: currentValue ?? DateTime.now(),
                                lastDate: DateTime(2100));
                          },
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.search,
                          color: AppTheme.kPrimaryColor,
                        ),
                        tooltip: 'search',
                        hoverColor: AppTheme.kPrimaryColor,
                        splashColor: AppTheme.kPrimaryColor,
                        onPressed: () async {

                          setState(() {
                            showSpinner = true;
                          });
                          await _vacationTransactionController
                              .advancedSearch(
                              fromDate, toDate, statusList, typeList)
                              .then((value) {
                            setState(() {
                              print(value);
                            });
                          });
                          setState(() {
                            showSpinner = false;
                          });
                        },
                      ),
                    ],
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     IconButton(
                  //       icon: Icon(
                  //         Icons.search,
                  //         color: AppTheme.kPrimaryColor,
                  //       ),
                  //       tooltip: 'search',
                  //       hoverColor: AppTheme.kPrimaryColor,
                  //       splashColor: AppTheme.kPrimaryColor,
                  //       onPressed: () async {
                  //
                  //         setState(() {
                  //           showSpinner = true;
                  //         });
                  //         await _vacationTransactionController
                  //           .advancedSearch(
                  //                   fromDate, toDate, statusList, typeList)
                  //               .then((value) {
                  //             setState(() {
                  //               print(value);
                  //             });
                  //           });
                  //         setState(() {
                  //           showSpinner = false;
                  //         });
                  //       },
                  //     ),
                  //     IconButton(
                  //       icon: Icon(
                  //         Icons.autorenew,
                  //         color: AppTheme.kPrimaryColor,
                  //       ),
                  //       tooltip: 'Reset',
                  //       hoverColor: AppTheme.kPrimaryColor,
                  //       splashColor: AppTheme.kPrimaryColor,
                  //       onPressed: () {
                  //         setState(() {
                  //           reset();
                  //         });
                  //       },
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
          FutureBuilder<bool>(
            future: getData(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (!snapshot.hasData) {
                return const SizedBox();
              } else {
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(
                        top: 0, bottom: 0, right: 16, left: 16),
                    itemCount: _vacationTransactionController.vacationList.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      final int count =
                          _vacationTransactionController.vacationList.length > 10
                              ? 10
                              : _vacationTransactionController
                                  .vacationList.length;
                      final Animation<double> animation =
                          Tween<double>(begin: 0.0, end: 1.0).animate(
                              CurvedAnimation(
                                  parent: animationController,
                                  curve: Interval((1 / count) * index, 1.0,
                                      curve: Curves.fastOutSlowIn)));
                      animationController.forward();

                      return VacationView(
                        vacationListItem:
                            _vacationTransactionController.vacationList[index],
                        animation: animation,
                        animationController: animationController,
                        callback: () {
                          // widget.callBack();
                        },
                      );
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class VacationView extends StatelessWidget {
  const VacationView(
      {Key key,
      this.vacationListItem,
      this.animationController,
      this.animation,
      this.callback})
      : super(key: key);

  final VoidCallback callback;
  final VacationListItem vacationListItem;
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
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: AppTheme.kPrimaryLightColor.withOpacity(0.4),
                ),
                width: double.infinity,
                height: 160,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 50,
                      height: 50,
                      margin: MyApp.isEN ? EdgeInsets.only(right: 15):EdgeInsets.only(left: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                            width: 3,
                            color: vacationListItem
                                .getRightColor()
                                .withOpacity(0.2)),
                      ),
                      child: vacationListItem.getRightIcon(),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            vacationListItem.name,
                            style: TextStyle(
                                color: vacationListItem.getRightColor(),
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.adjust,
                                color: vacationListItem.getRightColor(),
                                size: 20,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(AppTranslations.of(context).text(Const.LOCALE_KEY_TYPE),
                                  style: TextStyle(
                                      color: vacationListItem.getRightColor(),
                                      fontSize: 13,
                                      letterSpacing: .3)),
                              Text(
                                  vacationListItem.type.display != null
                                      ? vacationListItem.type.display
                                      : '',
                                  style: TextStyle(
                                      color: vacationListItem.getRightColor(),
                                      fontSize: 13,
                                      letterSpacing: .3)),
                            ],
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.swap_horizontal_circle,
                                color: vacationListItem.getRightColor(),
                                size: 20,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(AppTranslations.of(context).text(Const.LOCALE_KEY_SATAUS),
                                  style: TextStyle(
                                      color: vacationListItem.getRightColor(),
                                      fontSize: 13,
                                      letterSpacing: .3)),
                              Text(vacationListItem.status.display,
                                  style: TextStyle(
                                      color: vacationListItem.getRightColor(),
                                      fontSize: 13,
                                      letterSpacing: .3)),
                            ],
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.calendar_today,
                                color: vacationListItem.getRightColor(),
                                size: 20,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(AppTranslations.of(context).text(Const.LOCALE_KEY_FROM),
                                  style: TextStyle(
                                      color: vacationListItem.getRightColor(),
                                      fontSize: 13,
                                      letterSpacing: .3)),
                              Text(vacationListItem.fromDate,
                                  style: TextStyle(
                                      color: vacationListItem.getRightColor(),
                                      fontSize: 13,
                                      letterSpacing: .3)),
                            ],
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.calendar_today,
                                color: vacationListItem.getRightColor(),
                                size: 20,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(AppTranslations.of(context).text(Const.LOCALE_KEY_TO),
                                  style: TextStyle(
                                      color: vacationListItem.getRightColor(),
                                      fontSize: 13,
                                      letterSpacing: .3)),
                              Text(vacationListItem.toDate,
                                  style: TextStyle(
                                      color: vacationListItem.getRightColor(),
                                      fontSize: 13,
                                      letterSpacing: .3)),
                            ],
                          ),
                        ],
                      ),
                    )
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
