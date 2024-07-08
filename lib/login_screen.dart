import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'colors.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late String _email,_password;

  void signIn ()async{
    await FirebaseAuth.instance
    .signInWithEmailAndPassword(email: _email, password: _password)
    .catchError((onError){if (kDebugMode) {
      print(onError);
    }})
    .then((authUser){
      if (kDebugMode) {
        print(authUser.user!.uid);
      }
      //ZDwNYE29eBPUmPsppEQ4rro1KQQ2
    });

  }
  @override
  Widget build(BuildContext context) {
    double height= MediaQuery.of(context).size.height;
    double width= MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: ()=> FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(),
                  color: Colors.white,
                  width:width,
                  height:250,
                  child: Stack(
                    children: [
                      Image.asset(image,
                      height: height* 0.40,
                      width: width,
                      fit: BoxFit.cover,
                    ),
                      Container(
                      height: height*0.40,
                      width: width,
                     // color: Colors.orangeAccent.withOpacity(0.5),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            stops: [0.3,0.9],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                           colors:[ Colors.transparent, Colors.white,]
                          )
                        ),
                      ),
                    ],
                  ),
                ),

               Container(
                 margin: const EdgeInsets.symmetric(),
                 color: Colors.transparent,
                 width:width,
                 height:25,
                 child:const Align(
                   alignment: Alignment.center,
                   child:
                   Text('Anime Roll',
                   style: TextStyle(
                     fontSize: 25,
                     fontWeight: FontWeight.bold,
                   ),
                   ),

                 ),

               ),
                const Center(
                  child: Text(slogan,
                  style: TextStyle(
                    color: Colors.grey,
                  ),),
                ),
                Padding(

                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                      decoration: BoxDecoration(
                       gradient: LinearGradient(
                         begin: Alignment.centerLeft,
                         end: Alignment.centerRight,
                                 colors:[
                                   Colors.green.withOpacity(0.3),
                                   Colors.green.withOpacity(0.1)
                               ],
                          ),
                       border:const Border(left: BorderSide(color: primaryColor,width: 5))
                        ),
                      child: const Text("  $login",
                        style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),

                 Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextFormField(
                    onSaved: (value){
                      _email=value!;
                    },
                    validator: (email) {
                      if (email!.isEmpty) {
                        return "Please Enter Email";
                      } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(email)) {
                        return "Please Enter a Valid Email";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                   decoration :const InputDecoration(
                             focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: primaryColor),
                      ),
                      prefixIcon: Icon(Icons.email,color:primaryColor),
                      labelText:'EMAIL ADDRESS',
                      labelStyle: TextStyle(color: primaryColor),

                    ),
                  ),
                ),
                 Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 15.0),
                  child: TextFormField(
                    onSaved: (value){
                      _password=value!;
                    },
                    validator:(password){
                      if(password!.isEmpty) {
                        return"Please Enter Password";}

                        else if (password.length<8 || password.length>15){
                        return "Password Length must be more than 8 and lesser than 15 characters";
                      }
                      },



                    obscureText: true,
                    decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: primaryColor),
                      ),
                      prefixIcon: Icon(Icons.lock_open_outlined,color:primaryColor),
                      labelText:'PASSWORD',
                      labelStyle: TextStyle(color: primaryColor),

                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(onPressed: (){}, child: const Text("Forget Password ?",
                  style: TextStyle(color: Colors.black54),)
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: ElevatedButton(
                        onPressed: () {
                           if(formKey.currentState!.validate())
                             {
                              formKey.currentState?.save();
                              signIn();
                              // print(_email);
                              // print(_password);
                            }
                          FocusScope.of(context).unfocus();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          elevation: 15.0,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            'Login to account',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.symmetric(),
                  color: Colors.transparent,
                  width:width,
                  height:100,

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account ?" ),
                      TextButton(onPressed: (){}, child: const Text('Create Account',
                      style: TextStyle(
                        color: primaryColor,
                      ),))
                    ],
                  ),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
