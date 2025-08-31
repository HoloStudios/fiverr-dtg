import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class FullscreenPDFPage extends StatefulWidget {
  const FullscreenPDFPage({super.key});
  
  @override
  State<FullscreenPDFPage> createState() => _FullscreenPDFPageState();
}

class _FullscreenPDFPageState extends State<FullscreenPDFPage> {

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          // PDF preview
          Container(
            // Background image
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/Brick Cathedral.png'), fit: BoxFit.cover),
            ),

            child: Column(
              children: <Widget>[
                Expanded(
                  child: SafeArea(
                    child: SfPdfViewerTheme(
                      data: SfPdfViewerThemeData(
                        backgroundColor: Colors.transparent,
                      ),
                      child: SfPdfViewer.asset(
                        'assets/pdf_booklet.pdf',
                        pageLayoutMode: PdfPageLayoutMode.single,
                        scrollDirection: PdfScrollDirection.horizontal,
                        enableTextSelection: false,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Back button
          Container(
            color: Colors.transparent,
            child: Row(
              children: <Widget>[
                Spacer(),
                Container(
                  margin: EdgeInsets.only(top: 60, right: 32),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(100),
                  ),

                  child: IconButton(
                    icon: Icon(Icons.close_sharp, color: theme.colorScheme.secondary),
                    
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ],
            )
          ),
        ],
      ),
    );
  }
}