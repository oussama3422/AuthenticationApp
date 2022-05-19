import 'package:flutter/material.dart';
// import 'package:flutter_application_1/module/product.dart';
import 'package:get/get.dart';

import '../controlller/product_controller.dart';


class AddProduct extends StatefulWidget {
  const AddProduct({ Key? key }) : super(key: key);
  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
   ControllerProducts controllerProducts=Get.put(ControllerProducts(  ));


   var titlecontroller= TextEditingController();
   var descriptioncontroller= TextEditingController();
   var pricecontroller= TextEditingController();
   var imagecontroller= TextEditingController();

  bool isLoding=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(title: const Text('Add Product'),centerTitle: true,elevation: 0,backgroundColor: Colors.grey,),
      body:isLoding ?const Center(child:  CircularProgressIndicator(color: Colors.purple,)) : Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children:  [
            TextField(decoration: const InputDecoration(labelText:'Title',hintText: 'Add Title'),
            controller: titlecontroller,
            ),
            TextField(decoration: const InputDecoration(labelText:'Descreption',hintText: 'Add Description'),
            controller: descriptioncontroller,
            ),
            TextField(decoration: const InputDecoration(labelText:'Price',hintText: 'Add Price'),
            controller: pricecontroller,
            ),
            TextField(decoration: const InputDecoration(labelText:'Image',hintText: 'Url Image'),
            controller: imagecontroller,
            ),
            GetBuilder(
              init: controllerProducts,
              builder: ((_) => 
               ElevatedButton(
                onPressed: () async{
                  try{
                      var doublpPrice=double.parse(pricecontroller.text);
                  }catch(e){
                       Get.snackbar('warning', 'Please Enter A valid Price');
                  }
                  if(titlecontroller.text.isEmpty || descriptioncontroller.text.isEmpty || pricecontroller.text.isEmpty || imagecontroller.text.isEmpty){
                    Get.snackbar('Warning','Please enter All Fields',colorText: Colors.white,backgroundColor: Colors.black);
                  }
                     try{

                     }catch(_){
                       return showDialog(
                              context: context,
                              builder: (innerContext)=> AlertDialog(
                              title:const Text('An error occurred!'),
                              content:const Text('Somthing Went Wrong!'),
                              actions: [
                                TextButton(
                                  onPressed: (){
                                    Get.back();
                                  },
                                  child: const Text('Okay'),
                                  )
                              ],
                        ));
                     }finally{
                           setState((){
                            isLoding=false;
                          });
                          Navigator.pop(context);
                     }
                },
                child: const Text('Add Product',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
               )
            ),
            ),
          ],
        ),
        
      ),
    );
  }
}