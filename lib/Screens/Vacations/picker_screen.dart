import 'dart:io';
//import 'package:file_picker/file_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sven_hr/localization/app_translations.dart';
import 'package:sven_hr/utilities/app_theme.dart';
import 'package:sven_hr/utilities/constants.dart';
import 'package:mime/mime.dart';

class PickerScreen extends StatefulWidget {
  static final id = "PickerScreen";
  @override
  _PickerScreenState createState() => _PickerScreenState();
}

class _PickerScreenState extends State<PickerScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  String? _retrieveDataError='';
  dynamic _pickImageError;
  final TextEditingController maxWidthController = TextEditingController();
  final TextEditingController maxHeightController = TextEditingController();
  final TextEditingController qualityController = TextEditingController();
  String? _fileName;
  List<File>? _paths;
  String? _directoryPath;
  String? _extension;
  bool _loadingPath = false;
  bool _multiPick = false;
  FileType _pickingType = FileType.any;

  Future<void> retrieveLostData() async {
    final ImagePicker _picker = ImagePicker();
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      if (response.type == RetrieveType.image) {
        setState(() {
          _imageFile = response.file;
        });
      }
    } else {
      _retrieveDataError = response.exception?.code;
    }
  }

  Text? _getRetrieveErrorWidget() {
    final Text? result = Text(_retrieveDataError!);
    _retrieveDataError = null;
    return result!;
      // return null;
  }

  Widget _previewImage() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    return retrieveError!;
    //   if (_paths?.length > 0) {
    //   String mimeStr = lookupMimeType(_paths[0].path);
    //   if (mimeStr.startsWith('image')) {
    //     return Image.file(File(_paths[0].path));
    //   } else {
    //     Navigator.pop(context, _paths[0].path);
    //     return Container();
    //   }
    // } else    return Image.file(File(_imageFile.path));
    //
  }

  Future<void> _displayPickImageDialog(
      BuildContext context, OnPickImageCallback onPick) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add optional parameters'),
            content: Column(
              children: <Widget>[
                TextField(
                  controller: maxWidthController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                      hintText: AppTranslations.of(context)!
                          .text(Const.LOCALE_KEY_ENTER_MAX_WIDTH)),
                ),
                TextField(
                  controller: maxHeightController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                      hintText: AppTranslations.of(context)!
                          .text(Const.LOCALE_KEY_ENTER_MAX_HEIGHT)),
                ),
                TextField(
                  controller: qualityController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: AppTranslations.of(context)!
                          .text(Const.LOCALE_KEY_ENTER_QUALITY)),
                ),
              ],
            ),
            actions: <Widget>[
              ElevatedButton(
                child: Text(
                    AppTranslations.of(context)!.text(Const.LOCALE_KEY_CANCEL)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                  child: Text(
                      AppTranslations.of(context)!.text(Const.LOCALE_KEY_PICK)),
                  onPressed: () {
                    double? width = maxWidthController.text.isNotEmpty
                        ? double.parse(maxWidthController.text)
                        : null;
                    double? height = maxHeightController.text.isNotEmpty
                        ? double.parse(maxHeightController.text)
                        : null;
                    int? quality = qualityController.text.isNotEmpty
                        ? int.parse(qualityController.text)
                        : null;
                    onPick(width!, height!, quality!);
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }

  void _onImageButtonPressed(ImageSource source, {BuildContext? context}) async {
    await _displayPickImageDialog(context!,
            (double maxWidth, double maxHeight, int quality) async {
      try {
        final pickedFile = await _picker.pickImage(
          source: source,
          maxWidth: maxWidth,
          maxHeight: maxHeight,
          imageQuality: quality,
        );
        setState(() {
          _imageFile = pickedFile;
        });
      } catch (e) {
        setState(() {
          _pickImageError = e;
        });
      }
    });
  }

  void _openFileExplorer() async {
    try {
      _imageFile = null;
      _directoryPath = null;
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: _pickingType,
        allowedExtensions: (_extension!.isNotEmpty ?? false)
            ? _extension!.replaceAll(' ', '').split(',')
            : null,
      );

      if (result != null && result.files.isNotEmpty) {
        // Access the selected files through result.files
        List<PlatformFile> files = result.files;
        // Do something with the selected files
        _fileName = files.map((e) => e.path).toString();
      } else {
        // User canceled the file picking
        _fileName = '...';
      }
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    } catch (ex) {
      print(ex);
    }
    if (!mounted) return;
    setState(() {
      _loadingPath = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.nearlyWhite,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppTheme.nearlyWhite, //change your color here
        ),
        backgroundColor: AppTheme.kPrimaryColor,
        title:
            Text(AppTranslations.of(context)!.text(Const.LOCALE_KEY_ADD_DOCS)), toolbarTextStyle: AppTheme.textTheme.bodyMedium, titleTextStyle: AppTheme.textTheme.titleLarge,
      ),
      body: Center(
          child: FutureBuilder<void>(
        future: retrieveLostData(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Text(
                AppTranslations.of(context)!.text(Const.LOCALE_KEY_ADD_DOCS),
                textAlign: TextAlign.center,
              );
            case ConnectionState.done:
              return _previewImage();
            default:
              if (snapshot.hasError) {
                return Text(
                  'Pick image error: ${snapshot.error}}',
                  textAlign: TextAlign.center,
                );
              } else {
                return Text(
                  AppTranslations.of(context)!.text(Const.LOCALE_KEY_ADD_DOCS),
                  textAlign: TextAlign.center,
                );
              }
          }
        },

      )),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: FloatingActionButton(
              backgroundColor: AppTheme.kPrimaryColor,
              onPressed: () {
                _onImageButtonPressed(ImageSource.camera, context: context);
              },
              heroTag: 'image1',
              tooltip: 'Take a Photo',
              child: const Icon(Icons.camera_alt),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: FloatingActionButton(
              backgroundColor: AppTheme.kPrimaryColor,
              onPressed: () {
                _openFileExplorer();
              },
              heroTag: 'docs0',
              tooltip: 'Select Document',
              child: const Icon(Icons.attach_file),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: FloatingActionButton(
              backgroundColor: AppTheme.kPrimaryColor,
              onPressed: () {
                Navigator.pop(context, _imageFile!.path);
                            },
              heroTag: 'done',
              tooltip: 'submit',
              child: const Icon(Icons.done),
            ),
          ),
        ],
      ),
    );
  }
}

typedef void OnPickImageCallback(
    double maxWidth, double maxHeight, int quality);
