import 'package:xml/xml.dart';

class PromoMaterialModel {
  const PromoMaterialModel({
    this.title,
    this.description,
    this.imageUrl,
    this.linkUrl,
    this.type,
  });

  final String? title;
  final String? description;
  final String? imageUrl;
  final String? linkUrl;
  final String? type;

  factory PromoMaterialModel.fromXmlElement(XmlElement element) {
    final values = <String, String>{};

    for (final child in element.childElements) {
      final key = child.name.local.toLowerCase();
      final value = child.innerText.trim();
      if (value.isNotEmpty) {
        values[key] = _normalizeUrl(value);
      }
    }

    return PromoMaterialModel(
      title: _valueByKeys(values, const ['title', 'name', 'caption']),
      description: _valueByKeys(values, const [
        'description',
        'text',
        'comment',
      ]),
      imageUrl: _valueByContains(values, const [
        'image',
        'img',
        'banner',
        'picture',
        'preview',
      ]),
      linkUrl: _valueByContains(values, const ['link', 'url', 'href']),
      type: _valueByKeys(values, const ['type', 'materialtype', 'category']),
    );
  }

  bool get hasContent =>
      title != null ||
      imageUrl != null ||
      linkUrl != null ||
      description != null;

  static String _normalizeUrl(String value) {
    final normalized = value.replaceAll(
      'forex-images.instaforex.com',
      'forex-images.ifxdb.com',
    );

    if (normalized.startsWith('//')) {
      return 'https:$normalized';
    }

    return normalized;
  }

  static String? _valueByKeys(Map<String, String> values, List<String> keys) {
    for (final key in keys) {
      final value = values[key];
      if (value != null && value.isNotEmpty) return value;
    }
    return null;
  }

  static String? _valueByContains(
    Map<String, String> values,
    List<String> fragments,
  ) {
    for (final entry in values.entries) {
      if (fragments.any(entry.key.contains) && entry.value.isNotEmpty) {
        return entry.value;
      }
    }
    return null;
  }
}

class PromoMaterialsParser {
  const PromoMaterialsParser._();

  static List<PromoMaterialModel> parse(String soapResponse) {
    final document = XmlDocument.parse(soapResponse);
    final result = document.descendants.whereType<XmlElement>().where((node) {
      return node.name.local.toLowerCase() == 'getccpromoresult';
    }).firstOrNull;

    final parseRoot =
        _extractNestedXml(result) ?? result ?? document.rootElement;
    return _candidateElements(parseRoot)
        .map(PromoMaterialModel.fromXmlElement)
        .where((item) => item.hasContent)
        .toList();
  }

  static XmlElement? _extractNestedXml(XmlElement? result) {
    if (result == null) return null;

    final text = result.innerText.trim();
    if (!text.startsWith('<')) return null;

    try {
      return XmlDocument.parse(text).rootElement;
    } catch (_) {
      return null;
    }
  }

  static Iterable<XmlElement> _candidateElements(XmlElement root) {
    final directChildren = root.childElements.where((element) {
      return element.childElements.isNotEmpty;
    }).toList();

    if (directChildren.length > 1) {
      return directChildren;
    }

    final descendants = root.descendants.whereType<XmlElement>().where((node) {
      final localName = node.name.local.toLowerCase();
      final hasFields = node.childElements.length >= 2;
      final likelyPromoName =
          localName.contains('promo') ||
          localName.contains('banner') ||
          localName.contains('material');
      return hasFields && likelyPromoName;
    }).toList();

    if (descendants.isNotEmpty) {
      return descendants;
    }

    return directChildren;
  }
}
