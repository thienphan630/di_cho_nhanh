import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:di_cho_nhanh/models/favorite_model.dart';
import 'package:di_cho_nhanh/utilities/get_user_id.dart';

void onFavoriteTap(FavoriteModel favoriteModel) async {
  String userId = getUserId();
  String productId = favoriteModel.id;

  CollectionReference<Map<String, dynamic>> favorite = FirebaseFirestore
      .instance
      .collection('users')
      .doc(userId)
      .collection('favorites');

  await checkIfIsFavorite(userId, productId).then((value) {
    if (value != null) {
      if (value) {
        //delete product in favorites collection
        favorite.where('id', isEqualTo: productId).get().then((querySnapshot) {
          for (var element in querySnapshot.docs) {
            element.reference.delete();
          }
        });
      } else {
        //add product to favorites collection
        favorite.add(favoriteModel.toMap());
      }
    }
  });
}

Future<bool?> checkIfIsFavorite(String currentUserId, String id) async {
  Query<Map<String, dynamic>> favorite = FirebaseFirestore.instance
      .collection('users')
      .doc(currentUserId)
      .collection('favorites')
      .where('id', isEqualTo: id);

  return await favorite.get().then((value) {
    if (value.size == 0) {
      return false;
    } else {
      return true;
    }
  });
}
