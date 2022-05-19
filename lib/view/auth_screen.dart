
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/retry.dart';
import 'package:marquee/marquee.dart';
import '../controlller/auth_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({ Key? key }) : super(key: key);
  static const String _imageUrl = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTIcxm1tSJphluNimxurlape3Q9nhLcX3_apA&usqp=CAU';


  @override
  State<AuthScreen> createState() => _AuthScreenState();

 
   
}

class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin {
   
   
  
   
   //we come with Controoler;
     Auth controller=Get.put(Auth( ));


   

   //define  Flobal Key
   final GlobalKey<FormState> _formkey=GlobalKey();


   TextEditingController passwordController=TextEditingController();

  //:::::::::::::::::::Animation Controller::::::::::::::::::
  AnimationController? controlleranimation;
  Animation<Offset>? slideAnimation;
  Animation<double>? opacityAnimation;
@override
  void initState() {
    
    controlleranimation=AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300)
    );
    slideAnimation=Tween(begin:const Offset(0,-0.15),end:const Offset(0,0)).animate(CurvedAnimation(parent: controlleranimation!, curve:Curves.easeIn )) ;
    opacityAnimation=Tween(begin: 0.0,end: 1.0).animate(CurvedAnimation(parent: controlleranimation!, curve:Curves.easeIn )) ;
    super.initState();
  }
@override
  void dispose() {
    controlleranimation!.dispose();
    super.dispose();
  }
 


  @override
  Widget build(BuildContext context) {
    final deviceSize=  MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children:[ 
          Transform.rotate(
            angle: 4/11,
            child: Container(
              padding: const EdgeInsets.all(40),
              margin: const EdgeInsets.only(top:70,bottom: 40),
              child: const Text('OUSSAMA SHOP',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),),
              decoration:  BoxDecoration(
                gradient:const LinearGradient(
                  colors:  [
                    Colors.orange,
                    Colors.purple,
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
            const SizedBox(height: 10,),
            const Text('Welcome,',style:  TextStyle(fontSize: 26,fontWeight: FontWeight.bold),),
            const SizedBox(height: 6,),
            const Text('Sign in to continue!',style: TextStyle(fontSize: 20,color: Colors.blueGrey),),
                  
          Container(
           padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            decoration:  BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              image: const DecorationImage(image: NetworkImage(AuthScreen._imageUrl),scale: 0.1,filterQuality: FilterQuality.high ,fit: BoxFit.fill)
            ),
          child: Obx(() => (
           Column(
              children: [
                // TextFormField(
                //   style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                //   decoration:const  InputDecoration(
                //     label:Text('First Name : ',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                //     icon:Icon(Icons.people,color: Colors.blue,),
                //     hintText: 'Enter first Name ',
                //     hintStyle: TextStyle(color: Colors.white),
                //   ),
                // ),
                //   TextFormField(
                //   style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                //   keyboardType: TextInputType.text,
                //   decoration: const InputDecoration(
                //     icon:Icon(Icons.people,color: Colors.blue,),
                //     label:Text('Last Name : ',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                //     hintText: 'Enter Last Name ',
                //     hintStyle: TextStyle(color: Colors.white),
                //   ),
                // ),
                TextFormField(
                  onSaved: ((newValue) {
                    controller.authenticationData['email']=newValue!;
                  }),
                  validator: (val){
                    if(val!.isEmpty || !val.contains('@gmail.com'))
                    {
                      return 'Invalid Email' ;
                    }return null;
                  },
                  style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                  keyboardType: TextInputType.emailAddress,
                  decoration:const  InputDecoration(
                    icon: Icon(Icons.email,color: Colors.blue,),
                    label: Text('Email : ',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                    hintText: 'Enter E-mail ',
                    fillColor: Colors.white,
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                ),
            
                  TextFormField(
                  controller: passwordController,
                  obscureText:controller.passwordInVisible.value,
                  style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                  keyboardType: TextInputType.visiblePassword,
                  decoration:  InputDecoration(
                    icon:const Icon(Icons.password,color: Colors.blue,),
                    label:const Text('Password : ',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                    hintText: 'Enter Password  ',
                    hintStyle: const TextStyle(color: Colors.white),
                    suffixIcon: IconButton(
                      icon:Icon(controller.passwordInVisible.value ? Icons.visibility : Icons.visibility_off,),
                      onPressed: controller.changeAbscureIcon,
                      ),
                  ),
            
                  validator: ( value) {
                    Pattern pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                     RegExp regex = RegExp(pattern.toString());
                    if (value!.isEmpty ) {
                    return 'Password is required';
                    }else if (!regex.hasMatch(value) || value.length<5 ) {
                      return 'Enter valid password';
                    } else{return null;}
                    
                    },
            
                    onSaved: (val)
                    {
                     controller.authenticationData['password']=val!;
                    },
                  ),
            
                  AnimatedContainer(
                    duration:const Duration(microseconds: 300) ,
                    curve: Curves.easeIn,
                    constraints: BoxConstraints(
                      minHeight:controller.authMode==authenticationMode.singUp? 60:0,
                      maxHeight: controller.authMode==authenticationMode.singUp?120:0,
                      ),
                    child: FadeTransition(
                      opacity: opacityAnimation!,
                      child: SlideTransition(
                        position: slideAnimation!,
                        child: TextFormField(
                          enabled:controller.authMode==controller.authmodeSinUp,
                        style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                        obscureText:controller.passwordInVisible.value,
                        keyboardType: TextInputType.visiblePassword,
                        decoration:  const InputDecoration(
                          icon:Icon(Icons.password,color: Colors.blue,),
                          label:Text('Confirm Password : ',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                          hintText: 'Confirm Password  ',
                          hintStyle: TextStyle(color: Colors.white),
                          suffixIcon: Icon(Icons.visibility_off_outlined)
                           ),
                        validator: controller.authMode==controller.authmodeSinUp?
                           (val)
                           {
                             if(val!=passwordController.text)
                             {
                                 return 'Password does not Match!';
                             }
                             else{
                                return null;
                             }
                           }:null,
                      ),
                      ),
                    ),
                  ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                     key: _formkey,
                     style:ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                       shape:  MaterialStateProperty.all(RoundedRectangleBorder(borderRadius:BorderRadius.circular(30.0)))
                      ) ,
                    onPressed: controller.submit,
                    child:  Text(controller.authMode==controller.authmodeSinUp?'Sing Up':'Login',style:const TextStyle(color:Color.fromARGB(255, 250, 250, 250))),
                    ),
                ),
                  TextButton(
                  child:  Text('${controller.authMode==controller.authmodeSingIn?'SingUp':'Login'} INSTEAD',style: const TextStyle(color: Color.fromARGB(255, 219, 219, 220),fontWeight: FontWeight.bold)),
                  onPressed:()=> controller.switchAuthenticatinMode(),
                  ),
              ],
           )
            ),
          ),
          ),
          
          ]

        ),
      ),
      
    );
  }
}