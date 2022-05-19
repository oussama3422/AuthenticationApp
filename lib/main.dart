import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/widget/card_widget.dart';
import 'package:flutter_application_1/view/add_product.dart';
import 'package:get/get.dart';
import 'controlller/product_controller.dart';
import 'view/auth_screen.dart';

void main() async{
          WidgetsFlutterBinding.ensureInitialized();
          runApp(const MyApp());
          await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
       home: AuthScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ControllerProducts controllerProducts=Get.put(ControllerProducts( ));
  bool isLoading=true;
   @override
  void initState() {
    controllerProducts.fetchData().then((_) => isLoading=false);
    super.initState();
  }
   
    

   

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(left:8.0),
            child: TextButton(child:const Text(' + Add Product',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.purple) ,) ,onPressed: ()=>Get.to(()=>const AddProduct()),),
          )
        ],
        elevation: 0,
        title: const Text('Products'),centerTitle: true,
      ),
      body:
    (
      controllerProducts.productList.isEmpty
      ?
      SingleChildScrollView(child:  RefreshIndicator(onRefresh: onrefresh, child: const Center(child:Text('No Product Added Until Now. ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),))))
      :
      RefreshIndicator(
        onRefresh: onrefresh,
        color: Colors.purple,
        child: ListView(
          children: controllerProducts.productList.map(
          (item) => Builder(
            builder: ((ctx)=> CardWidget(
              id: item.id,
              title: item.title,
              description:item.description,
              price: item.price,
              imageUrl: item.imageUrl,
              context: ctx,
              )
              )
            )
            ).toList()
        ),
      )
    ),
      // body: ListView.builder(
      //   itemBuilder: ((_, index) {
      //         controllerProducts.productList[index];
      //   }),
      //   itemCount: controllerProducts.productList.length,
      // )
      // ,
       );
  }

  Future<void> onrefresh() async {
    controllerProducts.fetchData();
  }
}
