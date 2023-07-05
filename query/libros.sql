SELECT * FROM libros;

DESC libros;

ALTER TABLE libros
ADD COLUMN ventas INT DEFAULT 100;

INSERT INTO libros (autor_id, titulo, descripcion, paginas, fecha_publicacion, ventas, stock)
VALUES (2, 'Animal Farm', 'Description of Animal Farm', 200, '2022-01-01', 0, 10);

INSERT INTO libros (autor_id, titulo, descripcion, paginas, fecha_publicacion, ventas, stock)
VALUES (2, 'Homage to Catalonia', 'Description of Homage to Catalonia', 300, '2023-06-15', 0, 15);
