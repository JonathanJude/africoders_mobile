import 'package:africoders_mobile/widgets/html/html_widget.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:url_launcher/url_launcher.dart';

class RenderHtml extends StatelessWidget {
  final String htmlText;
  final TextStyle textStyle;

  RenderHtml({@required this.htmlText, @required this.textStyle});

  //Launch URL
  _launchURL(String url) async {
    //const url = linkUrl;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Html(
      data: htmlText,
      onLinkTap: (url) => _launchURL(url),
      renderNewlines: true,
      defaultTextStyle: textStyle,
    );
  }
}
