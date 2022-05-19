import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../module/product.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
class ControllerProducts extends GetxController{
  List<Product> productList=[
    Product(id: '', title: 'Hello World', description:'Hi How Are uutrgrtgtgtgtgtgtgtgtgtgtgtgtgtgtgtg', price: 3, imageUrl:'https//cdn.pixabay.com/photo/2015/06/19/21/24/the-road-815297__304.jpg' ),
  ];
   bool isTrue=false;


  //  ::::::::::::::::::::::::::::::: UPDATE METHOD IT PUSH DATA IF IT IN DATABASE:::::::::::::::::::::::::::
      Future<void> updateData(String id)async{
    final url='https://productapp-3611c-default-rtdb.firebaseio.com/product/$id.json';

    final productIndex=productList.indexWhere((element) => element.id==id);

    if(productIndex>=0)
    {
      final http.Response response = await http.patch(Uri.parse(url),body: json.encode({
        'title':"",
        'description':"descreption",
        'price':44,
         'imageUrl':"https//cdn.pixabay.com/photo/2015/06/19/21/24/the-road-815297__304.jpg"
      }));
      //  productList[productIndex]=Product(id: id, title: '', description: '', price: 4.9, imageUrl: '');
      update();
    }
    else{
      print('...');
    }
      
    
    
      }
  //  ::::::::::::::::::::::::::::::: FETCH DATA METHOD IT PUSH DATA IF IT IN DATABASE:::::::::::::::::::::::::::
      Future<void> fetchData()async{
         const url='https://productapp-3611c-default-rtdb.firebaseio.com/product.json';
    try{
      final http.Response response = await http.get(Uri.parse(url));
      final  extratedData = json.decode(response.body) as dynamic;
      extratedData.forEach((productId, productdata) {
         var isExist=productList.firstWhere((element) => element.id==productId);
        if(isExist==null)
        {
          productList.add(
              Product(
               id: productId,
               title: productdata['title'],
               description: productdata['description'],
               price: productdata['price'],
               imageUrl: productdata['imageUrl']
            )
            );
        }
       
      });
        
    }catch(error){
     rethrow ;
    }
 
  }

// :::::::::::::::::::::::::::::::::::Add Method ::::::::::::::::::::::::::::::::::::::::::::::::::::::::
   Future<void> add({required String id,required String title,required String description,required double price,required String imageUrl })
  async {
     String url='https://productapp-3611c-default-rtdb.firebaseio.com/product.json';
  
     return  http.post(Uri.parse(url),body:json.encode({
        'id':id,
        'title':title,
        'descripion':description,
        'price':price,
        'imageUrl':imageUrl,
      }).obs).then((response)  {
        Get.snackbar('it show you this', Text(json.decode(response.body)).toString());
        productList.add(
                  Product(
                      id: json.decode(response.body),
                      title: title,
                      description: description,
                      price: price,
                      imageUrl:imageUrl,
             ),
            );
        }).catchError((error){
          throw error;
        });
      
    
  }
  // ::::::::::::::::::::::::::::::::::::::::::::::::Delete Method:::::::::::::::::::::::::::::::::
  void delete(String id)
  async{
    final url='https://productapp-3611c-default-rtdb.firebaseio.com/product/$id.json';
    final productIndex=productList.indexWhere((element) => element.id==id);
     
    Product? productItem=productList[productIndex];
    
    productList.removeAt(productIndex);
    
    var response= await  http.delete(Uri.parse(url));

    if(response.statusCode>=400)
    {
     productList.insert(productIndex, productItem);
     update();
      Get.snackbar('Error', 'Somthing Went Wrong We cant Delete Item');

    }
    else{
      productItem = null;
      Get.snackbar('Delete', 'Item Deleted');
    }

    productList.removeWhere((element) => element.id==id);
    Get.dialog(const Text('Deleted Successfully'));
    update();
  }
// ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
void changeState()
  {
    if(isTrue==false)
    {
    isTrue=true;
    }
    else
    {
      isTrue=false;
    }
 
  
  }
  }


