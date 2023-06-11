import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/view/screens/blog/model/blog_post_model.dart';
import 'package:flutter_woocommerce/view/screens/blog/repository/blog_repo.dart';
import 'package:get/get.dart';

class BlogController extends GetxController implements GetxService{
  BlogRepo blogRepo;
  BlogController({@required this.blogRepo});


  List<BlogPostModel> _blogPostList;
  List<BlogPostModel> get blogPostList => _blogPostList;


  Future<void> getBlogPosts(int offset) async {
    if(offset==1){
      _blogPostList = [];
    }
    Response response = await blogRepo.getShopProductsList(offset);
    print("======Blog response code======>${response.statusCode}");
    if (response.statusCode == 200) {
      _blogPostList = [];
      response.body.forEach((post) async {
        _blogPostList.add(BlogPostModel.fromJson(post));
      });
    }
    print("======Blog posts======>${_blogPostList.length}");
    update();
  }

}