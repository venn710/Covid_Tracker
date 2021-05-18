import 'package:google_fonts/google_fonts.dart';

import '../config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StatsCard extends StatelessWidget {
  final String country;
  final String infected, dead, cured, active;

  const StatsCard(
      {Key key,
      @required this.country,
      @required this.infected,
      @required this.dead,
      @required this.cured,
      @required this.active})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height:300,
      margin: EdgeInsets.all(8),
      child: Material(
        elevation: 4,
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        shadowColor: Colors.black45,
        child: Container(
          width: MediaQuery.of(context).size.width * 90 / 100,
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex:3,
                  child: ListTile(
                  title:Text(country, style: Config.statsTitleStyle),
                  trailing:Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Config.primaryColor.withOpacity(.3),
                  ),
                  child: Icon(
                    FontAwesomeIcons.chevronDown,
                    color: Config.blueColor,
                    size: 14,
                  ),
                ),
                ),
              ),
              Expanded(
                   child: Divider(
                  color: Colors.black12,
                  thickness: 1,
                ),
              ),
              Expanded(
                flex: 12,
                 child: 
              Column(
                  children: [
                    Expanded(
                        child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        margin: EdgeInsets.only(bottom: 12),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Config.redColor.withOpacity(.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child:
                            Text('Infected : $infected', style: GoogleFonts.poppins(
                         fontSize: 18,
                         color:Colors.red.withOpacity(0.8)
                       )),
                      ),
                    ),
                    Expanded(
                         child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        margin: EdgeInsets.only(bottom: 12),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Config.greenColor.withOpacity(.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text('Cured : $cured', style: GoogleFonts.poppins(
                         fontSize: 18,
                         color:Colors.green.withOpacity(0.8)
                         
                       )),
                      ),
                    ),
             Expanded(
                     child: Container(
                       padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                       margin: EdgeInsets.only(bottom: 12),
                       width: double.infinity,
                       decoration: BoxDecoration(
                         color: Colors.redAccent.withOpacity(0.2),
                         borderRadius: BorderRadius.circular(4),
                       ),
                       child: Text('Active : $active', style:GoogleFonts.poppins(
                         fontSize: 18,
                         color:Colors.red[900].withOpacity(0.8)
                       )),
                 ),
             ),
                    Expanded(
                        child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        margin: EdgeInsets.only(bottom: 12),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[400].withOpacity(0.5),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text('Dead : $dead', style: GoogleFonts.poppins(
                         fontSize: 18,
                         color:Colors.grey.withOpacity(1)
                       )),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
