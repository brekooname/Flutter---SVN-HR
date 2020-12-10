import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:downloads_path_provider/downloads_path_provider.dart';


class DownloadFile {
  final String url;
  final String attach_rowId;
  final String attach_name;
  final String token_id;

  DownloadFile({this.url, this.attach_rowId, this.token_id,this.attach_name});

//   Future getData() async {
//     http.Response response = await http.get(
//         url + "?" + "attach_rowId=" + attach_rowId + "&tokenId=" + token_id);
//     if (response.statusCode == 200) {
//       Uint8List bytes = response.bodyBytes;
//       String dir = (await getApplicationDocumentsDirectory()).path;
//       File file = File("$dir/" + attach_name);
//       await file.writeAsBytes(bytes);
//       print(file.path);
// //      print(response.body);weather[0].id
//       print("Uploaded!");
//       return 'Uploaded';
//     } else {
//       print(response.statusCode);
//     }
//   }

  // void downloadBinaryFile() {
  //   HttpClient client = new HttpClient();
  //   var _downloadData = List<int>();
  //   var fileSave = new File('./logo.png');
  //   client.getUrl(Uri.parse( url + "?" + "attach_rowId=" + attach_rowId + "&tokenId=" + token_id))
  //       .then((HttpClientRequest request) {
  //     return request.close();
  //   })
  //       .then((HttpClientResponse response) {
  //     response.listen((d) => _downloadData.addAll(d),
  //         onDone: () {
  //           fileSave.writeAsBytes(_downloadData);
  //         }
  //     );
  //   });
  // }

  Future<File> downloadFile() async {
    http.Client client = new http.Client();
    var req = await client.get(Uri.parse(url + "?" + "attach_rowId=" + attach_rowId + "&tokenId=" + token_id));
    var bytes = req.bodyBytes;
    Directory downloadsDirectory= await DownloadsPathProvider.downloadsDirectory;
    String dir = await downloadsDirectory.path;
    File file = new File('$dir/$attach_name');
    return await file.writeAsBytes(bytes);
  }

}
