import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/helper/date_converter.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/util/styles.dart';
import 'package:flutter_woocommerce/view/base/custom_image.dart';
import 'package:flutter_woocommerce/view/screens/blog/model/blog_post_model.dart';
import 'package:flutter_html/flutter_html.dart';

class BlogDetail extends StatefulWidget {
  final BlogPostModel post;
   BlogDetail({Key key,@required this.post}) : super(key: key);
  @override
  State<BlogDetail> createState() => _BlogDetailState();
}

class _BlogDetailState extends State<BlogDetail> {
  Map<String, dynamic> postsDetails = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String htmlData = widget.post.content.rendered;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            snap: false,
            floating: false,
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
                title: Text(widget.post.title.rendered, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault,color: Theme.of(context).cardColor),
                  maxLines: 2, overflow: TextOverflow.ellipsis),
                background: CustomImage(
                    image: widget.post.imageFeature,
                )
            ),
            leading: IconButton(
              onPressed: () {
              },
              icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).cardColor),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Text('By: ${widget.post.authorName}', style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeDefault)),
                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
                  Text('${DateConverter.estimatedDate(DateTime.parse(widget.post.date))}', style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeDefault)),
                ]
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(10),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Html(data: htmlData);
              }, childCount: 1),
            ),
          )
        ],
      ),
    );
  }
}