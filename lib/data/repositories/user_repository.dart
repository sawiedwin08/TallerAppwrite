import 'package:appwrite/appwrite.dart';
import 'package:users/core/constants/appwrite_constants.dart';
import 'package:users/model/user_model.dart';

class UserRepository {
  final Databases databases;

  UserRepository(this.databases);

  Future<UserModel> createUser(UserModel user) async { //user es nuestro ususario
    try {
      final response = await databases.createDocument(
        databaseId: AppwriteConstants.databaseId, // pasamos a que colecion debedmos guardar
        collectionId: AppwriteConstants.collectionId, // pasamos a que colecion debedmos guardar
        documentId: ID.unique(),
        data: user.toJson(), 
      );

      return UserModel.fromJson(response.data);//retorna el usuario creado
    } catch (e) {
      rethrow;
    }
  }

  Future<List<UserModel>> getUsers() async {
    try {
      final response = await databases.listDocuments(
        databaseId: AppwriteConstants.databaseId, //
        collectionId: AppwriteConstants.collectionId,
      );

      return response.documents
          .map((doc) => UserModel.fromJson(doc.data))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> updateUser(UserModel user) async {
    try {
      final response = await databases.updateDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.collectionId,
        documentId: user.id,
        data: user.toJson(),
      );

      return UserModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      await databases.deleteDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.collectionId,
        documentId: userId,
      );
    } catch (e) {
      rethrow;
    }
  }
}
