import 'package:flutter/material.dart';
import 'package:news_api_aplication/components/news.dart';
import 'package:news_api_aplication/provider/news.provider.dart';
import 'package:provider/provider.dart';

class searchPage extends StatefulWidget {
  const searchPage({super.key});

  @override
  State<searchPage> createState() => _searchPageState();
}

class _searchPageState extends State<searchPage> {
  TextEditingController searchController = TextEditingController(text: '');
  @override
  Widget build(BuildContext context) {
    return Consumer<NewsProvider>(
        builder: (BuildContext context, news, Widget? child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cari Berita'),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        hintText: 'Cari Berita ...',
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      news.search(searchController.text);
                    },
                    icon: Icon(Icons.send),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              news.isDataEmpty
                  ? SizedBox()
                  : news.isLoadingSearch
                      ? Center(child: CircularProgressIndicator())
                      : Column(
                          children: [
                            ...news.resSearch!.articles!.map(
                              (e) => News(
                                title: e.title ?? '',
                                image: e.urlToImage ?? '',
                              ),
                            )
                          ],
                        ),
              // const News(
              //   title: 'testing',
              //   image:
              //       'https://d15shllkswkct0.cloudfront.net/wp-content/blogs.dir/1/files/2023/12/musk.jpg',
              // )
            ],
          ),
        )),
      );
    });
  }
}
