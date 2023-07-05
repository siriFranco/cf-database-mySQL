SELECT * FROM libros_usuarios;

DESC libros_usuarios;

ALTER TABLE libros ADD ventas INT UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE libros ADD stock INT UNSIGNED DEFAULT 10;

INSERT INTO libros_usuarios(libro_id, usuario_id)
VALUES  
		-- (1, 1), (2, 1), (3, 1); 
		(5, 3), (6, 3), (7, 3);

SELECT 
	CONCAT(nombre, " ", apellidos),
    libros_usuarios.libro_id
FROM usuarios
LEFT JOIN libros_usuarios ON usuarios.usuario_id = libros_usuarios.usuario_id;

SELECT 
	CONCAT(nombre, " ", apellidos),
    libros_usuarios.libro_id
FROM libros_usuarios
RIGHT JOIN usuarios ON usuarios.usuario_id = libros_usuarios.usuario_id;

SELECT DISTINCT
	CONCAT(usuarios.nombre, " ", usuarios.apellidos) AS nombre_usuario
FROM usuarios
INNER JOIN libros_usuarios ON usuarios.usuario_id = libros_usuarios.usuario_id
INNER JOIN libros ON libros_usuarios.libro_id = libros.libro_id
INNER JOIN autores ON libros.autor_id = autores.autor_id AND autores.seudonimo;

DELIMITER //
CREATE PROCEDURE prestamo(usuario_id INT, libro_id INT, OUT cantidad INT)
BEGIN
	SET cantidad = (SELECT stock FROM libros WHERE libros.libro_id = libro_id);
    
    IF cantidad > 0 THEN
  INSERT INTO libros_usuarios(libro_id, usuario_id) VALUES(libro_id, usuario_id);
  UPDATE libros SET stock = stock - 1 WHERE libros.libro_id = libro_id;
  
  SET cantidad = cantidad -1;
  
  ELSE
	SELECT 'No es posible realizar el prestamo' AS mensaje_error;
  
  END IF;
END//
DELIMITER ;


DELIMITER // 
CREATE PROCEDURE tipo_lector(usuario_id INT)
BEGIN
	SET @cantidad = (SELECT COUNT(*) FROM libros_usuarios
					WHERE libros_usuarios.usuario_id = usuario_id);
	CASE
		WHEN @cantidad > 20 THEN
			SELECT "Fanatico" AS mensaje;
		WHEN @cantidad > 10 AND @cantidad < 20 THEN
			SELECT "Aficionado" AS mensaje;
       WHEN @cantidad > 5 AND @cantidad < 10 THEN
			SELECT "Promedio" AS mensaje; 
		ELSE 
			SELECT "Nuevo" AS mensaje;
		END CASE;
END//

DELIMITER ;

DELIMITER //
CREATE PROCEDURE libros_azar()
BEGIN 
	SET @iteracion = 0;
    
    REPEAT
   -- WHILE @iteracion < 5 DO
		SELECT libro_id, titulo FROM libros ORDER BY RAND() LIMIT 1;
        SET @iteracion = @iteracion + 1;
    -- END WHILE;
    
    UNTIL @interacion >= 5
    END REPEAT;
END//

DELIMITER ;

SELECT name FROM mysql.proc WHERE db = database() AND type = 'PROCEDURE';

CALL prestamo(3,7);

SELECT * FROM libros_usuarios;

CALL libros_azar();

DROP PROCEDURE libros_azar;

START TRANSACTION;

SET @libro_id = 6, @usuario_id = 3;

UPDATE libros SET stock = stock - 1 WHERE libro_id = @libro_id;
SELECT stock FROM libros WHERE  libro_id = @libro_id;

INSERT INTO libros_usuarios(libro_id, usuario_id) VALUES(@libro_id, @usuario_id);
SELECT * FROM libros_usuarios;

SELECT libro_id FROM libros WHERE libro_id = @libro_id;

COMMIT;

ROLLBACK;

