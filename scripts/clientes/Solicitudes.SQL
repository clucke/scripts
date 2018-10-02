CREATE TABLE Solicitudes(
    num_solicitud INT AUTO_INCREMENT,
    nom_usuario VARCHAR(30) NOT NULL,
    num_edad TINYINT(3) NOT NULL,
    flg_tarjeta TINYINT(1) NOT NULL DEFAULT '0',
    num_plazo TINYINT(2),
    interes TINYINT(3),
    solicitado INT NOT NULL,
    total INT NOT NULL,
    clv_aceptado CHAR(1) NOT NULL DEFAULT 'P',
    PRIMARY KEY(num_solicitud, nom_usuario)
);