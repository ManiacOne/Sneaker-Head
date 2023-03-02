import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PersonalDetails {
  String userID = '';
  String email = '';
  String name = '';
  String image = '';


  final FirebaseAuth auth = FirebaseAuth.instance;

  Future getPersonalDetails() async {
    final User? user = auth.currentUser;
    final uid = user?.uid;

    final QuerySnapshot details = await FirebaseFirestore.instance
        .collection("users")
        .where("personal-id", isEqualTo: uid)
        .get();
    final List<DocumentSnapshot> docs = details.docs;
    if (docs.isNotEmpty) {
      DocumentSnapshot<Object?>? userDoc = docs.last;
      name = userDoc['name'];
      email = userDoc['email'];
      userID = userDoc['personal-id'];
      image = userDoc['image'];
    }
  }
}
