import 'dart:convert';import 'package:http/http.dart';


  class FetchMemes{
static fetchNewMemes () async{
Response response =  await get(Uri.parse("https://meme-api.com/gimme"));
print(response.body);
Map bodyData = jsonDecode(response.body);
return (bodyData["url"]);
}
}
