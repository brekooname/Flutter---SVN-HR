import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sven_hr/Screens/profile/employee_profile_controller.dart';
import 'package:sven_hr/components/flutter_toast_message.dart';
import 'package:sven_hr/components/rounded_password_field.dart';
import 'package:sven_hr/components/text_field_container.dart';
import 'package:sven_hr/localization/app_translations.dart';
import 'package:sven_hr/utilities/app_theme.dart';
import 'package:sven_hr/utilities/constants.dart';

class ChangePasswordScreen extends StatefulWidget {
  static String id="ChangePasswordScreen";
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen>  with TickerProviderStateMixin
{
  final double infoHeight = 364.0;
  AnimationController animationController;
  Animation<double> animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;
  bool showSpinner = false;
  var newPasswordTextController = new TextEditingController();
  var oldPasswordTextController = new TextEditingController();
  var confirmedPasswordTextController = new TextEditingController();
  EmployeeProfileController _employeeProfileController;
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    _employeeProfileController= EmployeeProfileController();
    super.initState();
  }


  void changePassword() async {
    showSpinner = true;


    await _employeeProfileController
        .changePasswordRequest(
      oldPassword: oldPasswordTextController.text,
      newPassword: newPasswordTextController.text,
        confirmedPassword:confirmedPasswordTextController.text
       )
        .then((value) {
      if (value == null) {
        ToastMessage.showErrorMsg(Const.REQUEST_FAILED);
      } else if (value.compareTo(Const.SYSTEM_SUCCESS_MSG) == 0) {
        ToastMessage.showSuccessMsg(Const.REQUEST_SENT_SUCCESSFULLY);
        Navigator.pop(context);
      } else {
        ToastMessage.showErrorMsg(value);
      }
      showSpinner = false;
      setState(() {});
    });
  }


  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
//        resizeToAvoidBottomPadding: false,
        backgroundColor: AppTheme.nearlyWhite,
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Container(
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: Column(

                    children: [
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                color: AppTheme.kPrimaryColor,
                              ),
                              tooltip: 'back',
                              hoverColor: AppTheme.kPrimaryColor,
                              splashColor: AppTheme.kPrimaryColor,
                              onPressed: () async {
                                Navigator.pop(context);
                              },
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Text(
                              AppTranslations.of(context).text(
                                  Const.LOCALE_KEY_CHANGE_PASSWORD),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 22,
                                letterSpacing: 0.27,
                                color: AppTheme.kPrimaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: TextFieldContainer(
                          child: RoundedPasswordField(
                            textController: oldPasswordTextController,
                            text: AppTranslations.of(context)
                                .text(Const.LOCALE_KEY_OLD_PASSWORD),
                          ),
                        ),
                      ),

                      Flexible(
                        flex: 1,
                        child: TextFieldContainer(
                          child: RoundedPasswordField(
                            textController: newPasswordTextController,
                            text: AppTranslations.of(context)
                                .text(Const.LOCALE_KEY_NEW_PASSWORD),
                          ),
                        ),
                      ),

                      Flexible(
                        flex: 1,
                        child: TextFieldContainer(
                          child: RoundedPasswordField(
                            textController: confirmedPasswordTextController,
                            text: AppTranslations.of(context)
                                .text(Const.LOCALE_KEY_CONFRIMED_PASSWORD),
                          ),
                        ),
                      ),


                      Flexible(
                        child: GestureDetector(
                          onTap: () {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              changePassword();
                            }
                          },
                          child: Padding(
                            padding:  const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 10),
                            child: Container(
                              height: 48,
                              decoration: BoxDecoration(
                                color: AppTheme.nearlyBlue,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(16.0),
                                ),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: AppTheme.nearlyBlue
                                          .withOpacity(0.5),
                                      offset: const Offset(1.1, 1.1),
                                      blurRadius: 10.0),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  AppTranslations.of(context)
                                      .text(Const.LOCALE_KEY_CHANGE_PASSWORD),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    letterSpacing: 0.0,
                                    color: AppTheme.nearlyWhite,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

}
