import 'package:flutter_share/flutter_share.dart';

Future<void> share(String name, String url) async {
  await FlutterShare.share(
      title: name,
      text: name,
      linkUrl: url,
  );
}
