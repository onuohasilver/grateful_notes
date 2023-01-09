import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grateful_notes/core/network/response_model.dart';

class FirebaseExtended {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<ResponseModel> emailSignup(
      {required String email, required String password}) async {
    late ResponseModel response;
    try {
      UserCredential uc = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      response = ResponseModel(
          code: 200,
          data: {
            "email": uc.user?.email,
            "id": uc.user?.uid,
            "message": "User created successfully"
          },
          success: true);
    } catch (e) {
      throw (Error.show(e));
    }
    return response;
  }

  Future<ResponseModel> emailSignIn(
      {required String email, required String password}) async {
    late ResponseModel response;
    try {
      UserCredential uc = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      response = ResponseModel(
          code: 200,
          data: {
            "email": uc.user?.email,
            "id": uc.user?.uid,
            "message": "User signed in successfully"
          },
          success: true);
    } catch (e) {
      throw (Error.show(e));
    }

    return response;
  }

  Future<ResponseModel> forgotPassword({required String email}) async {
    late ResponseModel response;
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      response = ResponseModel(
          code: 200,
          data: {"message": "User created successfully"},
          success: true);
    } catch (e) {
      throw (Error.show(e));
    }
    return response;
  }

  Future<ResponseModel> findWhere(
      {required MatcherPath matcher, MatcherPath? matcher2}) async {
    late ResponseModel response;
    log(matcher.toString());
    try {
      QuerySnapshot<Map<String, dynamic>> qs;
      if (matcher2 == null) {
        qs = await firestore
            .collection(matcher.collection)
            .orderBy(matcher.field)
            .startAt([matcher.keyword]).endAt(['${matcher.keyword}~']).get();
      } else {
        qs = await firestore
            .collection(matcher.collection)
            .orderBy(matcher.field)
            .startAt([matcher.keyword]).endAt(['${matcher.keyword}~']).get();
      }

      response = ResponseModel(
          code: 200,
          data: {
            "users": [...qs.docs.map((e) => e.data())]
          },
          success: true);
    } catch (e) {
      throw (Error.show(e));
    }

    return response;
  }

  Future<ResponseModel> findExact({required MatcherPath matcher}) async {
    late ResponseModel response;
    log(matcher.toString());
    try {
      QuerySnapshot<Map<String, dynamic>> qs;
      qs = await firestore
          .collection(matcher.collection)
          .orderBy(matcher.field)
          .startAt([matcher.keyword]).endAt(['${matcher.keyword}']).get();

      response = ResponseModel(
          code: 200,
          data: {
            "users": [...qs.docs.map((e) => e.data())]
          },
          success: true);
    } catch (e) {
      throw (Error.show(e));
    }

    return response;
  }

  Future<ResponseModel> findAndUpdate(
      {required MatcherPath matcher,
      required Map<String, dynamic> data}) async {
    late ResponseModel response;
    log(matcher.toString());
    try {
      // QuerySnapshot<Map<String, dynamic>> qs;
      await firestore
          .collection(matcher.collection)
          .doc(matcher.field)
          .update(data);

      response = ResponseModel(
          code: 200, data: {"update": "Succesful"}, success: true);
    } catch (e) {
      throw (Error.show(e));
    }

    return response;
  }

  Future<ResponseModel> findAndDelete({required MatcherPath matcher}) async {
    late ResponseModel response;
    log(matcher.toString());
    try {
      // QuerySnapshot<Map<String, dynamic>> qs;
      await firestore
          .collection(matcher.collection)
          .doc(matcher.field)
          .delete();

      response = ResponseModel(
          code: 200, data: {"delete": "Succesful"}, success: true);
    } catch (e) {
      throw (Error.show(e));
    }

    return response;
  }
}

class MatcherPath {
  final String collection, field;
  final dynamic keyword;

  MatcherPath(this.collection, this.keyword, this.field);
  @override
  String toString() {
    return "$collection $keyword $field";
  }
}

class Error implements Exception {
  static show(Object e) {
    return ResponseModel(
        code: 400,
        data: {"message": "Failed", "error": e.toString()},
        success: false);
  }
}
