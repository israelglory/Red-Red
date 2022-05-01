import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:red_red_group/add_new_user.dart';
import 'package:red_red_group/bloc/user_bloc.dart';
import 'package:red_red_group/model/service.dart';
import 'package:red_red_group/theme.dart';
import 'package:red_red_group/widget/avartar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(
        RepositoryProvider.of<UserRepository>(context),
      )..add(LoadUserEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Red & Red Group'),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (contect) => const AddNewUser(),
                  ),
                );
              },
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: const [Icon(Icons.add), Text('Add New User')],
                  ),
                ),
              ),
            )
          ],
          centerTitle: false,
        ),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is UserLoadedState) {
              return ListView.builder(
                  itemCount: state.User.data.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, i) {
                    return SizedBox(
                      height: 100,
                      //decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey,width: 0.2,),),),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child:
                                  Avatar.large(url: state.User.data[i].avatar),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Text(
                                      '${state.User.data[i].firstName} ${state.User.data[i].lastName}',
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        letterSpacing: 0.2,
                                        wordSpacing: 1.5,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                    child: Text(
                                      'Email: ${state.User.data[i].email}',
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: AppColors.textFaded,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            }
            if (state is UserErrorState) {
              return Center(
                child: Text(
                  state.error.toString(),
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
