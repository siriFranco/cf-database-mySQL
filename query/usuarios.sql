SELECT * FROM usuarios;

CREATE VIEW prestamos_usuarios_vw AS
SELECT 
	usuarios.usuario_id,
	usuarios.nombre,
    usuarios.email,
    usuarios.username,
    COUNT(usuarios.usuario_id) AS total_prestamos
FROM usuarios
INNER JOIN libros_usuarios ON usuarios.usuario_id = libros_usuarios.usuario_id
	AND libros_usuarios.fecha_creacion >= CURDATE() - INTERVAL 5 DAY
GROUP BY usuarios.usuario_id;

SELECT * FROM prestamos_usuarios_vw WHERE total_prestamos >4;


DESC usuarios;

INSERT INTO usuarios (nombre, apellidos, username, email)
VALUES  ('Eduardo', 'García', 'eduardogpg', 'eduardo@codigofacilito.com'),
        ('Codi1', 'Facilito', 'codigofacilito', 'ayuda@codigofacilito.com'),
        ('Codi2', 'Facilito', 'codigofacilito', 'ayuda@codigofacilito.com'),
        ('Codi3', 'Facilito', 'codigofacilito', 'ayuda@codigofacilito.com');
        
DELETE FROM usuarios WHERE usuario_id IN (7);

UPDATE usuarios SET usuario_id = 4 WHERE usuario_id = 6;

SELECT usuarios.username, libros.titulo FROM usuarios CROSS JOIN libros ORDER BY username DESC;

INSERT INTO libros_usuarios (libro_id, usuario_id) SELECT libro_id, usuario_id FROM usuarios CROSS JOIN libros;

DROP VIEW prestamos_usuarios_vw;