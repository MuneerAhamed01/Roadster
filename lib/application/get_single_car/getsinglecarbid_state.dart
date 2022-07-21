part of 'getsinglecarbid_cubit.dart';

@immutable
abstract class GetsinglecarbidState {}

class GetsinglecarbidInitial extends GetsinglecarbidState {}

class GetsinglecarbidOnGet extends GetsinglecarbidState {
 final String carImageLink;

  GetsinglecarbidOnGet(this.carImageLink);
}
