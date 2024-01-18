import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:lecle_downloads_path_provider/lecle_downloads_path_provider.dart';
import 'package:path_provider/path_provider.dart';

class DownloadFile {
  String? url;
  String? attach_rowId;
  String? attach_name;
  String? token_id;

  DownloadFile(
    String attachName,
    String attachId, {
    this.attach_name,
    this.attach_rowId,
    this.url,
    this.token_id,
  });

  Future getData() async {
    http.Response response = await http.get(Uri.parse(url! +
        "?" +
        "attach_rowId=" +
        this.attach_rowId! +
        "&tokenId=" +
        this.token_id!));
    if (response.statusCode == 200) {
      Uint8List bytes = response.bodyBytes;
      final dir = await getApplicationDocumentsDirectory();
      File file = File('${dir.path}' + attach_name!);
      await file.writeAsBytes(bytes);
      print(file.path);

      print("Uploaded!");
      return 'Uploaded';
    } else {
      print(response.statusCode);
    }
  }

  void downloadBinaryFile() {
    HttpClient client = new HttpClient();
    List<int> _downloadData = []; // Specify the type as List<int>
    var fileSave = new File('./logo.png');
    client
        .getUrl(Uri.parse(url! +
            "?" +
            "attach_rowId=" +
            attach_rowId! +
            "&tokenId=" +
            token_id!))
        .then((HttpClientRequest request) {
      return request.close();
    }).then((HttpClientResponse response) {
      response.listen((d) => _downloadData.addAll(d), onDone: () {
        fileSave.writeAsBytes(_downloadData);
      });
    });
  }

  Future<File> downloadFile() async {
    http.Client client = new http.Client();
    var req = await client.get(
      Uri.parse(
          url! + "?" + "attach_rowId=" + attach_rowId! + "&tokenId=" + token_id!),
    );
    var bytes = req.bodyBytes;
    Directory? downloadsDirectory = await DownloadsPath.downloadsDirectory();
    String dir = downloadsDirectory!.path;
    File file = new File('$dir/$attach_name');
    return await file.writeAsBytes(bytes);
  }}
