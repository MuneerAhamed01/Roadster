import 'package:bloc/bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

part 'location_controller_state.dart';

class LocationControllerCubit extends Cubit<LocationControllerState> {
  LocationControllerCubit() : super(LocationControllerInitial());
  void onPressButton() async {
    emit(LocationControllerOnprossesing());
    try {
      print("comingggggggg");
      final position = await Geolocator.getCurrentPosition();
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      final place = placemarks[1];
      final district = placemarks[1].subAdministrativeArea;
      final address = [
        placemarks[1].name,
        place.subLocality,
        place.locality,
        place.subAdministrativeArea,
        place.administrativeArea,
        place.postalCode
      ];
      emit(LocationControllerOnSucesss(
          district: district!, address: address.join(',')));
    } catch (e) {
      emit(LocationControllerOnError());
    }
  }
}
