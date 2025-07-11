import 'package:password_management/data/supabase/base_supabase.dart';

class AccountRepo extends BaseSupabase {
  static const String tableName = "accounts";
  static const String idCol = "id";
  static const String appNameCol = "appname";
  static const String userNameCol = "username";
  static const String passwordCol = "password";
  static const String noteCol = "note";
  static const String userId = "userid";

  Future<Map<String, dynamic>?> insert(dynamic data) async {
    final r = await BaseSupabase.client.from(tableName).insert(data).select();
    return r[0];
  }

  Future<Map<String, dynamic>> findOneById(Object id) async {
    final data =
        await BaseSupabase.client
            .from(tableName)
            .select()
            .eq(idCol, id)
            .single();
    return data;
  }

  Future<Map<String, dynamic>> findOneByQuery(Map<String, Object> query) async {
    var response =
        await BaseSupabase.client
            .from(tableName)
            .select()
            .match(query)
            .single();
    return response;
  }

  Future<List<Map<String, dynamic>>> findManyByQuery(
    Map<String, Object> query,
  ) async {
    var response = await BaseSupabase.client
        .from(tableName)
        .select()
        .match(query);
    return response;
  }

  Future<bool> update(Object id, dynamic newData) async {
    await BaseSupabase.client.from(tableName).update(newData).eq(idCol, id);
    return true;
  }

  Future<bool> delete(Object id) async {
    await BaseSupabase.client.from(tableName).delete().eq(idCol, id);
    return true;
  }

  Future<bool> batchUpdate(List<Map<String, dynamic>> updates) async {
    await BaseSupabase.client.rpc(
      'batch_update_accounts',
      params: {'data': updates},
    );

    return true;
  }
}
