import 'package:build_cntext_deep/presentation/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logic/cubit/counter_cubit.dart';
import 'logic/cubit/internet_cubit.dart';

void main() {
  runApp(MyApp(
    appRouter: AppRouter(),
    connectivity:
        Connectivity(), // uygulamamız başlar başlamaz connectivity pluginini çağırıp InternetCubit'imize instance'ı yolluyoruz
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  final Connectivity connectivity;

  const MyApp({
    Key key,
    @required this.appRouter,
    @required this.connectivity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      //hem Counter'ın hem de Internet'in cubit'ini kullanacağımız için Multi şeklinde tanımlıyoruz
      providers: [
        BlocProvider<InternetCubit>(
          create: (context) => InternetCubit(connectivity: connectivity),
        ),
        BlocProvider<CounterCubit>(
          create: (context) => CounterCubit(),
        ),
      ], // tüm sayfalarda Cubitlerimin statelerine ulaşmak için MaterialApp'in de üstünde provide ediyoum. Yani Global bir access
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}
