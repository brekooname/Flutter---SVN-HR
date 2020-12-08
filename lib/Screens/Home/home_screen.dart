import 'package:flutter/material.dart';
import 'package:sven_hr/Screens/Home/actions_list_view.dart';
import 'package:sven_hr/Screens/Vacations/vacation_transaction_controller.dart';
import 'package:sven_hr/Screens/circular_charts/circular_default_pie.dart';
import 'package:sven_hr/localization/app_translations.dart';
import 'package:sven_hr/models/chart_sample_data.dart';
import 'package:sven_hr/models/response/employee_vacation_response.dart';
import 'package:sven_hr/utilities/app_theme.dart';
import 'package:sven_hr/Screens/Home/category_list_view.dart';
import 'package:sven_hr/utilities/constants.dart';

import '../screen_loader.dart';
import '../Vacations/vacation_request_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);
  static final String id = "MyHomePage";
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
//  List<HomeList> homeList = HomeList.homeList;
  AnimationController animationController;
  bool multiple = true;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    LoadEmployeeVacationsBalance();
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 0));
    return true;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenLoader(
      screenName: AppTranslations.of(context).text(Const.LOCALE_KEY_HOME),
      screenWidget: homeScreen(),
    );
  }

  Widget homeScreen() {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: <Widget>[
          // getSearchBarUI(),
          getVacationPieChart(),
          getPopularCourseUI()
          // CategoryListView(
          //   callBack: () {
          //     moveTo();
          //   },
          // ),

        ],
      ),
    );
  }

  Widget getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.75,
            height: 64,
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.kPrimaryLightColor,
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(13.0),
                    bottomLeft: Radius.circular(13.0),
                    topLeft: Radius.circular(13.0),
                    topRight: Radius.circular(13.0),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: TextFormField(
                          style: TextStyle(
                            fontFamily: 'WorkSans',
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                          ),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: AppTranslations.of(context)
                                .text(Const.LOCALE_KEY_SEARCH),
                            border: InputBorder.none,
                            helperStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: AppTheme.kPrimaryColor.withOpacity(0.4),
                            ),
                          ),
                          onEditingComplete: () {},
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: Icon(Icons.search,
                          color: AppTheme.kPrimaryColor.withOpacity(0.4)),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }



  void LoadEmployeeVacationsBalance() async {
    List<EmployeeVacationResponse> employeeVactionsList;
    VacationTransactionController _vacationTransactionController=VacationTransactionController();

    employeeVactionsList = List();

    await _vacationTransactionController
        .loadEmployeeVacationsBalance()
        .then((value) {
      setState(() {
        if (value != null && value.compareTo(Const.SYSTEM_SUCCESS_MSG) == 0) {
          employeeVactionsList =
              _vacationTransactionController.employeeVactions;

          for (EmployeeVacationResponse intervales in employeeVactionsList) {
            ChartSampleData chartSampleData = ChartSampleData(
                x: intervales.vacation_type_name, y: intervales.remaining_balance);
            chartData.add(chartSampleData);
          }
        }
      });
    });
  }
  List<ChartSampleData> chartData = <ChartSampleData>[];

  Widget getVacationPieChart() {
    return Flexible(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(

          decoration: BoxDecoration(
            color: AppTheme.kPrimaryLightColor.withOpacity(0.5),
            borderRadius: BorderRadius.circular(29),
          ),
          child: CircularDefaultPie(
            title: AppTranslations.of(context).text(Const.LOCALE_KEY_VACATION),
            pieData: chartData,
          ),
        ),
      ),
    );
  }

  Widget getPopularCourseUI() {
    return Expanded(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Text(
          //   AppTranslations.of(context).text(Const.LOCALE_KEY_ANNOUNCEMENTS),
          //   textAlign: TextAlign.left,
          //   style: TextStyle(
          //     fontWeight: FontWeight.w600,
          //     fontSize: 22,
          //     letterSpacing: 0.27,
          //     color: AppTheme.darkerText,
          //   ),
          // ),
          Flexible(
            child: ActionsListView(
              callBack: () {
                moveTo();
              },
            ),
          )
        ],
      ),
    );
  }

  void moveTo() {
    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => VacationRequestScreen(),
      ),
    );
  }
}

class HomeListView extends StatelessWidget {
  const HomeListView(
      {Key key, this.callBack, this.animationController, this.animation})
      : super(key: key);

  final VoidCallback callBack;
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
                0.0, 50 * (1.0 - animation.value), 0.0),
            child: AspectRatio(
              aspectRatio: 1.5,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: <Widget>[
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Colors.grey.withOpacity(0.2),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4.0)),
                        onTap: () {
                          callBack();
                        },
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
