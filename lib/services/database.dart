// import 'package:cloud_firestore/cloud_firestore.dart';

// class DatabaseService{
//   final String uid;

//   DatabaseService({required this.uid});
//   DatabaseService.optional(): this(uid: "");


//   final CollectionReference userColl = FirebaseFirestore.instance.collection("general_data");

//   Stream<QuerySnapshot> get data => userColl.snapshots();

//   Future updateGeneral(int coin) async {
//     return await userColl.doc(uid).set({
//       "ecoin" : coin
//     });
//   }
//   Future addCoin(int coin) async {
//     // userColl.doc(uid).get
//     return await userColl.doc(uid).set({
//       "ecoin" : coin
//     });
//   }


// }

// class UserData {
//   int coin;
//   UserData({this.coin = 0});
// }