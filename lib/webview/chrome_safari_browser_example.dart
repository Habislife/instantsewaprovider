import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class ChromeSafariBrowserExample extends ChromeSafariBrowser
{
  ChromeSafariBrowserExample(browserFallBack) : super(bFallback:browserFallBack);
  @override
  void onOpened() {}
  @override
  void onCompletedInitialLoad() {
  }
  @override
  void onClosed() {}
}