import 'dart:convert';
import 'dart:js_interop';
import 'package:web/web.dart' as web;

@JS('downloadPdfFromBase64')
external void _downloadPdfFromBase64(JSString base64Data, JSString filename);

bool _helperInjected = false;

void _ensureHelper() {
  if (_helperInjected) return;
  _helperInjected = true;
  final script = web.document.createElement('script') as web.HTMLScriptElement;
  script.text = '''
    window.downloadPdfFromBase64 = function(base64Data, filename) {
      try {
        var binary = atob(base64Data);
        var len = binary.length;
        var bytes = new Uint8Array(len);
        for (var i = 0; i < len; i++) {
          bytes[i] = binary.charCodeAt(i);
        }
        var blob = new Blob([bytes], { type: 'application/pdf' });
        var blobUrl = URL.createObjectURL(blob);
        var a = document.createElement('a');
        a.href = blobUrl;
        a.download = filename || 'Fares_Elhabashy_CV.pdf';
        var container = document.body || document.documentElement;
        container.appendChild(a);
        a.click();
        setTimeout(function() {
          try {
            container.removeChild(a);
            URL.revokeObjectURL(blobUrl);
          } catch (_) {}
        }, 5000);
      } catch (e) {
        window.open(filename || 'Fares_Elhabashy_CV.pdf', '_blank');
      }
    };
  ''';
  (web.document.head ?? web.document.documentElement)?.appendChild(script);
}

void downloadPdfBytes(List<int> bytes, String fileName) {
  try {
    _ensureHelper();
    final base64Str = base64Encode(bytes);
    _downloadPdfFromBase64(base64Str.toJS, fileName.toJS);
  } catch (_) {
    triggerStaticDownload(fileName);
  }
}

void triggerStaticDownload(String fileName) {
  final anchor = web.document.createElement('a') as web.HTMLAnchorElement;
  anchor.href = fileName;
  anchor.download = fileName;
  anchor.style.display = 'none';
  final container = web.document.body ?? web.document.documentElement;
  container?.appendChild(anchor);
  anchor.click();
  anchor.remove();
}
