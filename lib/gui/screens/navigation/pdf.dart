import 'package:flutter/material.dart';
import 'package:discover_the_gospel/gui/components/header.dart';
import 'package:discover_the_gospel/gui/screens/fullscreenpdf.dart';
import 'package:discover_the_gospel/util/responsivetext.dart';

class PDFPage extends StatelessWidget {
  const PDFPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.red,

      body: Container(
        // Background image
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/Brick Cathedral.png'), fit: BoxFit.cover),
        ),

        child: Column(
          children: <Widget>[
            // Logo header
            Header(),

            // Main body

            // PDF View
            Expanded(
              child: Container(
                width: 250,
                margin: EdgeInsets.only(top: 16),

                child: Center(
                  child: Material(
                    color: Colors.transparent,

                    child: InkWell(
                      highlightColor: Colors.black,
                      onTap: () => {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => FullscreenPDFPage(), fullscreenDialog: true),
                        )
                      },

                      child: Hero(
                        tag: 'thumbnail',
                        child: Ink.image(
                          image: AssetImage('assets/Gospel E-Booklet Thumbnail.png'),
                          fit: BoxFit.contain
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Descriptive Text
            Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              color: theme.colorScheme.primary,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return FittedBox(
                    fit: BoxFit.scaleDown,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: constraints.maxWidth),
                      child: Text(
                        'CLICK ON THE E-BOOKLET TO READ',
                        textAlign: TextAlign.center,
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'Playfair',
                          fontSize: Responsivetext.getSize(context, 19),
                          color: theme.colorScheme.secondary,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}