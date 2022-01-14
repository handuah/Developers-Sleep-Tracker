import 'dart:convert';

import 'package:bluespace_sleepers_app/screens/employee_details.dart';
// import 'package:bluespace_sleepers_app/utils/json_data.dart';
import 'package:bluespace_sleepers_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:http/http.dart' as http;

class EmployeeList extends StatefulWidget {
  const EmployeeList({Key? key}) : super(key: key);

  @override
  _EmployeeListState createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  List employees = [];

  // Employee list function
  Future getAllEmployees() async {
    var res = await http.get(
      Uri.parse("https://powernap.herokuapp.com/all_devs"),
    );
    var jsonbody = res.body;
    var jsonData = jsonDecode(jsonbody);

    setState(() {
      employees = jsonData;
    });
    // ignore: avoid_print
    // print(cryptocurrencies);
    return employees;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllEmployees();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.02,
            ),
            searchInput(),
            SizedBox(
              height: size.height * 0.02,
            ),
            employeeList(),
          ],
        ),
      ),
      appBar: appBar(),
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

  TextField searchInput() {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.search,
          color: bgColor.withOpacity(0.5),
        ),
        suffixIcon: Icon(
          AntDesign.filter,
          color: bgColor.withOpacity(0.5),
        ),
        label: Text(
          'Search Games',
          style: bodyText.copyWith(
              color: bgColor.withOpacity(0.5), fontSize: 14.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: lightBgColor),
        ),
      ),
    );
  }

  Container employeeList() {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.72,
      width: size.width,
      // color: Colors.blue,
      child: employees.isNotEmpty
          ? GridView.builder(
              padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.01, horizontal: size.width * 0.01),
              itemCount: employees.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 20.0,
              ),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EmployeeDetails(
                          employeeID: employees[index]['_id'],
                          employeeFName: employees[index]['name'],
                          // employeeLName: employees[index]['last_name'],
                          // employeeAge: employees[index]['age'],
                          employeeRole: employees[index]['role'],
                          sleepCount:
                              int.tryParse(employees[index]['powerNaps']) ?? 0,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: size.height * 0.2,
                    width: size.width / 2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: bgColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          AntDesign.user,
                          color: lightBgColor,
                          size: 80.0,
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Text(
                          employees[index]['name'],
                          style: bodyText.copyWith(
                              fontSize: 20.0, color: Colors.white),
                        ),
                        SizedBox(
                          height: size.height * 0.04,
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(
                color: bgColor,
              ),
            ),
    );
  }
}
