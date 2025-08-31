import 'package:flutter/material.dart';
import 'package:discover_the_gospel/gui/components/header.dart';
import 'package:auto_size_text/auto_size_text.dart';

class SharePage extends StatefulWidget {
  const SharePage({super.key});

  @override
  State<SharePage> createState() => _SharePageState();
}

class _SharePageState extends State<SharePage> {
  bool isLeftSelected = true;

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
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 16, left: 16, right: 16),

                child: Column(
                  children: <Widget>[
                    // QR code
                    Container(
                      color: theme.colorScheme.primary,
                      height: 300,
                      width: 250,
                      
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            
                            child: SizedBox(
                              width: 250,

                              child: Container(
                                width: double.infinity,
                                child: AspectRatio(
                                  aspectRatio: 1/1,

                                  child: Container(
                                    color: theme.colorScheme.secondary,

                                    child: Padding(
                                      padding: EdgeInsets.all(16),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Color.fromRGBO(22, 22, 223, 1),
                                            width: 2,
                                          ),
                                        ),
                                        child: isLeftSelected ? Image.asset('assets/QRWebsite.png') : Image.asset('assets/QRGooglePlay.png'),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Options
                          Row(
                            children: <Widget>[

                              // Apple button
                              Expanded(
                                child: Container(
                                  height: 50,
                                  color: isLeftSelected ? theme.colorScheme.primary: theme.colorScheme.inversePrimary,

                                  child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        isLeftSelected = true;
                                      });
                                    },
                                    child: Text(
                                      "Website",
                                      style: TextStyle(fontFamily: 'Playfair', fontSize: 16, color: theme.colorScheme.secondary)
                                    ),
                                  ),
                                ),
                              ),

                              // Divider
                              Container(
                                width: 1,
                                height: 50,
                                color: Colors.white24,
                              ),

                              // Google play button
                              Expanded(
                                child: Container(
                                  height: 50,
                                  color: !isLeftSelected ? theme.colorScheme.primary: theme.colorScheme.inversePrimary,
                                  child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        isLeftSelected = false;
                                      });
                                    },
                                    child: Text(
                                      "Google Play",
                                      style: TextStyle(fontFamily: 'Playfair', fontSize: 16, color: theme.colorScheme.secondary),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    Spacer(),

                    // Descriptive text
                    Container(
                      height: 70,
                      color: theme.colorScheme.primary,

                      child: Center(child: 
                        Text(
                          'PLEASE SCAN THE QR CODE TO DOWNLOAD THE APP',

                          maxLines: null,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontFamily: 'Playfair', fontSize: 19, color: theme.colorScheme.secondary)
                        )
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom quote
            Container(
              height: MediaQuery.of(context).size.height * 0.13,
              margin: EdgeInsets.all(16),
              width: double.infinity,
              
              color: theme.colorScheme.primaryContainer,
              child: Container(
                margin: EdgeInsets.all(8),

                // Clock background image
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/Clock.jpg'), fit: BoxFit.cover),
                ),

                child: Stack(
                  children: <Widget>[
                    // Quote source text
                    Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        width: double.infinity,

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.only(right: 4, bottom: 4),
                              child: Text(
                                'Mark 1:3',
                                textAlign: TextAlign.right,
                                style: TextStyle(fontFamily: 'Caudex', fontSize: 14, color: theme.colorScheme.secondary)
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Main quote
                    Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        width: double.infinity,

                        child: Padding(
                          padding: EdgeInsets.only(top: 4, bottom: 4, right: 4, left: 4),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),

                            child: Stack(
                              children: [
                                // Outline (stroke)
                                AutoSizeText(
                                  '"Prepare the way for the Lord, make straight paths for Him."',
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                  maxLines: 3,
                                  style: TextStyle(
                                    fontFamily: 'Caudex',
                                    fontSize: 19,
                                    letterSpacing: 5,
                                    height: 1.2,
                                    foreground: Paint()
                                      ..style = PaintingStyle.stroke
                                      ..strokeWidth = 3
                                      ..color = theme.colorScheme.primary, // Outline color
                                  ),
                                ),
                                // Fill (main text)
                                AutoSizeText(
                                  '"Prepare the way for the Lord, make straight paths for Him."',
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                  maxLines: 3,
                                  style: TextStyle(
                                    fontFamily: 'Caudex',
                                    fontSize: 19,
                                    height: 1.2,
                                    letterSpacing: 5,
                                    color: theme.colorScheme.secondary, // Fill color
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}