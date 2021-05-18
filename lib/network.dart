import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
class Network with ChangeNotifier
{
  var selstate = 'Overall India';
  String infectedCount = "0";
  String deadCount = "0";
  String curedCount = "0";
  String  activeCount = "0";
  bool loader =true;
  Network()
  {
    getstate('india');
  }
Future getstate(String selstate1) async
{
  if(selstate1=='Overall India'|| selstate1=='india')
  {
    loader=true;
    Response res=await get(Uri.parse('https://covid-19.dataflowkit.com/v1/india'));
    var res1=jsonDecode(res.body);
    print(res1);
    loader=false;
    infectedCount=res1["Total Cases_text"];
    curedCount=res1["Total Recovered_text"];
    deadCount=res1["Total Deaths_text"];
    activeCount=res1["Active Cases_text"];
    notifyListeners();
  }
  else
  {
    loader=true;
    infectedCount="0";
    deadCount="0";
    curedCount="0";
    activeCount="0";
    Response res=await get(Uri.parse('https://api.covid19india.org/state_district_wise.json'));
    var res1=jsonDecode(res.body);
    print(res1[selstate1]);
    int _inf=0;
    int _dead=0;
    int _cured=0;
    int _active=0;
    var res2=res1[selstate]["districtData"];
    print(res2);
    for (var w in res2.values){
          _inf+=w["confirmed"];
          _dead+=w["deceased"];
          _cured+=w["recovered"];
          _active+=w["active"];
    }
    infectedCount=_inf.toString();
    deadCount=_dead.toString();
    curedCount=_cured.toString();
    activeCount=_active.toString();
    loader=false;
    notifyListeners();
  }
}
void changestate(String newstate)
{
  selstate=newstate;
  getstate(selstate);
  notifyListeners();
}
}