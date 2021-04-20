import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'shimmer.dart';
import 'wiki_search_view_model.dart';
import 'wiki_web_route.dart';

class WikiSearchRoute extends StatefulWidget {
  @override
  _WikiSearchRouteState createState() => _WikiSearchRouteState();
}

class _WikiSearchRouteState extends State<WikiSearchRoute> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WikiSearchViewModel>(
        create: (context) => WikiSearchViewModel(),
        child: Consumer(builder: (context, WikiSearchViewModel model, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.red,
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset('assets/images/wiki_logo.png'),
              ),
              title: _searchTextField(model, context),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  model.resultList.isEmpty
                      ? Center(
                          child: Container(),
                        )
                      : model.isLoading
                          ? ShimmerForSearch()
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              itemCount: model.resultList.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => WikiWebRoute(
                                                title: model.resultList[index].title,
                                              )),
                                    );

                                    model.searchFocus.unfocus();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                                    child: Card(
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                          ),
                                          child: ListTile(
                                            leading: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                child: model.resultList[index]
                                                            .url ==
                                                        null
                                                    ? Container(
                                                        color: Colors.grey[200],
                                                        height: 60,
                                                        width: 60)
                                                    : CachedNetworkImage(
                                                        height: 60,
                                                        width: 60,
                                                        imageUrl: model
                                                            .resultList[index]
                                                            .url,
                                                      )),
                                            title: Text(
                                              model.resultList[index].title ??
                                                  "",
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5,
                                            ),
                                            subtitle: Text(
                                              "${model.resultList[index].desc}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6,
                                            ),
                                            trailing: Icon(
                                              Icons.arrow_forward_ios_outlined,
                                              size: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                ],
              ),
            ),
          );
        }));
  }

  Widget _searchTextField(WikiSearchViewModel model, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        /*decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(
            5.0,
          ),
        ),*/
        child: Center(
          child: TextFormField(
            textAlign: TextAlign.left,
            controller: model.searchController,
            focusNode: model.searchFocus,
            textInputAction: TextInputAction.search,
            onFieldSubmitted: (term) async {
              model.searchFocus.unfocus();
              await model.getResultForSearchQuery();
            },
            style: Theme.of(context).textTheme.headline5,
            decoration: InputDecoration(
              hintText: "Search",
              border: InputBorder.none,
              hintStyle: Theme.of(context).textTheme.headline5.copyWith(
                    color: Colors.white,
                  ),
              suffixIcon: Visibility(
                visible: model.searchController.text != null,
                child: IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    model.searchController.text = "";
                    model.resultList.clear();
                    model.searchFocus.unfocus();
                    model.updateUi();
                  },
                ),
              ),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
