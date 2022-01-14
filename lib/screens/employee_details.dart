import 'package:bluespace_sleepers_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:demoji/demoji.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class EmployeeDetails extends StatefulWidget {
  final String employeeID;
  final String employeeFName;
  // final String employeeLName;
  // final int employeeAge;
  final String employeeRole;
  final int sleepCount;
  const EmployeeDetails({
    Key? key,
    required this.employeeID,
    required this.employeeFName,
    // required this.employeeLName,
    // required this.employeeAge,
    required this.employeeRole,
    required this.sleepCount,
  }) : super(key: key);

  @override
  _EmployeeDetailsState createState() => _EmployeeDetailsState();
}

class _EmployeeDetailsState extends State<EmployeeDetails> {
  int _sleepAdded = 0;
  late int sleepingTimes = 0;

  bool isTapped = false;

  void sleepIncrement() async {
    // SharedPreferences preference = await SharedPreferences.getInstance();
    setState(() {
      // sleepingTimes =
      //     (preference.getInt('power_naps') ?? widget.sleepCount) + 1;
      // preference.setInt('power_naps', sleepingTimes);
      isTapped = true;
      _sleepAdded++;
    });
  }

  IconData emojiFace(int sleepingTimes) {
    if (sleepingTimes > 0 && sleepingTimes < 5) {
      return Icons.favorite;
    }
    if (sleepingTimes >= 5 && sleepingTimes <= 10) {
      return Icons.star;
    }
    return AntDesign.user;
  }

  // void loadCurrentCount() async {
  //   SharedPreferences preference = await SharedPreferences.getInstance();
  //   setState(() {
  //     sleepingTimes = (preference.getInt('power_naps') ?? widget.sleepCount);
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // loadCurrentCount();
    sleepingTimes = widget.sleepCount;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    sleepingTimes = widget.sleepCount + _sleepAdded;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.05,
            ),
            CircleAvatar(
              maxRadius: 45.0,
              backgroundColor: lightBgColor,
              child: CircleAvatar(
                maxRadius: 40.0,
                backgroundColor: Colors.white,
                child: Icon(
                  emojiFace(sleepingTimes),
                  color: lightBgColor,
                  size: 50.0,
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Text(
              widget.employeeFName + ' ' + '( ' + widget.employeeRole + ' )',
              style: bodyText.copyWith(
                fontSize: 20.0,
                color: bgColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: size.height * 0.06,
            ),
            sleepCounter(),
            SizedBox(
              height: size.height * 0.03,
            ),
            tapWhenSleepBtn(),
          ],
        ),
      ),
    );
  }

  AppBar appBar() {
    Size size = MediaQuery.of(context).size;
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      leading: BackButton(
        color: bgColor,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Row(
        children: [
          SizedBox(width: size.width * 0.24),
          Image(
            image: NetworkImage(logo),
            width: size.width * 0.2,
            height: size.height * 0.1,
          ),
        ],
      ),
    );
  }

  Material sleepCounter() {
    Size size = MediaQuery.of(context).size;
    return Material(
      shape: const CircleBorder(),
      // borderRadius: BorderRadius.circular(50.0),
      elevation: 10.0,
      child: Container(
        height: size.height * 0.3,
        width: size.width * 0.4,
        decoration: const BoxDecoration(
          // borderRadius: BorderRadius.circular(50.0),
          gradient: RadialGradient(
            colors: [
              Colors.redAccent,
              Colors.orange,
            ],
            stops: [0.5, 0.8],
            radius: 1.5,
            center: Alignment.bottomCenter,
          ),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                sleepingTimes.toString(),
                style: bodyText.copyWith(
                  color: Colors.white,
                  fontSize: 50.0,
                ),
              ),
              Text(
                'Power Naps!',
                style: bodyText.copyWith(
                  color: Colors.white,
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  DecoratedBox tapWhenSleepBtn() {
    return DecoratedBox(
      position: DecorationPosition.background,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            Colors.blue,
            Colors.blueAccent,
          ],
          stops: [0.5, 0.7],
          radius: 1.0,
          center: Alignment.bottomCenter,
        ),
      ),
      child: ElevatedButton(
        child: Text(
          'Tap',
          style: bodyText.copyWith(color: Colors.white),
        ),
        onPressed: () {
          sleepIncrement();
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(30.0),
          primary: Colors.transparent,
          shape: const CircleBorder(),
          elevation: 12.0,
        ),
      ),
    );
  }
}
