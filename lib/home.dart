import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_directory_app/services.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 14, 88, 149),
        title: Text(
          "Student Directory",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          emailcontroller.clear();
          namecontroller.clear();
          phonecontroller.clear();
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Add Student Data"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: namecontroller,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        label: Text("Name"),
                      ),
                    ),
                    SizedBox(height: 3),
                    TextFormField(
                      controller: emailcontroller,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        label: Text("Email"),
                      ),
                    ),
                    SizedBox(height: 3),
                    TextFormField(
                      controller: phonecontroller,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        label: Text("Phone number"),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        screen(
                          name: namecontroller.text,
                          email: emailcontroller.text,
                          phonenumber: phonecontroller.text,
                          context: context,
                        );
                      },
                      child: Text(
                        "Add Student",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 2, 61, 109),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        backgroundColor: const Color.fromARGB(255, 14, 86, 145),
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder(
        stream: fetchstudent(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                color: const Color.fromARGB(255, 141, 182, 255),
              ),
            );
          }
          final studentdata = snapshot.data!.docs;
          return ListView.builder(
            itemCount: studentdata.length,
            itemBuilder: (context, index) {
              return ListTile(
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        namecontroller.text = studentdata[index]['Name'];
                        emailcontroller.text = studentdata[index]['Email'];
                        phonecontroller.text = studentdata[index]['Phone number'];
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Column(
                              children: [
                                TextFormField(
                                  controller: namecontroller,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    label: Text("Name"),
                                  ),
                                ),
                                SizedBox(height: 3),
                                TextFormField(
                                  controller: emailcontroller,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    label: Text("Email"),
                                  ),
                                ),
                                SizedBox(height: 3),
                                TextFormField(
                                  controller: phonecontroller,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    label: Text("Phone number"),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    updatestudent(
                                      studentdata[index].id,
                                      namecontroller.text,
                                      emailcontroller.text,
                                      phonecontroller.text,
                                      context,
                                    );
                                  },
                                  child: Text(
                                    "Update",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color.fromARGB(
                                      255,
                                      2,
                                      61,
                                      109,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        deletestudent(studentdata[index].id, context);
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ],
                ),
                title: Text(studentdata[index]['Name']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(studentdata[index]['Email']),
                    Text(studentdata[index]['Phone number']),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
