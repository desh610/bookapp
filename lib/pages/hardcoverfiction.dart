import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:bookapp/theme/colors.dart';
import 'package:http/http.dart' as http;
import 'package:bookapp/pages/details.dart';

class HardCoverFiction extends StatefulWidget {
  @override
  _HardCoverFictionState createState() => _HardCoverFictionState();
}

class _HardCoverFictionState extends State<HardCoverFiction> {
  List books = [];
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.fetchBook();
  }

  fetchBook() async {
    setState(() {
      isLoading = true;
    });
    // print("fetching...");
    var url =
        "https://api.nytimes.com/svc/books/v3/lists/current/hardcover-fiction.json?api-key=t7tOmskK80Pexuzfq02yMtL1MWBHjJXB";
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var items = json.decode(response.body)['results']['books'];
      setState(() {
        books = items;
        isLoading = false;
      });
    } else {
      setState(() {
        books = [];
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NYTimes Best Selling Books"),
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    if (books.contains(null) || books.length < 0 || isLoading) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(primary),
        ),
      );
    }
    return ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          //return Text("index $index");
          return getCard(books[index]);
        });
  }

  Widget getCard(index) {
    var title = index['title'];
    var author = index['author'];
    var book_image = index['book_image'];
    var description = index['description'];
    var publisher = index['publisher'];
    var contributor = index['contributor'];
    var rank = index['rank'];
    var amazon_product_url = index['amazon_product_url'];
    

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailsPage(
                        title: title,
                        author: author,
                        description: description,
                        book_image: book_image,
                        publisher: publisher,
                        contributor: contributor,
                        rank: rank,
                        amazon_product_url: amazon_product_url)));
          },
          title: Row(
            children: <Widget>[
              Container(
                width: 95.0,
                height: 135.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      book_image.toString(),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title.toString(),
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    author.toString(),
                    style: TextStyle(fontSize: 17, color: Colors.grey[700]),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
