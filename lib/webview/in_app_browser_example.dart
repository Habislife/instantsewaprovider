import 'package:flutter_inappwebview/flutter_inappwebview.dart';
class InAppBrowserExample extends InAppBrowser{
  @override
  Future onBrowserCreated() async{}
  @override
  Future onLoadStart(String url) async{}
  @override
  Future onLoadStop(String url) async{}
  @override
  void onLoadError(String url, int code, String message) {}
  @override
  void onProgressChanged(int progress) {}
  @override
  void onExit() {}
  @override
  Future<ShouldOverrideUrlLoadingAction> shouldOverrideUrlLoading
      (ShouldOverrideUrlLoadingRequest shouldOverrideUrlLoadingRequest) async{
    return ShouldOverrideUrlLoadingAction.ALLOW;
  }
  @override
  void onLoadResource(response) { }
  @override
  void onConsoleMessage(msg) {}
}