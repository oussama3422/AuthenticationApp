
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controlller/product_controller.dart';
import '../../module/product.dart';
import '../product_details_screen.dart';

class CardWidget extends StatefulWidget {
   const CardWidget({ Key? key,required this.id,required this.title,required this.description,required this.price,required this.imageUrl,required this.context}) : super(key: key);

   final String id;
   final String title;
   final String description;
   final double price;
   final String imageUrl;
   final BuildContext context;

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  ControllerProducts controller = ControllerProducts();
  
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GestureDetector(
        onTap: (() => Get.to(()=>ProductDetailScreen(id: widget.id))),
        child: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.blueGrey,borderRadius: BorderRadius.circular(15)),
          height: 250,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset('image/person.jpeg',height: 170,),
              ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     const Padding(padding:EdgeInsets.all(20)),
                     Text(widget.title,style: TextStyle(color:Get.isDarkMode?Colors.white:Colors.black,fontWeight: FontWeight.bold),textAlign:TextAlign.center,),
                     const SizedBox(height: 8),
                     const Divider(color: Colors.brown,height: 20),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Card(child: Text('${widget.price}',style: TextStyle(color:Get.isDarkMode?Colors.white:Colors.black,fontWeight: FontWeight.bold,fontSize: 30))),
                         const Icon(Icons.arrow_forward_ios,size:20),
                       ],
                     ),            
                     const SizedBox(height: 8),
                     const Divider(color: Colors.brown,height: 20),
                     Text(widget.description,style: TextStyle(color:Get.isDarkMode?Colors.white:Colors.black,fontWeight: FontWeight.bold),softWrap: true,),
                    ],
                    ),
              ),
            ),
            
               
              IconButton(
                onPressed: (){
                 setState(() {
                   controller.changeState();
                 });
                },
                icon:Icon(
                  controller.isTrue?Icons.star:Icons.star_border,
                  size: 40,
                  color: controller.isTrue==false?Colors.white:Colors.purpleAccent
                  ),
               
               
                ),
              
              
            ],
          ),
        ),
      ),
    );
  }
 
}