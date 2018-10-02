/* Procedimiento para manejar la tabla Usuarios*/
DELIMITER $$
CREATE PROCEDURE proc_usuarios (IN opcion TINYINT(1), IN usuario VARCHAR(30))
BEGIN
    /* Inserta si el usuario no existe */
    IF (opcion=1) THEN
        IF (SELECT COUNT(1) 
            FROM Usuarios a
            WHERE a.nom_usuario = usuario)=0 
        THEN
            INSERT INTO Usuarios(nom_usuario)
                VALUES(usuario);
            SELECT 0 AS estado, CONCAT(usuario, ' ha sido agregado') AS mensaje;
        ELSE
            SELECT 1 AS estado, CONCAT(usuario, ' ya se encuentra registrado') AS mensaje;
        END IF;
        

    /* Elimina usuario */
    ELSEIF(opcion=2) THEN
        DELETE FROM Usuarios
        WHERE nom_usuario = usuario;
        SELECT 0 AS estado, CONCAT(usuario, ' ha sido eliminado') AS mensaje;

    /* Consulta usuario */
    ELSEIF(opcion=3) THEN
        IF( SELECT COUNT(1)
            FROM Usuarios
            WHERE nom_usuario = usuario)>0 
        THEN
            SELECT 0 AS estado, CONCAT(usuario, ' ya se encuentra registrado') AS mensaje;
        ELSE
            SELECT 1 AS estado, CONCAT(usuario, ' no se encuentra registrado') AS mensaje;
        END IF;

    /* Consulta tabla Usuarios */
    ELSEIF (opcion=4) THEN
        IF( SELECT COUNT(1)
            FROM Usuarios)>0
        THEN
            SELECT 0 AS estado,
                'Ok' AS mensaje,
                nom_usuario
            FROM Usuarios;
        ELSE
            SELECT 1 AS estado, 'No hay registros en la tabla Usuarios' AS mensaje;
        END IF;
    END IF;
END$$