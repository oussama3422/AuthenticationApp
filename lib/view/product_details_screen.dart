import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controlller/product_controller.dart';
import '../module/product.dart';


class ProductDetailScreen extends StatelessWidget {
   ProductDetailScreen( {Key? key,required this.id}) : super(key: key);
  final String id;



   ControllerProducts controller=Get.put(ControllerProducts());
 

    bool? istrue;
    // "::::::::::::::::::::::::::Create Widget Build App::::::::::::::::::::::::::::::"
    buildContAainer(String id, urlImg){
     Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white 
        ),
       width: 100,
       height: 100,
       child: 
           Column(
             children: [
               Image.network(urlImg),
             ],
           ),
         
     );
    }
  
    // "::::::::::::::::::::::::::Overriding Widget Build App::::::::::::::::::::::::::::::"
  @override
  Widget build(BuildContext context) {
    var filterItem=controller.productList.firstWhere((element) => element.id==id);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details Screen'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        actions: [
          TextButton(onPressed: ()=>controller.updateData(id), child: const Text('Update Product',style: TextStyle(fontWeight: FontWeight.bold),))
        ],
        ),
        body: ListView(
          children:[
                buildContAainer(filterItem.id,filterItem.imageUrl),
          ]
        ),
       
    );
  }
 
}