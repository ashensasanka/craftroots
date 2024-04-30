import 'package:craftroots/pages/vendor_login_page.dart';
import 'package:flutter/material.dart';

class VedAlertPage extends StatefulWidget {
  const VedAlertPage({super.key});

  @override
  State<VedAlertPage> createState() => _VedAlertPageState();
}

class _VedAlertPageState extends State<VedAlertPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xffEEEEEE),
            borderRadius: BorderRadius.circular(20),
          ),
          width: 300,
          height: 450,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 100,),
                Text(
                  'Alert!',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Registration completed, Please \nwait for admin approval \n(an email will be sent)',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 100,),
                SizedBox(
                  width: 150, // Set the desired width
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (context) => VendorLoginPage(userType: 'vendor',)));
                    },
                    child: Text('Close',style: TextStyle(color: Colors.white),),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                    ),
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
