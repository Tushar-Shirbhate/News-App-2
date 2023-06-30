import 'dart:convert';
import 'package:http/http.dart'as http;
// import 'package:http/http.dart';
import 'package:news_app_4/secret.dart';
import 'package:news_app_4/models/article.dart';
import 'dart:async';
class News{
  List<Article> news=[];

  Future<void>getNews()async{
    // if (apiKey == null) {
    //   print('API Key is null!');
    //   return;
    // }
   String url= "http://newsapi.org/v2/top-headlines?country=in&excludeDomains=stackoverflow.com&sortBy=publishedAt&language=en&apiKey=${apiKey}";
   var response = await http.get(Uri.parse(url));
    print(response.body);

   // var response=await http.get(url);

   var jsonData=jsonDecode(response.body);
   print(jsonData);

   if(jsonData['status']=="ok"){
     jsonData["articles"].forEach((element){
       if(element['urlToImage']!=null&&element['description']!=null){
         Article article=Article(
           title:element['title']==null?"":element['title'],
           author:element['author']==null?"":element['author'],
           description:element['description']==null?"":element['description'],
           urlToImage:element['urlToImage']==null?"":element['urlToImage'],
           publshedAt:DateTime.parse(element['publishedAt']),
           content:element["content"]==null?"":element["content"],
           articleUrl:element["url"]==null?"":element["url"],
         );
         news.add(article);
       }
     });
   }
  }
}

class NewsForCategorie{
  List<Article> news=[];

  Future<void> getNewsForCategory(String category)async{
    String url="http://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=${apiKey}";
    // var response=await http.get(url);
    // Response response = await get(Uri.parse(url));
    var response = await http.get(Uri.parse(url));
    var jsonData= jsonDecode(response.body);
    print(response.body);
    print(jsonData);

    if(jsonData['status']=="ok"){
      jsonData["articles"].forEach((element){

        if(element['urlToImage']!=null&&element['description']!=null){
          Article article=Article(
            title:element['title']==null?"":element['title'],
            author:element['author']==null?"":element['author'],
            description:element['description']==null?"":element['description'],
            urlToImage:element['urlToImage']==null?"":element['urlToImage'],
            publshedAt:DateTime.parse(element['publishedAt']),
            content:element["content"]==null?"":element["content"],
            articleUrl:element["url"]==null?"":element["url"],
          );

          news.add(article);
        }
      });
    }
  }
}

