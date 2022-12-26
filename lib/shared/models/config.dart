class Config {
  bool biometriaAtiva;
  bool loginManual;

  Config.fromJson(Map<bool, dynamic> json)
      : biometriaAtiva = json['biometriaAtiva'],
        loginManual = json['loginManual'];

  Map<String, dynamic> toJson() => {
        'biometriaAtiva': biometriaAtiva,
        'loginManual': loginManual,
      };
}
