import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:instagram_fullstack_clone/utils/colors.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _showUsers = false;
  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          title: TextField(
            controller: _searchController,
            style: Theme.of(context).textTheme.bodyText1,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(20)),
              hintText: 'Search',
              filled: true,
              fillColor: Colors.grey[800],
            ),
            onSubmitted: (value) {
              print(value);
              setState(() => _showUsers = true);
            },
          ),
        ),
        body: _showUsers
            ? FutureBuilder(
                future: _firestore
                    .collection('users')

                    ///   input + z > X >= input
                    /// 'z' basically is the acceptable range, the lower 'z' is the less forgiving the query is with null being bugged because it can never be < itself
                    .where(
                      'username',
                      isGreaterThanOrEqualTo: _searchController.text,
                      isLessThan: _searchController.text + 'z',
                    )
                    .get(),
                builder: ((context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: ((context, index) => ListTile(
                            leading: CircleAvatar(
                              radius: 18,
                              backgroundImage: CachedNetworkImageProvider(
                                  snapshot.data?.docs[index]['photoUrl']),
                            ),
                            title: Text(
                                '${snapshot.data!.docs[index]['username']}'),
                          )),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
              )
            : FutureBuilder(
                future: _firestore.collection('users').get(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  List<String> _posts = [];

                  for (int i = 0; i < snapshot.data!.docs.length; i++) {
                    FutureBuilder<QuerySnapshot<Map<String, dynamic>>>?
                        _future = FutureBuilder(
                            future: _firestore
                                .collection('users')
                                .doc(snapshot.data!.docs[i]['userId'])
                                .collection('posts')
                                .get(),
                            builder: (context,
                                AsyncSnapshot<
                                        QuerySnapshot<Map<String, dynamic>>>
                                    snapshot) {
                              for (int i = 0;
                                  i < snapshot.data!.docs.length;
                                  i++) {
                                _posts.add(snapshot.data!.docs[i]['photoUrl']);
                              }
                              return Container();
                            });
                  }
                  return GridView.count(
                    crossAxisCount: 4,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    children: _posts
                        .map((e) => CachedNetworkImage(imageUrl: e))
                        .toList(),
                  );
                }));
  }
}
