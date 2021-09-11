import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {//CounterCubit uygulamanın beyin fonksiyonlarını taşır
  CounterCubit() : super(CounterState(counterValue: 0));// super metodu içerisinde CounterState'in initial değerini atadık

  void increment() => emit(//yeni state counter değeri bir arttırılıp emit edilir
      CounterState(counterValue: state.counterValue + 1, wasIncremented: true));

  void decrement() => emit(CounterState(
      counterValue: state.counterValue - 1, wasIncremented: false));
}
