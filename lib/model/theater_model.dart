part of 'models.dart';

class Theater extends Equatable {
  final String name;
  final String location;
  final int price;

  Theater({this.name, this.location, this.price});

  @override
  List<Object> get props => [name, location, price];
}

List<Theater> dummyTheaters = [
  Theater(
      name: "Daya Grand Square CGV",
      location: "Jl. Perintis Kemerdekaan KM. 14",
      price: 30000),
  Theater(
      name: "Mall Phinisi Point Cinepolis",
      location: "Jl. Metro Tj Bunga No.2, Panambungan",
      price: 40000),
  Theater(
      name: "Panakkukang XXI",
      location: "Mall Panakkukang, Jl. Pengayoman",
      price: 35000),
  Theater(
      name: "TSM Premiere Makassar",
      location: "Jl. HM Dg Patompo Metro Tanjung Bunga",
      price: 50000)
];
