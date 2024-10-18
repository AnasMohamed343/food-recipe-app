import 'package:recipe_app/database_manager/models/myUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyUserDao {
  //data access object

  static CollectionReference<MyUser> getUsersCollection() {
    var db = FirebaseFirestore.instance; // take obj from database
    return db.collection('Users').withConverter(
          fromFirestore: (snapshot, options) =>
              MyUser.fromFireStore(snapshot.data()),
          toFirestore: (user, options) => user.toFireStore(),
        );
  }

  static Future<void> addUser(MyUser user) {
    var usersCollection = getUsersCollection();
    var doc = usersCollection.doc(user.id);
    return doc.set(user);
  }

  static Future<MyUser?> getUser(String uid) async {
    var usersCollection = getUsersCollection();
    var doc = usersCollection.doc(uid);
    var docSnapshot = await doc.get();
    return docSnapshot.data();
  }

  static Future<void> updateUser(MyUser user) async {
    var usersCollection = getUsersCollection();
    var doc = usersCollection.doc(user.id);
    await doc.set(user, SetOptions(merge: true));
  }

  static Future<void> updateUserProfileImageUrl(MyUser user) async {
    // Assuming you have a way to access your database (e.g., Firestore)
    final userCollection = FirebaseFirestore.instance.collection('Users');

    await userCollection.doc(user.id).update({
      'profileImageUrl': user.profileImageUrl,
    });
  }
}
