import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pingolearn/core/appsecrets/app_secrets.dart';
import 'package:pingolearn/core/theme/theme.dart';
import 'package:pingolearn/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:pingolearn/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:pingolearn/features/auth/domain/usecases/user_login.dart';
import 'package:pingolearn/features/auth/domain/usecases/user_signup.dart';
import 'package:pingolearn/features/auth/presentation/pages/login_page.dart';
import 'package:pingolearn/features/auth/presentation/provider/auth_provider.dart';
import 'package:pingolearn/features/auth/presentation/provider/login_provider.dart';
import 'package:pingolearn/features/news/data/datasources/api_remote_datasource.dart';
import 'package:pingolearn/features/news/data/repositories/news_repository_impl.dart';
import 'package:pingolearn/features/news/domain/usecases/get_news.dart';
import 'package:pingolearn/features/news/presentation/pages/homepage.dart';
import 'package:pingolearn/features/news/presentation/provider/news_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: AppSecrets.apiKey,
    appId: AppSecrets.appId,
    messagingSenderId: 'sendid',
    projectId: AppSecrets.projectId,
    storageBucket: AppSecrets.storageBucket,
  ));
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => AuthentProvider(UserSignUp(AuthRepositoryImpl(
            AuthRemoteDataSourceImpl(FirebaseAuth.instance)))),
      ),
      ChangeNotifierProvider(
        create: (context) => LoginProvider(UserLogin(AuthRepositoryImpl(
            AuthRemoteDataSourceImpl(FirebaseAuth.instance)))),
      ),
      ChangeNotifierProvider(
        create: (context) => NewsProvider(
            getNews: GetNews(NewsRepositoryImpl(ApiRemoteDatasourceImpl()))),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'News App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const Homepage();
              } else {
                return const LoginPage();
              }
            }));
  }
}
