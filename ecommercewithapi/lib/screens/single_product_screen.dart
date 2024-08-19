import 'package:flutter/material.dart';

import '../api_service/network_controller.dart';

class SingleProductScreen extends StatelessWidget {
  final String id;
  SingleProductScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
      ),
      body: FutureBuilder(
        future: NetworkController.getSinglePosts(id),
        builder: (context, snapshot) {

          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }else if(snapshot.connectionState==ConnectionState.done){

            final ProductData=snapshot.data!;
            return Container(
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
            );

          }
          return Container();

        },
      ),
    );
  }
}
