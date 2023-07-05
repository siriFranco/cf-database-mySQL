SET GLOBAL event_scheduler = ON;

CREATE EVENT insertion_event
ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 1 MINUTE
DO INSERT INTO test VALUES ('Evento 1', NOW());

ON SCHEDULE AT '2018-12-31 12:00:00'

DELIMITER //

CREATE EVENT insertion_event
ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 1 MINUTE
DO
BEGIN
 INSERT INTO test VALUES ('Evento 1', NOW());
 INSERT INTO test VALUES ('Evento 2', NOW());
 INSERT INTO test VALUES ('Evento 3', NOW());
END //

DELIMITER ;

SHOW events\G;

DROP EVENT nombre_evento;

ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 1 MINUTE
ON COMPLETION PRESERVE
...

CREATE EVENT nombre_evento
ON SCHEDULE AT 'fecha de ejeución' 
DO
CALL store_procedure();

CREATE EVENT insertion_event
ON SCHEDULE EVERY 1 MINUTE STARTS '2018-07-07 18:30:00'
DO INSERT INTO test VALUES ('Evento 1', NOW());

CREATE EVENT insertion_event
ON SCHEDULE EVERY 1 MINUTE STARTS '2018-07-07 18:30:00'
ENDS '2018-07-07 19:00:00'
DO INSERT INTO test VALUES ('Evento 1', NOW());

ALTER EVENT nombre_evento
DISABLE;
-- ENABLE;

SET GLOBAL event_scheduler = OFF;

CREATE
    [DEFINER = { user | CURRENT_USER }]
    EVENT
    [IF NOT EXISTS]
    event_name
    ON SCHEDULE schedule
    [ON COMPLETION [NOT] PRESERVE]
    [ENABLE | DISABLE | DISABLE ON SLAVE]
    [COMMENT 'string']
    DO event_body;

schedule:
    AT timestamp [+ INTERVAL interval] ...
  | EVERY interval
    [STARTS timestamp [+ INTERVAL interval] ...]
    [ENDS timestamp [+ INTERVAL interval] ...]

interval:
    quantity {YEAR | QUARTER | MONTH | DAY | HOUR | MINUTE |
              WEEK | SECOND | YEAR_MONTH | DAY_HOUR | DAY_MINUTE |
              DAY_SECOND | HOUR_MINUTE | HOUR_SECOND | MINUTE_SECOND}
              
DELIMITER //
CREATE TRIGGER after_insert_actualizacion_libros
AFTER INSERT ON libros
FOR EACH ROW
BEGIN 
	UPDATE autores SET cantidad_libros = cantidad_libros + 1 WHERE autor_id = NEW.autor_id;
END;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER after_delete_actualizacion_libros
AFTER DELETE ON libros
FOR EACH ROW
BEGIN 
	UPDATE autores SET cantidad_libros = cantidad_libros - 1 WHERE autor_id = OLD.autor_id;
END;
//
DELIMITER ;

SELECT * FROM autores WHERE autor_id = 2;

SELECT libro_id, titulo FROM libros;

DELETE FROM libros WHERE libro_id =9;

DELIMITER //
CREATE TRIGGER after_update_actualizacion_libros
AFTER UPDATE ON libros
FOR EACH ROW
BEGIN
	IF(NEW.autor_id != OLD.autor_id) THEN 
    UPDATE autores SET cantidad_libros = cantidad_libros + 1 WHERE autor_id = NEW.autor_id;
    UPDATE autores SET cantidad_libros = cantidad_libros - 1 WHERE autor_id = OLD.autor_id;
    END IF;
END;
//

UPDATE libros SET autor_id = 1 WHERE libro_id = 7;
UPDATE libros SET autor_id = 6 WHERE libro_id = 7;

SHOW TRIGGERS;

DROP TRIGGER IF EXISTS libreria_cf.after_delete_actualizacion_libros;
