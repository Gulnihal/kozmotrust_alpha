import 'package:kozmotrust/features/insights/screens/add_blog.dart';
import 'package:kozmotrust/models/blog.dart';
import 'package:flutter/material.dart';
import 'package:kozmotrust/features/insights/services/blog_service.dart';
import 'package:kozmotrust/constants/global_variables.dart';
import 'package:kozmotrust/features/insights/screens/single_blog_screen.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';

class BlogsScreen extends StatefulWidget {
  static const String routeName = '/blogs-screen';
  const BlogsScreen({
    super.key,
  });

  @override
  State<BlogsScreen> createState() => _BlogsScreenState();
}

class _BlogsScreenState extends State<BlogsScreen> {
  List<Blog> blogs = [];
  final BlogServices blogServices = BlogServices();

  @override
  void initState() {
    super.initState();
    fetchBlogs();
  }

  void fetchBlogs() async {
    blogs = await blogServices.fetchAllBlogs(context: context);
    setState(() {});
  }

  void navigateToSingleBlog(String title, String image, String body) {
    Navigator.pushNamed(context, SingleBlogScreen.routeName,
        arguments: {image, title, body});
  }

  void navigateToAddBlog() {
    Navigator.pushNamed(context, AddBlog.routeName,);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                  gradient: GlobalVariables.selectedTopBarColor),
            ),
            elevation: 0,
            centerTitle: true,
            title: Image.asset('assets/images/logo.png'),
            actions: [
              user.type == 'user'
                  ? const Icon(Icons.book)
                  : IconButton(
                icon: const Icon(
                  Icons.add_box_outlined,
                  color: GlobalVariables.gptIconColor,
                ),
                onPressed: navigateToAddBlog,
              ),
            ],
          ),
        ),
        backgroundColor: GlobalVariables.backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: blogs.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        navigateToSingleBlog(blogs[index].title, blogs[index].image, blogs[index].body);
                      },
                      child: SingleBlogScreen(
                          image: blogs[index].image,
                          title: blogs[index].title,
                          body: blogs[index].body,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
