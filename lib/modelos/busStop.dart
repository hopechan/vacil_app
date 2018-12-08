class BusStop{
  String id;
  double longitud;
  double latitud;
  String ruta;
  String precio;

  BusStop(
    this.id,
    this.longitud,
    this.latitud,
    this.ruta,
    this.precio
  );

  BusStop.crear(
    this.longitud,
    this.latitud,
    this.ruta,
    this.precio
  );

  BusStop.marcador(
    this.ruta,
    this.precio
  );

  //getters
  String get getId => id;
  double get getLongitud => longitud;
  double get getLatitud => latitud;
  String get getRuta => ruta;
  String get getPrecio => precio;

  Map<String, dynamic> toMap(){
    var map = new Map<String, dynamic>();
    if(id != null){
      map['ID'] = id;
    }
    map['Longitud'] = longitud;
    map['Latitud'] = latitud;
    map['Ruta'] = ruta;
    map['Precio'] = precio;
    return map;
  }

  BusStop.fromMap(Map<String, dynamic> map) {
    this.id = map['ID'];
    this.longitud = map['Longitud'];
    this.latitud = map['Latitud'];
    this.ruta = map['Ruta'];
    this.precio = map['Precio'];
  }
}
