import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grateful_notes/core/network/response_model.dart';


abstract class Network {
  post({required UrlPath path, required Map<String, dynamic> body});
  get({required UrlPath path});
  update();
  delete();
}

class NetworkImpl extends Network {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<ResponseModel> post(
      {required UrlPath path, required Map<String, dynamic> body}) async {
    late ResponseModel response;
    try {
      await firestore
          .collection(path.collection)
          .doc(path.id)
          .set(body, SetOptions(merge: true));

      response = ResponseModel(
          code: 200, data: {"message": "Post Success"}, success: true);
    } catch (e) {
      response = ResponseModel(
          code: 400,
          data: {"message": "failed", "error": e.toString()},
          success: false);
    }
    return response;
  }

  @override
  get({required UrlPath path}) async {
    late ResponseModel response;
    try {
      DocumentSnapshot<Map> snapshot =
          await firestore.collection(path.collection).doc(path.id).get();
      log(snapshot.data().toString());
      response =
          ResponseModel(code: 200, data: snapshot.data()!, success: true);
    } catch (e) {
      response = ResponseModel(
          code: 400,
          data: {"message": "failed", "error": e.toString()},
          success: false);
    }
    return response;
  }

  @override
  delete() {}

  @override
  update() {}
}

class UrlPath {
  final String id;
  final String collection;

  UrlPath(
    this.collection,
    this.id,
  );
}
