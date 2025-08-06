import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as ui_auth;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:todo_app/0_data/data_sources/local/hive_local_data_soruce.dart';
import 'package:todo_app/0_data/repositories/todo_repository_local.dart';
import 'package:todo_app/1_domain/repositories/todo_repository.dart';
import 'package:todo_app/2_application/app/basic_app.dart';
import 'package:todo_app/firebase_options.dart';
import 'package:todo_app/2_application/app/cubit/cubit/auth_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  GoRouter.optionURLReflectsImperativeAPIs = true;

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  ui_auth.FirebaseUIAuth.configureProviders([ui_auth.PhoneAuthProvider()]);

  final localDataSource = HiveLocalDataSoruce();
  await localDataSource.init();

  final authCubit = AuthCubit();

  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    authCubit.updateAuthStatus(isLoggedIn: user != null, userId: user?.uid);
  });

  runApp(
    RepositoryProvider<TodoRepository>(
      create: (context) =>
          TodoRepositoryLocal(localDataSource: localDataSource),
      child: BlocProvider<AuthCubit>(
        create: (context) => authCubit,
        child: const BasicApp(),
      ),
    ),
  );
}
