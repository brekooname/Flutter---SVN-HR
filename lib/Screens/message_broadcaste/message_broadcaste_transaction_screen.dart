import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sven_hr/Screens/message_broadcaste/message_broadcaste_controller.dart';
import 'package:sven_hr/Screens/screen_loader.dart';
import 'package:sven_hr/components/text_field_container.dart';
import 'package:sven_hr/localization/app_translations.dart';
import 'package:sven_hr/main.dart';
import 'package:sven_hr/models/response/message_broadcaste_response.dart';
import 'package:sven_hr/utilities/app_theme.dart';
import 'package:sven_hr/utilities/constants.dart';
import 'package:sven_hr/utilities/hex_color.dart';

class MessageBroadcasteScreen extends StatefulWidget {
  static final id = "MessageBroadcasteScreen";

  @override
  _MessageBroadcasteScreenState createState() =>
      _MessageBroadcasteScreenState();
}

class _MessageBroadcasteScreenState extends State<MessageBroadcasteScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  MessageBroadcasteController? _broadcasteController;
  String? fromDate;
  String? toDate;
  bool showSpinner = false;
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _broadcasteController = MessageBroadcasteController();
    getMessageBroadcasteList();
    super.initState();
  }

  void getMessageBroadcasteList() async {
    await _broadcasteController!.getMessageBroadcasteList().then((value) {
      setState(() {
        print(value);
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
      screenName:
          AppTranslations.of(context)!.text(Const.LOCALE_KEY_MY_ANNOUNCEMENTS),
      screenWidget: MessageScreen(),
    );
  }

  Widget MessageScreen() {
    final format = DateFormat(Const.DATE_FORMAT);
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Column(
        children: [
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
                    itemCount: _broadcasteController!.messageList.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      final int count =
                          _broadcasteController!.messageList.length > 10
                              ? 10
                              : _broadcasteController!.messageList.length;
                      final Animation<double> animation =
                          Tween<double>(begin: 0.0, end: 1.0).animate(
                              CurvedAnimation(
                                  parent: animationController!,
                                  curve: Interval((1 / count) * index, 1.0,
                                      curve: Curves.fastOutSlowIn)));
                      animationController!.forward();

                      return MessageItemView(
                        messageListItem:
                            _broadcasteController!.messageList![index],
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

class MessageItemView extends StatelessWidget {
  const MessageItemView(
      {Key? key,
      this.messageListItem,
      this.animationController,
      this.animation,
      this.callback})
      : super(key: key);

  final VoidCallback? callback;
  final MessageBroadcasteResponse? messageListItem;
  final AnimationController? animationController;
  final Animation<dynamic>? animation;

  Future _asyncConfirmDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.close,
                  color: AppTheme.kPrimaryColor,
                ),
                tooltip: 'select',
                hoverColor: AppTheme.kPrimaryColor,
                splashColor: AppTheme.kPrimaryColor,
                onPressed: () async {
                  Navigator.pop(context);
                },
              ),
            ],
            content: Container(
              color: AppTheme.white,
              height: 300,
              width: 200.0,
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextFieldContainer(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(messageListItem!.message_text,style: TextStyle(color: Color(HexColor.getColorFromHex(
                              messageListItem!.message_color))),),
                        )),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext? context, Widget? child) {
        return FadeTransition(
          opacity: animation as Animation<double>,
          child: Transform(
            transform: Matrix4.translationValues(
                100 * (1.0 - animation!.value), 0.0, 0.0),
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                callback!();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: AppTheme.kPrimaryLightColor.withOpacity(0.4),
                ),
                width: double.infinity,
                height: 100,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 40,
                      height: 40,
                      margin: MyApp.isEN
                          ? EdgeInsets.only(right: 10)
                          : EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                            width: 3,
                            color: Color(HexColor.getColorFromHex(
                                messageListItem!.message_color)).withOpacity(0.2)),
                      ),
                      child: messageListItem!.getRightIcon(),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 6,
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.dynamic_feed,
                                color:Color(HexColor.getColorFromHex(
                                    messageListItem!.message_color)),
                                size: 20,
                              ),
                              SizedBox(
                                width: 5,
                              ),

                              Text(
                                  messageListItem!.message_title != null
                                      ? messageListItem!.message_title
                                      : '',
                                  style: TextStyle(
                                      color:Color(HexColor.getColorFromHex(
                                          messageListItem!.message_color)),
                                      fontSize: 13,
                                      letterSpacing: .3)),
                            ],
                          ),
                          SizedBox(
                            height: 6,
                          ),

                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                IconButton(
                                    icon: Icon(
                                      Icons.more_horiz,
                                      color: Color(HexColor.getColorFromHex(
                                          messageListItem!.message_color)),
                                      size: 25,
                                    ),
                                    tooltip: 'search',
                                    onPressed: () {
                                      _asyncConfirmDialog(context!);
                                    }),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 5,
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
