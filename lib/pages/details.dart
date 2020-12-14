import 'package:flutter/material.dart';
import 'package:bookapp/theme/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsPage extends StatelessWidget {
  final String title;
  final String author;
  final String description;
  final String book_image;
  final String publisher;
  final String contributor;
  final int rank;
  final String amazon_product_url;

  const DetailsPage(
      {Key key,
      this.title,
      this.author,
      this.description,
      this.book_image,
      this.publisher,
      this.contributor,
      this.rank,
      this.amazon_product_url})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text("NYTimes Best Selling Books"),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
          child: Container(
            child: Center(
                child: Column(
              children: <Widget>[
                Container(
                  width: 170.0,
                  height: 250.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        book_image.toString(),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  title,
                  style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "- " + author + " -",
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text("Publisher : " + publisher),
                SizedBox(
                  height: 5.0,
                ),
                Text("Contributor : " + contributor),
                SizedBox(
                  height: 5.0,
                ),
                Text("Rank : #Top" + rank.toString()),
                SizedBox(
                  height: 20.0,
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  onPressed: _launchURL,
                  color: Colors.purple,
                  textColor: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 8.0),
                    child: Text("Buy now".toUpperCase(),
                        style: TextStyle(fontSize: 18.0)),
                  ),
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }

  _launchURL() async {
    String url = amazon_product_url;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could notlaunch $url';
    }
  }
}
