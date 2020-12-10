import 'package:http/http.dart' as http;
import 'dart:convert';

class MultiPartFileUpload {
  final String url;
  final String filePath;
  final String file_name;
  final String file_type;
  final String approval_inbox_row_id;
  final String token_id;

  MultiPartFileUpload(
      {this.url,
      this.filePath,
      this.file_name,
      this.file_type,
      this.approval_inbox_row_id,
      this.token_id});

  Future getData() async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields['file_name'] = file_name;
    request.fields['file_type'] = file_type;
    request.fields['approval_inbox_row_id'] = approval_inbox_row_id;
    request.fields['token_id'] = token_id;
    request.files.add(
      await http.MultipartFile.fromPath('file', filePath),
    );

    request.send().then((response) {
      if (response.statusCode == 200) {
        // String data = response.body;
        print("Uploaded!");
        return 'Uploaded';
      } else {
        print(response.statusCode);
      }
    });
  }
}



