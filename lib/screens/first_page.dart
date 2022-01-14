import 'package:bluespace_sleepers_app/screens/employee_list.dart';
import 'package:bluespace_sleepers_app/utils/styles.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              image: NetworkImage(
                logo,
              ),
            ),
            Text(
              'Employee Sleeper App',
              style: bodyText.copyWith(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: size.height * 0.2,
            ),
            goBtn(),
            SizedBox(
              height: size.height * 0.1,
            ),
          ],
        ),
      ),
    );
  }

  SizedBox goBtn() {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.6,
      height: size.height * 0.06,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const EmployeeList(),
            ),
          );
        },
        child: Text(
          'Enter Now',
          style: bodyText.copyWith(
            fontSize: 14.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          primary: lightBgColor,
          elevation: 2.0,
        ),
      ),
    );
  }
}
