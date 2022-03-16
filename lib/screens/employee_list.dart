import 'dart:convert';

import 'package:bluespace_sleepers_app/models/database_helper.dart';
import 'package:bluespace_sleepers_app/models/employee_model.dart';
import 'package:bluespace_sleepers_app/screens/employee_details.dart';
import 'package:bluespace_sleepers_app/utils/json_data.dart';
import 'package:bluespace_sleepers_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class EmployeeList extends StatefulWidget {
  const EmployeeList({Key? key}) : super(key: key);

  @override
  _EmployeeListState createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  List<Employee> employeeDetails = [];

  allEmployees() async {
    await DatabaseHelper.instance.getEmployees();
    setState(() {}); //adding this ensures that data on the screen is updated
  }

  @override
  void initState() {
    super.initState();
    DatabaseHelper.instance.initDB('employees.db');
    allEmployees();
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
          'Search Developer',
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

  employeeList() {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: DatabaseHelper.instance.getEmployees(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Employee>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(
                  color: bgColor,
                ),
              );
            case ConnectionState.active:
              return Text('snapshot active');
            case ConnectionState.done:
              return SizedBox(
                height: size.height * 0.72,
                width: size.width,
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return Text(snapshot.data![index].fName);
                  },
                  itemCount: snapshot.data!.length,
                ),
              );
          }
        });
  }
}
