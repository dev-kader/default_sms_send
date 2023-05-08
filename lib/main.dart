import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      builder: EasyLoading.init(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController phoneController = TextEditingController();

  TextEditingController testController = TextEditingController();

  // default sms send
  void _sendSMS(String message, List<String> recipents) async {
    String _result = await sendSMS(
      message: message,
      recipients: recipents,
    ).catchError((onError) {
      print(onError);
    });
    print(_result);
  }

  // //local database
  // String phoneSmg = '';
  //
  // Future<void> getData() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   phoneSmg = prefs.getString("phone")!;
  // }
  //
  // @override
  // void initState() {
  //   getData();
  //   super.initState();
  // }


  Color? color;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: phoneController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();


                prefs.setString("phone", phoneController.text);
                String phoneSmg = ''; phoneSmg = prefs.getString("phone")!;
                String message = "Save";
                List<String> recipents = [phoneSmg];
                _sendSMS(message, recipents);
              },
              child: const Text("Save Phone number"),
            ),

            TextField(
              keyboardType: TextInputType.number,
              controller: testController,
              onChanged: (val){
                setState(() {
                  val= testController.text;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 10,),

            GestureDetector(
              child: Container(
               color:testController.text.length<8? const Color(0xffFF0000): const Color(0xff0000FF) ,
                width: double.infinity,
                height:50,
                child: Center(child: Text("Send",style: TextStyle(color: Colors.white),)),),
            )
            // SizedBox(
            //   height: 10,
            // ),
            // ElevatedButton(
            //   onPressed: ()async {
            //
            //     String phoneSmg = '';
            //
            //     final prefs = await SharedPreferences.getInstance();
            //     phoneSmg = prefs.getString("phone")!;
            //     String message = "How can i help you?";
            //     List<String> recipents = [phoneSmg];
            //     _sendSMS(message, recipents);
            //   },
            //   child: const Text("send mgs"),
            // ),
          ],
        ),
      ),
    );
  }
}
