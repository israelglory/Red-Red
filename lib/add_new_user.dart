// ignore_for_file: prefer_const_constructors, deprecated_member_use, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:red_red_group/model/create_user.dart';
import 'package:red_red_group/model/service.dart';

class AddNewUser extends StatefulWidget {
  const AddNewUser({Key? key}) : super(key: key);

  @override
  State<AddNewUser> createState() => _AddNewUserState();
}

class _AddNewUserState extends State<AddNewUser> {
  Future<CreateUser>? _user;
  @override
  Widget build(BuildContext context) {
    var _namecontroller = TextEditingController();
    var _jobcontroller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New User'),
      ),
      body: (_user == null)
          ? Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                    controller: _namecontroller,
                    decoration: InputDecoration(
                      hintText: 'Your name',
                      prefixIcon: Icon(Icons.person_add),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                    controller: _jobcontroller,
                    decoration: InputDecoration(
                      hintText: 'Your job title',
                      prefixIcon: Icon(Icons.badge),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: RaisedButton(
                    onPressed: () async {
                      setState(() {
                        _user = createUser(
                            _namecontroller.text, _jobcontroller.text);
                      });
                    },
                    child: Text('Add User'),
                  ),
                ),
              ],
            )
          : Center(child: buildFutureBuilder()),
    );
  }

  FutureBuilder<CreateUser> buildFutureBuilder() {
    return FutureBuilder<CreateUser>(
      future: _user,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Center(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Your id: ${snapshot.data!.id}',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Your name: ${snapshot.data!.name}',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Your job: ${snapshot.data!.job}',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'You created this user by: ${snapshot.data!.createdAt.toString()}',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Data Successfully added to Database'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Done'),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return Center(child: const CircularProgressIndicator());
      },
    );
  }
}
