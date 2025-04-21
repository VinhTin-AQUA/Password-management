import 'package:flutter/material.dart';
import 'package:password_management/account_details.dart';
import 'package:password_management/dtos/account.dto.dart';
import 'package:password_management/services/firebase_database.service.dart';
import 'package:password_management/edit_account.dart';
import 'package:password_management/utils/loading.dart';

class ListAccount extends StatefulWidget {
  const ListAccount({super.key});

  @override
  State<ListAccount> createState() => _ListAccountState();
}

class _ListAccountState extends State<ListAccount> {
  late Future<List<Map<String, dynamic>>> accounts;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      setState(() {
        accounts = FirebaseDatabaseService.getAllData();
      });
    } catch (e) {
      //
    }
  }

  Future<void> deleteAccount(String id) async {
    setState(() {
      _isLoading = true;
    });
    final check = await FirebaseDatabaseService.deleteData(id);
    setState(() {
      _isLoading = false;
    });

    if (check == true) {
      setState(() {
        // data.removeWhere((element) => element.id == id);
        accounts = FirebaseDatabaseService.getAllData();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accounts'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh_outlined), // Icon của button
            onPressed: () async {
              await _loadData();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: () async {
              setState(() {
                accounts = FirebaseDatabaseService
                    .getAllData(); // Gọi lại API khi kéo xuống
              });
            },
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: accounts,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No items found'));
                } else {
                  // Hiển thị danh sách các items
                  final items = snapshot.data!;
                  List<AccountDto> data = [];
                  for (final i in items) {
                    final r = AccountDto.fromEncryptedJson(i);
                    data.add(r);
                  }

                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(
                          Icons.account_tree_outlined,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AccountDetails(
                                id: data[index].id,
                              ),
                            ),
                          );
                        },
                        title: Text(data[index].appName),
                        trailing: PopupMenuButton<int>(
                          onSelected: (value) async {
                            if (value == 1) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditAccount(
                                    id: data[index].id,
                                  ),
                                ),
                              );
                            } else if (value == 2) {
                              await deleteAccount(data[index].id);
                            }
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem<int>(
                              value: 1,
                              textStyle: TextStyle(
                                  backgroundColor: Colors.red,
                                  color: Colors.red),
                              child: Text(
                                'Update',
                              ),
                            ),
                            PopupMenuItem<int>(
                              value: 2,
                              child: Text('Remove'),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          LoadingWidget(isLoading: _isLoading),
        ],
      ),
    );
  }
}
