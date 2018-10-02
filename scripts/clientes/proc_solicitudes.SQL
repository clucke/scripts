/* Procedimiento para agregar solicitudes */
DELIMITER $$
CREATE PROCEDURE proc_solicitudes (
    IN opcion TINYINT(1),
    IN usuario VARCHAR(30), 
    IN edad TINYINT(3), 
    IN tarjeta TINYINT(1),
    IN plazo TINYINT(2),
    IN interes TINYINT(3),
    IN solicitado INT,
    IN total INT
)
BEGIN
    /* Agrega solicitud */
    IF (opcion=1) THEN
        INSERT INTO Solicitudes(nom_usuario,num_edad,flg_tarjeta,num_plazo,interes,solicitado,total)
            VALUES(usuario,edad,tarjeta,plazo,interes,solicitado,total);
        SELECT 0 AS estado, 'Solicitud agregada' AS mensaje;

    /* Elimina solicitudes del usuario */
    ELSEIF (opcion=2) THEN
        DELETE FROM Solicitudes
        WHERE nom_usuario = usuario;
        SELECT 0 AS estado, CONCAT('Solicitudes de ',usuario,' han sido eliminadas') AS mensaje;

    /* Consulta solicitudes con historial */
    ELSEIF (opcion=3) THEN
        IF( SELECT COUNT(1)
            FROM Solicitudes
            WHERE nom_usuario = usuario
            AND clv_aceptado<>'P')>0 
        THEN
            SELECT 0 AS estado,
                'Ok' AS mensaje,
                a.num_edad, 
                a.flg_tarjeta,
                a.num_plazo,
                a.interes,
                a.solicitado,
                a.total,
                a.clv_aceptado
            FROM Solicitudes a
            WHERE nom_usuario = usuario
            AND a.clv_aceptado<>'P';
        ELSE
            SELECT 1 AS estado, CONCAT(usuario, ' no cuenta con historial') AS mensaje;
        END IF;
    
    /* Consulta solicitudes pendientes */
    ELSEIF (opcion=4) THEN
        IF( SELECT COUNT(1)
            FROM Solicitudes
            WHERE nom_usuario = usuario
            AND clv_aceptado='P')>0 
        THEN
            SELECT 0 AS estado,
                'Ok' AS mensaje,
                a.num_edad, 
                a.flg_tarjeta,
                a.num_plazo,
                a.interes,
                a.solicitado,
                a.total,
                a.clv_aceptado
            FROM Solicitudes a
            WHERE nom_usuario = usuario
            AND a.clv_aceptado='P';
        ELSE
            SELECT 1 AS estado, CONCAT(usuario, ' no cuenta con solicitudes pendientes') AS mensaje;
        END IF;

    /* Actualizacion de solicitudes */
    ELSEIF (opcion=5) THEN
        IF( SELECT COUNT(1)
            FROM Solicitudes
            WHERE nom_usuario = usuario 
            AND num_edad = edad 
            AND flg_tarjeta = tarjeta
            AND num_plazo = plazo
            AND interes = interes
            AND solicitado = solicitado
            AND total = total
            AND clv_aceptado='P')>0
        THEN
            UPDATE Solicitudes
            SET clv_aceptado=IF((num_edad>=20 AND flg_tarjeta=1),'A','R')
            WHERE nom_usuario = usuario
            AND num_edad = edad 
            AND flg_tarjeta = tarjeta
            AND num_plazo = plazo
            AND interes = interes
            AND solicitado = solicitado
            AND total = total
            AND clv_aceptado='P';
            SELECT 0 AS estado, CONCAT('Se ha actualizado la solicitud pendiente de ',usuario) AS mensaje;
        ELSE
            SELECT 1 AS estado, CONCAT(usuario, ' no cuenta con solicitudes pendientes') AS mensaje;
        END IF;

    /* Consulta tabla Solicitudes */
    ELSEIF (opcion=6) THEN
        IF( SELECT COUNT(1)
            FROM Solicitudes)>0
        THEN
            SELECT 0 AS estado,
                'Ok' AS mensaje,
                a.num_edad, 
                a.flg_tarjeta,
                a.num_plazo,
                a.interes,
                a.solicitado,
                a.total,
                a.clv_aceptado
            FROM Solicitudes a;
        ELSE
            SELECT 1 AS estado, 'No hay registros en la tabla Solicitudes' AS mensaje;
        END IF;
    END IF;
END$$