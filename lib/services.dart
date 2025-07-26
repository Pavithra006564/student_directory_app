import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Future<void> screen({
  required String name,
  required String email,
  required String phonenumber,
  required BuildContext context,
}) async {
  try {
    await FirebaseFirestore.instance.collection("datas").add({
      "Name": name,
      "Email": email,
      "Phone number": phonenumber,
    });
    Navigator.pop(context);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Student Data Uploaded")));
  } catch (e) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(e.toString())));
  }
}

Stream<QuerySnapshot> fetchstudent() {
  return FirebaseFirestore.instance.collection("datas").snapshots();
}

Future<void> deletestudent(String id, BuildContext context) async {
  try {
    await FirebaseFirestore.instance.collection("datas").doc(id).delete();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Student details deleted")));
  } catch (e) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(e.toString())));
  }
}

Future<void> updatestudent(
  String id,
  String name,
  String email,
  String phonenumber,
  BuildContext context,
) async {
  try {
    await FirebaseFirestore.instance.collection("datas").doc(id).update({
      "Name": name,
      "Email": email,
      "Phone number": phonenumber,
    });
    Navigator.pop(context);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Student details updated")));
  } catch (e) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(e.toString())));
  }
}
