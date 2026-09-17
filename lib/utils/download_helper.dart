import 'download_helper_stub.dart'
    if (dart.library.js_interop) 'download_helper_web.dart';

export 'download_helper_stub.dart'
    if (dart.library.js_interop) 'download_helper_web.dart'
    show downloadPdfBytes, triggerStaticDownload;

void downloadPdf(List<int> bytes, String fileName) {
  downloadPdfBytes(bytes, fileName);
}
