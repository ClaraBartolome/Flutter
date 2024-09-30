import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;


final String USER_COLLECTON = "users";
final String POST_COLLECTON = "posts";
class FirebaseService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Map? _currentUser;

  FirebaseService();

  Future<bool> loginUser(
      {required String email, required String password}) async {
    try {
      UserCredential _usercredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if(_usercredential.user != null){
        print("TRUE");
        _currentUser = await getUserData(uid: _usercredential.user!.uid);
        return true;
      }else{
        print("FALSE");
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> registerUser({
    required String name,
    required String email,
    required String password,
    required File image
  }) async{
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      String userId = userCredential.user!.uid;
      String fileName = Timestamp.now().millisecondsSinceEpoch.toString() +
          p.extension(image.path);
      UploadTask task = _storage.ref("images/$userId/$fileName").putFile(image);
      return task.then((_snapshot) async {
        String _downloadURL = await _snapshot.ref.getDownloadURL();
        await _db.collection(USER_COLLECTON).doc(userId).set({
          "name": name,
          "email": email,
          "password": password,
          "image": _downloadURL,
        });
        return true;
      });
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<Map> getUserData({
    required String uid
}) async{
    DocumentSnapshot _doc = await _db.collection(USER_COLLECTON).doc(uid).get();
    return _doc.data() as Map;
  }

  Future<bool> postImage({required File image}) async {
    try{
      String userId = _auth.currentUser!.uid;
      String fileName = Timestamp.now().millisecondsSinceEpoch.toString() +
          p.extension(image.path);
      UploadTask task = _storage.ref("images/$userId/$fileName").putFile(image);
      return await task.then((_snapshot) async {
        String _downloadURL = await _snapshot.ref.getDownloadURL();
        await _db.collection(POST_COLLECTON).add({
          "userId": userId,
          "timestamp": Timestamp.now(),
          "image": _downloadURL,
        });
        return true;
      });
    }catch(e){
      print(e);
      return false;
    }
  }

  Stream<QuerySnapshot> getUserPost(){
    String userId = _auth.currentUser!.uid;
    return _db
        .collection(POST_COLLECTON)
        .where("userId", isEqualTo: userId)
        .snapshots();
  }

  Stream<QuerySnapshot> getLatestPost() {
    return _db
        .collection(POST_COLLECTON)
        .orderBy("timestamp", descending: true)
        .snapshots();
  }

  Map getCurrentUser(){
    return _currentUser!;
  }

  Future<void> logout() async{
    await _auth.signOut();
  }

}
