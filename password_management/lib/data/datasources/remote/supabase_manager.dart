import 'package:password_management/core/config/supabase_postgre_env.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseManager {
  static final SupabaseManager _instance = SupabaseManager._internal();
  factory SupabaseManager() => _instance;
  SupabaseManager._internal();

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: SupabasePostgreEnv.supabaseUrl,
      anonKey: SupabasePostgreEnv.supabaseKey,
    );
  }

  static final SupabaseClient _client = Supabase.instance.client;

  // static Future<void> _auth() async {
  //   // Đăng ký với email và password
  //   final responseSignup = await client.auth.signUp(
  //     email: 'user@example.com',
  //     password: 'password',
  //   );

  //   // Đăng nhập
  //   final responseLogin = await client.auth.signInWithPassword(
  //     email: 'user@example.com',
  //     password: 'password',
  //   );

  //   // Đăng xuất
  //   await client.auth.signOut();

  //   // Lấy thông tin user hiện tại
  //   final user = client.auth.currentUser;
  // }

  static Future<Map<String, dynamic>?> insert(
    String tableName,
    dynamic data,
  ) async {
    try {
      final r = await _client.from(tableName).insert(data).select();
      return r[0];
    } catch (ex) {
      return null;
    }
  }

  static Future<Map<String, dynamic>> getById(
    String tableName,
    Object id,
  ) async {
    final data = await _client.from(tableName).select().eq('id', id).single();
    return data;
  }

  static Future<List<Map<String, dynamic>>> getAll(
    String tableName, [
    List<String> names = const [],
  ]) async {
    final response = await _client.from(tableName).select(names.join(", "));
    return response;
  }

  static Future<bool> update(
    String tableName,
    Object id,
    dynamic newData,
  ) async {
    try {
      await _client.from(tableName).update(newData).eq('id', id);
      return true;
    } catch (ex) {
      return false;
    }
  }

  static Future<bool> delete(String tableName, Object id) async {
    try {
      await _client.from(tableName).delete().eq('id', id);
      return true;
    } catch (ex) {
      return false;
    }
  }

  //Lắng nghe thay đổi realtime
  //   static Future<void>() async {
  // final subscription = client
  //   .from('todos')
  //   .on(SupabaseEventTypes.all, (payload) {
  //     print('Change received: ${payload.eventType}');
  //     print('New data: ${payload.newRecord}');
  //   })
  //   .subscribe();

  // // Hủy lắng nghe khi không cần thiết
  // // subscription.unsubscribe();
  //   }

  //   static Future<void> luuTruFile() async {
  //     // Tải lên file
  // final file = File('path/to/file.jpg');
  // final fileBytes = await file.readAsBytes();

  // final response = await supabase
  //   .storage
  //   .from('bucket_name')
  //   .upload('path/to/save/file.jpg', fileBytes);

  // // Tải xuống file
  // final bytes = await supabase
  //   .storage
  //   .from('bucket_name')
  //   .download('path/to/file.jpg');

  // // Lấy URL công khai
  // final publicUrl = supabase
  //   .storage
  //   .from('bucket_name')
  //   .getPublicUrl('path/to/file.jpg');
  //   }
}
