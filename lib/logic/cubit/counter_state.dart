part of 'counter_cubit.dart';

class CounterState {
  int counterValue;
  bool wasIncremented;

  CounterState({//CounterState'inden br nesne çağrıldığında verilecek değerleri constructor içerisinde giriyoruz
    @required this.counterValue,//kesinlikle girilmesi gerektiği için @required ekliyoruz
    this.wasIncremented,
  });
}
