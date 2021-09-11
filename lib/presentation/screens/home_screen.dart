import 'package:build_cntext_deep/constants/enums.dart';
import 'package:build_cntext_deep/logic/cubit/counter_cubit.dart';
import 'package:build_cntext_deep/logic/cubit/internet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title, this.color}) : super(key: key);

  final String title;
  final Color color;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext homeScreenContext) {
    return BlocListener<InternetCubit, InternetState>(
      // bu şekilde iki blok arası iletişimi sağlıyoruz
      listener: (internetCubitListenerContext, state) {
        if (state is InternetConnected &&
            state.connectionType == ConnectionType.Wifi) {
          BlocProvider.of<CounterCubit>(context).increment();
        } else if (state is InternetConnected &&
            state.connectionType == ConnectionType.Mobile) {
          BlocProvider.of<CounterCubit>(context).increment();
        } else if (state is InternetDisconnected) {
          BlocProvider.of<CounterCubit>(context).decrement();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.indigo.shade100,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: widget.color,
          title: Text(
            widget.title,
            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 25),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              BlocBuilder<InternetCubit, InternetState>(
                // Burada ise güncellenen değer yansıtılıyor
                builder: (internetCubitBuilderContext, state) {
                  if (state is InternetConnected &&
                      state.connectionType == ConnectionType.Wifi) {
                    return Text(
                      'Wi-Fi',
                      style: Theme.of(internetCubitBuilderContext)
                          .textTheme
                          .headline3
                          .copyWith(
                            color: Colors.white,
                          ),
                    );
                  } else if (state is InternetConnected &&
                      state.connectionType == ConnectionType.Mobile) {
                    return Text(
                      'Mobile',
                      style: Theme.of(internetCubitBuilderContext)
                          .textTheme
                          .headline3
                          .copyWith(
                            color: Colors.white,
                          ),
                    );
                  } else if (state is InternetDisconnected) {
                    return Text(
                      'Disconnected',
                      style: Theme.of(internetCubitBuilderContext)
                          .textTheme
                          .headline3
                          .copyWith(
                            color: Colors.grey,
                          ),
                    );
                  }
                  return CircularProgressIndicator();
                },
              ),
              BlocConsumer<CounterCubit, CounterState>(
                listener: (counterCubitListenerContext, state) {
                  if (state.wasIncremented == true) {
                    Scaffold.of(counterCubitListenerContext).showSnackBar(
                      SnackBar(
                        content: Text('Incremented!'),
                        duration: Duration(milliseconds: 300),
                      ),
                    );
                  } else if (state.wasIncremented == false) {
                    Scaffold.of(counterCubitListenerContext).showSnackBar(
                      SnackBar(
                        content: Text('Decremented!'),
                        duration: Duration(milliseconds: 300),
                      ),
                    );
                  }
                },
                builder: (counterCubiBuilderContext, state) {
                  return Text(
                    state.counterValue.toString(),
                    style: Theme.of(counterCubiBuilderContext)
                        .textTheme
                        .headline3
                        .copyWith(
                          color: Colors.white,
                        ),
                  );
                },
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    backgroundColor: Colors.indigo,
                    heroTag: Text('${widget.title}'),
                    onPressed: () {
                      BlocProvider.of<CounterCubit>(homeScreenContext)
                          .decrement();
                    },
                    tooltip: 'Decrement',
                    child: Icon(Icons.remove),
                  ),
                  FloatingActionButton(
                    backgroundColor: Colors.indigo,
                    heroTag: Text('${widget.title} 2nd'),
                    onPressed: () {
                      BlocProvider.of<CounterCubit>(homeScreenContext)
                          .increment();
                    },
                    tooltip: 'Increment',
                    child: Icon(Icons.add),
                  ),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              Builder(
                builder: (materialButtonContext) => MaterialButton(
                  color: Colors.indigo.shade200,
                  child: Text(
                    'Second Screen',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.of(materialButtonContext).pushNamed(
                      '/second',
                    );
                  },
                ),
              ),
              SizedBox(
                height: 24,
              ),
              MaterialButton(
                color: Colors.indigo.shade300,
                child: Text(
                  'Third Screen',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(homeScreenContext).pushNamed(
                    '/third',
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
