import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:password_management/dtos/account.dto.dart';
import 'package:password_management/dtos/add_account.dto.dart';

class FirebaseDatabaseService {
  static final String passwordCollectionName = 'passwords';

  static Future<bool> addData(AddAccountDto data) async {
    CollectionReference users =
        FirebaseFirestore.instance.collection(passwordCollectionName);

    try {
      await users.add(data.toEncryptedJson());
      return true; 
    } catch (error) {
      return false; 
    }
  }

  static Future<List<Map<String, dynamic>>> getAllData() async {
    CollectionReference users =
        FirebaseFirestore.instance.collection(passwordCollectionName);
    QuerySnapshot querySnapshot = await users.get();

    List<Map<String, dynamic>> dataList = [];

    for (var doc in querySnapshot.docs) {
      var data = doc.data() as Map<String, dynamic>;
      data['id'] = doc.id;

      dataList.add(data);
    }
    return dataList; 
  }

  static Future<bool> updateData(AccountDto model) async {
    try {
      DocumentReference userDoc = FirebaseFirestore.instance
          .collection(passwordCollectionName)
          .doc(model.id);

      await userDoc.update(model.toEncryptedJson());
      return true;
    } catch (err) {
      return false;
    }
  }

  static Future<bool> deleteData(String docId) async {
    try {
      DocumentReference userDoc = FirebaseFirestore.instance
          .collection(passwordCollectionName)
          .doc(docId);

      await userDoc.delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<Map<String, dynamic>?> getDocumentById(
      String documentId) async {
    try {
      DocumentReference docRef = FirebaseFirestore.instance
          .collection(passwordCollectionName)
          .doc(documentId);

      DocumentSnapshot docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
        data['id'] = docSnapshot.id; 

        return data; 
      } else {
        return null; 
      }
    } catch (e) {
      return null; 
    }
  }
}
