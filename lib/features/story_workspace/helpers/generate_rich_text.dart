import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:ss_admin_dashboard/features/story_workspace/helpers/open_url.dart';
import 'package:ss_admin_dashboard/features/story_workspace/helpers/parse_string_to_color.dart';

class GenerateRichText extends StatelessWidget {
  final List<dynamic> data;
  final bool thinText;
  const new({super.key, required this.data, this.thinText = false});

  @override
  Widget build(BuildContext context) {
    final document = Document.fromJson(data);
    final List<InlineSpan> spans = [];

    for (final operation in document.toDelta().toList()) {
      final text = operation.data;
      final attributes = operation.attributes;

      final bool isBold = attributes?['bold'] ?? false;
      final bool isItalic = attributes?['italic'] ?? false;
      final bool isUnderline = attributes?['underline'] ?? false;
      final bool isStrike = attributes?['strike'] ?? false;
      final String textColor = attributes?['color'] ?? "#ff000000";
      final String bgColor =
          attributes?['background'] ?? "#00ffffff"; // Assign color with ' # '

      final String? link = attributes?['link'];

      final String? script = attributes?['script'];

      final String? size = attributes?['size'];

      final textStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
        fontWeight: isBold
            ? FontWeight.bold
            : thinText
            ? FontWeight.w100
            : FontWeight.normal,
        fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,

        decoration: TextDecoration.combine([
          if (isUnderline) TextDecoration.underline,
          if (isStrike) TextDecoration.lineThrough,
        ]),
        color: parseStringToColor(textColor),
        backgroundColor: parseStringToColor(bgColor),

        fontSize: getFontSize(size),
      );

      if (script == "sub") {
        spans.add(
          WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: Transform.translate(
              offset: const Offset(0, 4),
              child: Text(text.toString(), style: textStyle),
            ),
          ),
        );
      } else if (script == "super") {
        spans.add(
          WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: Transform.translate(
              offset: const Offset(0, -6),
              child: Text(text.toString(), style: textStyle),
            ),
          ),
        );
      } else if (link != null) {
        spans.add(
          TextSpan(
            text: text.toString(),
            style: textStyle,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                openUrl(link);
              },
          ),
        );
      } else {
        spans.add(TextSpan(text: text.toString(), style: textStyle));
      }
    }

    return RichText(
      text: TextSpan(children: spans),
      textAlign: TextAlign.justify,
    );
  }
}

double? getFontSize(String? size) {
  switch (size) {
    case 'small':
      return 12;

    case 'large':
      return 20;

    case 'huge':
      return 28;

    default:
      return null;
  }
}
