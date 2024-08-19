
import 'package:ecommercewithapi/api_service/network_controller.dart';
import 'package:ecommercewithapi/screens/category_product_screen.dart';
import 'package:ecommercewithapi/screens/single_product_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/product_model.dart';

class HomeScreens extends StatefulWidget {
  const HomeScreens({super.key});

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {

  Future<List<Product>> postsFuture = NetworkController.getPosts();

  List categoryList=["electronics","jewelery","men's clothing","women's clothing"];


  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        leading: IconButton(
          onPressed: (){},
          icon: Icon(Icons.add_shopping_cart_outlined),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 100,
              child: ListView.builder(
                itemCount: categoryList.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                  child: InkWell(
                      child: Text("${categoryList[index]}"),
                    onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return CategoryProductScreen(categoryid: "${categoryList[index]}");
                        },));
                    },
                  ),
                );
              },)
            ),
            Center(
              // FutureBuilder
              child: FutureBuilder<List<Product>>(
                future: postsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // until data is fetched, show loader
                    return Center(child: const CircularProgressIndicator());
                  } else if (snapshot.hasData) {
                    // once data is fetched, display it on screen (call buildPosts())
                    final productsData = snapshot.data!;
                    return buildPosts(productsData);
                  } else {
                    // if no data, show simple Text
                    return const Text("No data available");
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildPosts(List<Product> ProductsData) {
  // ListView Builder to show data in a list


  return ListView.builder(
    shrinkWrap: true,
    itemCount: ProductsData.length,
    itemBuilder: (context, index) {
      final ProductData=ProductsData[index];
      return InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return SingleProductScreen(id: ProductData.id.toString(),);
          },));
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                      child: Image(image: NetworkImage(ProductData.image!),fit: BoxFit.cover,height: 100,width: 100,),

                  ),
                  Text(ProductData.id.toString()!,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  Text(ProductData.title!,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                ],
              ),
              Text(ProductData.description!),
              Text("Category: ${ProductData.category.toString()}",style: TextStyle(color: Colors.red),),
              Row(
                children: [
                  Text("Rating: ${ProductData.rating!.rate.toString()}",style: TextStyle(color: Colors.red),),
                  SizedBox(width: 10,),
                  Text("Count: ${ProductData.rating!.count.toString()}",style: TextStyle(color: Colors.red),),
                  SizedBox(width: 10,),
                  Text("Price: ${ProductData.price.toString()}",style: TextStyle(color: Colors.red),),
                ],
              ),
            ],
          ),
        ),
      );

    },
  );


}

