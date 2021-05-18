import 'dart:ui';

import 'package:provider/provider.dart';
import './config.dart';
import './widgets/prevention_card.dart';
import 'package:url_launcher/url_launcher.dart';
import './widgets/starts_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'network.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
          create: (context)=>Network(),
          child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void call(String no)async
  {
    String url = 'tel:'+no;
    if(await canLaunch(url))
    await launch(url);
    else
    throw 'Could not launch $url';

  }
  @override
  Widget build(BuildContext context) {
    Network net=Provider.of<Network>(context);
    return Scaffold(
    body: SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 60),
          LocationWidget(),
          SizedBox(height: 24),
          Center(child: net.loader ? CircularProgressIndicator() : Container()),
          StatsCard(
              country: net.selstate,
              infected: net.infectedCount,
              dead: net.deadCount,
              cured: net.curedCount,
              active: net.activeCount
              ),
          Material(
            borderRadius:BorderRadius.circular(20),
            shadowColor: Colors.green,
            color: Colors.green[200],
            elevation: 50,
              child: Column(
              children: [
                Text("Do's",style: GoogleFonts.lobster(
                fontSize: 40,
                color:Colors.white,
                fontWeight:FontWeight.bold
                ),),
                Cards(imageUrl:'assets/washing.png', title: 'Wash your hands frequently using soap and water or an alcohol-based hand rub'),
                Cards(imageUrl:'assets/covernose.png', title: 'Cover your nose and mouth with handkerchief/tissue while sneezing and coughing'),
                Cards(imageUrl:'assets/distancing.png', title: 'Avoid close contact with anyone who has cold or flu-like symptoms.'),
                Cards(imageUrl: 'assets/doct.png',title: 'Seek medical care early if you or your child has a fever, cough or difficulty breathing.',),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(20),
                    elevation: 4,
                    child:Container( 
              child: Row(children: [
              Expanded(flex:3,child:Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Image.asset(
                            'assets/phone.png',
                            fit: BoxFit.contain,
                          ),
              ),),
              Expanded(flex:7,child:Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('If you have any symptoms please call state helpline number helpline at ',style: Config.titleStyle,),
                      GestureDetector(
                        onTap: ()
                        {
                         call("011-23978046");
                        },
                        child:Text("011-23978046",style:GoogleFonts.poppins(
                          fontWeight:FontWeight.bold,
                          decoration: TextDecoration.underline,
                          fontSize: 20
                        ),
                        )
                      )
                    ],
                  ),
              )),
            ],),

        ),

                  ),
                )
              ],

            ),
          ),
          SizedBox(height:30),
          Material(
            elevation: 50,
            shadowColor: Colors.red,
            color: Colors.red[200],
            borderRadius: BorderRadius.circular(20),
              child: Column(
              children: [
                Text("Don'ts",style:GoogleFonts.lobster(
                  fontSize: 40,
                  fontWeight: FontWeight.bold
                )
                ),
                Cards(imageUrl:'assets/dont1.jpg',title:'Don\'t touch your Eyes,Mouth and Nssose'),
                Cards(imageUrl:'assets/dont2.jpg',title:'Don\'t Spit in Public')
              ],
            ),
          ),
          SizedBox(height:20),
          Text(
          'Preventive Measures',
          style: GoogleFonts.courgette(
            fontSize:28,
            fontWeight:FontWeight.bold
          )
           ),
          Container(
            height: 180,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children:[
                PreventionCard(
                  imageUrl: 'assets/hands.jpg',
                  title: 'Wash Hands Often',
                ),
                PreventionCard(
                  imageUrl: 'assets/distance.png',
                  title: 'Keep Social Distance',
                ),
                PreventionCard(
                  imageUrl: 'assets/home.jfif',
                  title: 'Stay at home',
                ),
                PreventionCard(
                  imageUrl: 'assets/mask.jfif',
                  title: 'Put on Face Masks',
                )
              ],
            ),
          ),
        ],
      ),
    ),
    );
  }
}
class Cards extends StatelessWidget {
  String imageUrl;
  String title;
  Cards({this.imageUrl,this.title});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
              color: Colors.white,
              elevation: 4,
              borderRadius: BorderRadius.circular(20),
              child: Container(
              child: Row(children: [
              Expanded(flex:3,child:Padding(
                padding: const EdgeInsets.all(5.0),
                child: Image.asset(
                          imageUrl,
                          fit: BoxFit.contain,
                        ),
              ),),
              Expanded(flex:7,child:Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(title,style: Config.titleStyle,),
              )),
            ],),

          ),
        ),
    );
  }
}
class LocationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Network net=Provider.of<Network>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(FontAwesomeIcons.mapMarkerAlt,
            color: Colors.cyan[900], size: 25),
        DropdownButton<String>(
          value: net.selstate,
          icon: Icon(Icons.arrow_downward),
          iconSize: 25,
          elevation: 16,
          style: TextStyle(color: Colors.deepPurple),
          // underline: Container(
          //   height: 2,
          //   color: Colors.cyan,
          // ),
          // isExpanded: true,
          onChanged: (String newValue) {
            net.changestate(newValue);
          },
          items: <String>[
            'Overall India',
            'Andaman and Nicobar Islands',
            'Andhra Pradesh',
            'Arunachal Pradesh',
            'Assam',
            'Bihar',
            'Chandigarh',
            'Chhattisgarh',
            'Dadra and Nagar Haveli and Daman and Diu',
            'Delhi',
            'Goa',
            'Gujarat',
            'Haryana',
            'Himachal Pradesh',
            'Jammu and Kashmir',
            'Jharkhand',
            'Karnataka',
            'Kerala',
            'Ladakh',
            'Lakshadweep',
            'Madhya Pradesh',
            'Maharashtra',
            'Manipur',
            'Meghalaya',
            'Mizoram',
            'Nagaland',
            'Odisha',
            'Puducherry',
            'Punjab',
            'Rajasthan',
            'Sikkim',
            'Tamil Nadu',
            'Telangana',
            'Tripura',
            'Uttarakhand',
            'Uttar Pradesh',
            'West Bengal'
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(value,style: TextStyle(
                  color:Colors.teal,
                  fontSize: 15
                ),) 
            ));
          }).toList(),
        ),
      ],
    );
  }
}