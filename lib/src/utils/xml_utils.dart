import 'package:xml/xml.dart';

class XmlUtils {
  static String searchResult(XmlElement xml, String key) {
    var item = xml.findAllElements(key).map((e) => e.text);
    return item.isEmpty ? "" : item.first;
  }

  static double searchResultDouble(XmlElement xml, String key) {
    var item = xml.findAllElements(key).map((e) => e.text);
    return item.isEmpty ? 0 : double.parse(item.first);
  }
}
