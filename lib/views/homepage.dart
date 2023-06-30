import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app_4/helper/data.dart';
import 'package:news_app_4/helper/news.dart';
import 'package:news_app_4/helper/widgets.dart';
import 'package:news_app_4/models/categorie_model.dart';
import 'categorie_news.dart';


class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late bool _loading;
  var newslist;
  List<CategorieModel> categories=[];

  void getNews() async{
    News news=News();
    await news.getNews();
    newslist=news.news;
    setState(() {
      _loading=false;
    });
  }

  @override
  void initState(){
    _loading=true;
    // TODO:implement initState
    super.initState();

    categories=getCategories();
    getNews();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "News",
              style:
              TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
            ),
            Text(
              " App",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: _loading
        ?Center(
          child: CircularProgressIndicator(),
        )
            :SingleChildScrollView(
          child: Container(
            child: Column(
              children:<Widget> [
                ///Categories
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  height: 70,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context,index){
                      return CategoryCard(
                        imageAssetUrl:categories[index].imageAssetUrl,
                        categoryName:categories[index].categorieName,
                      );
                      }),
                ),
                /// News Article
                Container(
                  margin: EdgeInsets.only(top: 16),
                  child: ListView.builder(
                    itemCount: newslist.length,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (context,index){
                      return NewsTile(
                        imgUrl:newslist[index].urlToImage ??" ",
                        title:newslist[index].title??"",
                        desc:newslist[index].description??"",
                        content:newslist[index].articleUrl??"",
                        posturl: newslist[index].articleUrl ?? "",
                      );
                      }),
                )
                ],
            ),
          ),
        )
      ),
    );
  }
}
class CategoryCard extends StatelessWidget {
  final String imageAssetUrl,categoryName;
  const CategoryCard({required this.imageAssetUrl,required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context)=>CategoryNews(
              newsCategory:categoryName.toLowerCase(),
            )
        ));
      },
      child: Container(
        margin: EdgeInsets.only(right: 14),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius:BorderRadius.circular(5),
              child: CachedNetworkImage(
                imageUrl: imageAssetUrl,
                height: 60,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 60,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.black26
              ),
              child: Text(
                categoryName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
