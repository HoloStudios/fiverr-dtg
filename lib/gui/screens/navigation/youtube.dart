import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:discover_the_gospel/sharedstate.dart';
import 'package:discover_the_gospel/gui/components/header.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:auto_size_text/auto_size_text.dart';

class YoutubePage extends StatefulWidget {
  const YoutubePage({super.key});

  @override
  State<YoutubePage> createState() => _YoutubePageState();
}

// Button to external youtube video
class YoutubeButton extends StatelessWidget {
  final Uri _url = Uri.parse('https://www.youtube.com/watch?v=9qDCTiKQwd4');

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $_url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.only(top: 4),

      child: SizedBox(
        width: double.infinity, // full-width button, remove if not needed
        child: ElevatedButton(
          onPressed: _launchUrl,
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.zero, // Makes it fully rectangular
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          ),
          child: Text(
            'Open in YouTube',
            style: TextStyle(
              fontFamily: 'Playfair',
              fontSize: 19,
              color: theme.colorScheme.secondary,
            ),
          ),
        ),
      ),
    );
  }
}

class _YoutubePageState extends State<YoutubePage> {
  late YoutubePlayerController youtubeController;
  bool showPlayButton = true;
  bool isPressed = false;

  @override
  void initState(){
    super.initState();
    
    youtubeController = YoutubePlayerController(
      initialVideoId: '9qDCTiKQwd4',
      flags: YoutubePlayerFlags(
        autoPlay: false,
        useHybridComposition: true,
      )
    )..addListener(() {
      if (mounted) {
        if (youtubeController.value.isFullScreen) {
          showNavBar.value = false;
        } else {
          showNavBar.value = true;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: youtubeController,
        showVideoProgressIndicator: true,
      ),
      
      builder: (context, player) {
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
                        // Youtube video
                        Align(
                          alignment: Alignment.center,

                          child: SizedBox(
                            width: double.infinity,
                            child: Container(
                              width: double.infinity,
                              child: Column(
                                children: <Widget>[
                                  AspectRatio(
                                    aspectRatio: 16/9,

                                    child: Container(
                                      color: theme.colorScheme.secondary,

                                      child: Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Stack(
                                          children: [
                                            player,
                                            if (showPlayButton)
                                              Positioned.fill(
                                                child: Center(
                                                  child: Material(
                                                    color: Colors.transparent,
                                                    shape: CircleBorder(),
                                                    child: InkWell(
                                                      borderRadius: BorderRadius.circular(100),
                                                      onTap: () {
                                                        youtubeController.play();
                                                    
                                                        Future.delayed(Duration(milliseconds: 200), () {
                                                          if (mounted) {
                                                            setState(() {
                                                              showPlayButton = false;
                                                            });
                                                          }
                                                        });
                                                      },
                                                      onHighlightChanged: (isHighlighted) {
                                                        setState(() {
                                                          isPressed = isHighlighted;
                                                        });
                                                      },
                                                      child: ColorFiltered(
                                                        colorFilter: ColorFilter.mode(
                                                          isPressed ? Colors.redAccent.withOpacity(0.5) : Colors.transparent,
                                                          BlendMode.srcATop,
                                                        ),
                                                        child: Image.asset(
                                                          'assets/youtube_play_button.png',
                                                          width: 100,
                                                          height: 100,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                  YoutubeButton(),
                                ],
                              )
                            ),
                          ),
                        ),
                        
                        Spacer(),

                        // Descriptive text
                        Container(
                          color: theme.colorScheme.primary,
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return FittedBox(
                                fit: BoxFit.scaleDown,
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(maxWidth: constraints.maxWidth),
                                  child: Text(
                                    'PLEASE CLICK ON THE IMAGE ABOVE TO WATCH THE YOUTUBE VIDEO',
                                    textAlign: TextAlign.center,
                                    softWrap: true,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontFamily: 'Playfair',
                                      fontSize: 19,
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
      },
    );
  }
}