import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:build_cntext_deep/constants/enums.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  //InternetCubitimizde ise beyin fonksiyonları kullandık.
  final Connectivity connectivity; // connectivity_plus paketini çağırdık
  StreamSubscription
      connectivityStreamSubscription; //Ve cihazdaki interneti dinleyebilmek için bir abonelik başlattık

  InternetCubit({@required this.connectivity}) : super(InternetLoading()) {
    //InternetCubit çağırıldığı an cihazdaki internet sorgulansın diye InternetCubit içersinde Constructor olarak monitorInternet metodunu girdik.
    monitorInternetConnection();
  }

  StreamSubscription<ConnectivityResult> monitorInternetConnection() {
    // bu fonksiyon bize bir StreamSubscription döndürüyor ve bu sayede aslında plugini de StremSubscription ile dinlemiş oluyoruz..
    return connectivityStreamSubscription =
        connectivity.onConnectivityChanged.listen((connectivityResult) {
      // pluginin verdiği cevaplara göre yeni stateler emit ediliyor.
      if (connectivityResult == ConnectivityResult.wifi) {
        emitInternetConnected(ConnectionType.Wifi);
      } else if (connectivityResult == ConnectivityResult.mobile) {
        emitInternetConnected(ConnectionType.Mobile);
      } else if (connectivityResult == ConnectivityResult.none) {
        emitInternetDisconnected();
      }
    });
  }

  void emitInternetConnected(ConnectionType _connectionType) =>
      emit(InternetConnected(connectionType: _connectionType));

  void emitInternetDisconnected() => emit(InternetDisconnected());

  @override
  Future<void> close() {
    connectivityStreamSubscription
        .cancel(); // ve unutmadan stream subscription'ı kapatıyoruz.
    return super.close();
  }
}
