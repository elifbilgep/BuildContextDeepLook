part of 'internet_cubit.dart';

@immutable
abstract class InternetState {
} //bu sınıftan nesne üretmeyeceğimiz, sadece extend edeceğimiz için abstract tanımlıyoruz

class InternetLoading extends InternetState {
} //ve internet'in olabileceği durumlara göre statelerini tanımlıyoruz=> internet durumu öğreniliyor, bağlı,bağlı değil

class InternetConnected extends InternetState {
  final ConnectionType
      connectionType; 
//enum olarak belirlediğimiz connection typeları eğer internet connected ise IntrnetConnect state'i InternetCubit'de emit olurken hangi tipte olduğu da girilsin diye required olarak istedik.

  InternetConnected({@required this.connectionType});
}

class InternetDisconnected extends InternetState {}
