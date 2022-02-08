import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_fullstack_clone/utils/colors.dart';
import 'package:intl/intl.dart';

class FeedPostCard extends StatelessWidget {
  const FeedPostCard(this.postData, {Key? key}) : super(key: key);
  final Map<String, dynamic>? postData;

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // * header section
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                    .copyWith(right: 0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: CachedNetworkImageProvider(
                        postData?['pfpImage'],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              postData?['username'],
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
                    imageUrl: postData?['postUrl'],
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
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17),
                child: Text(
                  '${postData?['likes'].length} likes',
                ),
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17.0),
              child: RichText(
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                    style: Theme.of(context).textTheme.bodyText1,
                    children: [
                      TextSpan(
                        text: '${postData?['username']}\t',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                          text: postData?['description'] ??
                              'everything in life seems to be stuttering'),
                    ]),
              ),
            ),
            const SizedBox(height: 5),

            InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'view all 288 comments',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(color: secondaryColor),
                  ),
                )),
            // * code and paddings here are very messy ik whatever
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                DateFormat.yMMMd().format(postData?['datePublished'].toDate()),
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: secondaryColor.withOpacity(0.6), fontSize: 12),
              ),
            )
          ],
        
        ));
  }
}
