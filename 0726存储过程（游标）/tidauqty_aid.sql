DELIMITER $$

USE `pubs`$$

DROP PROCEDURE IF EXISTS `tidauqty_aid`$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tidauqty_aid`(typ VARCHAR(20))
BEGIN
	DECLARE n INT DEFAULT 1;
	DECLARE tid VARCHAR (20);
	DECLARE aid VARCHAR (20);
	DECLARE an VARCHAR (20);
	DECLARE cnt INT DEFAULT 0;
	DECLARE yb_ti CURSOR FOR 
		SELECT DISTINCT title_id FROM titles WHERE TYPE=typ;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET n=0;
	OPEN yb_ti;
	FETCH yb_ti INTO tid;
	
	DELETE FROM linshi;
	WHILE n=1 DO
	BEGIN	
		DECLARE yb_au CURSOR FOR 		
			SELECT au_id FROM titleauthor WHERE title_id=tid;		  
		OPEN yb_au;
		FETCH yb_au INTO aid;
		WHILE n=1 DO
		BEGIN
			DECLARE yb_an CURSOR FOR
				SELECT au_lname FROM  AUTHORS WHERE au_id=aid;
			OPEN yb_an;
			FETCH yb_an INTO an;
			WHILE n=1 DO
				SELECT SUM(qty) INTO cnt FROM sales WHERE title_id=tid;
				INSERT INTO linshi VALUES(tid,an,cnt);
				FETCH yb_an INTO an;
			END WHILE;
			SET n=1;
			FETCH yb_au INTO aid;
		END;			
		END WHILE;
		SET n=1;
		FETCH yb_ti INTO tid;
	END;
	END WHILE;
	SELECT * FROM linshi;
	CLOSE yb_ti;
    END$$

DELIMITER ;