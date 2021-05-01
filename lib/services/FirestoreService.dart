import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirestoreService {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static CollectionReference users = firestore.collection('users');
  static CollectionReference uids = firestore.collection('uids');

  static Future<void> createUser(String userName, BuildContext context) async {
    User user = FirebaseAuth.instance.currentUser;

    if (await users.doc(userName).get().then((value) => value.exists)) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Username is not available.')));
      return;
    }

    if (await uids.doc(user.uid).get().then((value) => value.exists)) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('You have already set your username.')));
      return;
    }

    await users
        .doc(userName)
        .set({
          'userName': userName,
          'uid': user.uid,
          'email': user.email,
          'phoneNumber': user.phoneNumber,
        })
        .then((value) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Username added successfully!!'))))
        .catchError((error) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to add username: $error'))));

    await uids.doc(user.uid).set({
      'userName': userName,
      'uid': user.uid,
    });
  }

  static DocumentReference getUserFromUserName({String userName}) {
    return users.doc(userName);
  }

  static DocumentReference getUserFromId({String uid}) {
    return uids.doc(uid);
  }

  static Future<String> getEmailByUserName(String userName) async {
    DocumentSnapshot userDoc = await users.doc(userName).get();
    String email = userDoc.get('email');

    return email;
  }

  static Future<String> getPhoneNumberByUserName(String userName) async {
    DocumentSnapshot userDoc = await users.doc(userName).get();
    String phoneNumber = userDoc.get('phoneNumber');

    return phoneNumber;
  }

  static Future<void> setCodeforcesHandle(
      {String userName, String handle, BuildContext context}) async {
    await users
        .doc(userName)
        .update({'handle': handle})
        .then((value) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Handle updated successfully!!'))))
        .catchError((error) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to set username: $error'))));
  }
}
