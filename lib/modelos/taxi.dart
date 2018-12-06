class Taxi{
  String key;
  String idTaxista;
  String nombreTaxista;
  String apellidosTaxista;
  String telefono;
  String year;
  String marca;
  String modelo;
  String placa;
  int calificacion;

  Taxi(
    this.idTaxista,
    this.nombreTaxista,
    this.apellidosTaxista,
    this.telefono,
    this.year,
    this.marca,
    this.modelo,
    this.placa,
  );

//constructor para crear un taxi
  Taxi.crear(
    this.nombreTaxista,
    this.apellidosTaxista,
    this.telefono,
    this.year,
    this.marca,
    this.modelo,
    this.placa,
  );

  String get getKey => key;
  String get getIdTaxista => idTaxista;
  String get getNombreTaxista => nombreTaxista;
  String get getApellidosTaxista => apellidosTaxista;
  String get getTelefono => telefono;
  String get getYear => year;
  String get getMarca => marca;
  String get getModelo => modelo;
  String get getPlaca => placa;
  int get getCalificacion => calificacion;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (idTaxista != null) {
      map['IdTaxista'] = idTaxista;
    }
    map['Nombre'] = nombreTaxista;
    map['Apellidos'] = apellidosTaxista;
    map['Telefono'] = telefono;
    map['Año'] = year;
    map['Marca'] = marca;
    map['Modelo'] = modelo;
    map['Placa'] = placa;
    map['Calificacion'] = calificacion;
    return map;
  }

  Taxi.fromMap(Map<String, dynamic> map) {
    this.idTaxista = map['IdTaxista'];
    this.nombreTaxista = map['Nombre'];
    this.apellidosTaxista = map['Apellidos'];
    this.telefono = map['Telefono'];
    this.year = map['Año'];
    this.marca = map['Marca'];
    this.modelo = map['Modelo'];
    this.placa = map['Placa'];
    this.calificacion = map['Calificacion'];
  }
}