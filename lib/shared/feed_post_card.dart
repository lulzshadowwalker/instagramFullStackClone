import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FeedPostCard extends StatelessWidget {
  const FeedPostCard({Key? key}) : super(key: key);

  void _feedMoreButton(BuildContext context) {
    List<Widget> actions = [
      InkWell(
        onTap: () {},
        child: ListTile(
            leading: const Icon(Icons.delete, color: Colors.black),
            title: Text('delete',
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: Colors.black, fontWeight: FontWeight.bold))),
      ),
      InkWell(
        onTap: () {},
        child: ListTile(
            leading: const Icon(Icons.edit, color: Colors.black),
            title: Text('edit',
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: Colors.black, fontWeight: FontWeight.bold))),
      )
    ];

    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        elevation: 4,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (context) {
          return Container(
            height: 380,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    width: 50,
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    shrinkWrap: false,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    children: actions,
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            // * header section
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                    .copyWith(right: 0),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 16,
                      backgroundImage: CachedNetworkImageProvider(
                          'https://images.unsplash.com/photo-1518020382113-a7e8fc38eac9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzJ8fHByb2ZpbGUlMjBwaWN0dXJlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60'),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'lulzshadowwalker',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.more_vert_rounded),
                      onPressed: () => _feedMoreButton(context),
                    )
                  ],
                )),
            // * Image Section

            SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                width: double.infinity,
                child: CachedNetworkImage(
                    imageUrl:
                        'https://images.unsplash.com/photo-1644080140822-19101927e7e5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw2N3x8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60',
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.cover)),
            // * interaction section

            Row(
              children: [
                IconButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                ),
                IconButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onPressed: () {},
                  icon: const Icon(
                    Icons.comment,
                  ),
                ),
                IconButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onPressed: () {},
                  icon: const Icon(
                    Icons.share,
                  ),
                ),
                Expanded(child: Container()),
                IconButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onPressed: () {},
                  icon: const Icon(
                    Icons.bookmark_border,
                  ),
                ),
              ],
            ),
            // * description
          ],
        ));
  }
}
