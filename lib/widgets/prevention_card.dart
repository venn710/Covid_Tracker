// import 'package:covidtracker/config.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config.dart';
import 'package:flutter/material.dart';

class PreventionCard extends StatelessWidget {
  final String imageUrl, title;

  const PreventionCard({
    Key key,
    @required this.imageUrl,
    @required this.title,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Material(
            color: Colors.white,
            elevation: 4,
            borderRadius: BorderRadius.circular(20),
            child: Container(
          width: MediaQuery.of(context).size.width,
          child: Row(children: [
            Expanded(flex:2,child:Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image:DecorationImage(image: AssetImage(imageUrl),
                  fit: BoxFit.cover
                  ))
                ),
              ),
            ),
            Expanded(flex:3,child:Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(title,style: GoogleFonts.farsan(
                fontSize:30,
              ))
            )),
          ],),

        ),
      ),
    );

  }
}
