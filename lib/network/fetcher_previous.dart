import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myradio/models/model_latest.dart';


Future<LatestAnswer> getPrevious() async {
  try{
    var response = await http.get(Uri.parse('https://api.zaycev.fm/api/v1/channels/pop/latest?page=1&limit=25'));

    LatestAnswer answer;
    var data = json.decode(response.body);
    answer = LatestAnswer.fromJson(data);

    return answer;
  }catch(e){
    print(e);
    return LatestAnswer();
  }
}