class Usuario{
  String nombre;
  String urlFoto;
  String email;

  Usuario({
    this.nombre,
    this.urlFoto,
    this.email
  });

  /*
   *getters
   *puse g a cada metodo para evitar confucion
   */
  String get gnombreUsuario{
    return nombre;
  }

  String get gfotoUsuario{
    return urlFoto;
  }

  String get gemailUsuario{
    return email;
  }

  /*
  *setters
  *puse s a cada metodo para no confundirme :v
  */
  set snombreUsuario(String nombre){
    this.nombre = nombre;
  }

  set sfotoUsuario(String urlFoto){
    this.urlFoto = urlFoto;
  }

  set semailUsuario(String email){
    this.email = email;
  }

}