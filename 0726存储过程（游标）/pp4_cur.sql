DELIMITER $$
USE `pubs10`$$
DROP PROCEDURE IF EXISTS `pp4_cur`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `pp4_cur`()
    BEGIN
	DECLARE aid VARCHAR(20);
	DECLARE tid VARCHAR(20);
	DECLARE dan INT DEFAULT 0;	-- 定义单著dan为int型初始值为0
	DECLARE he INT DEFAULT 0;	-- 定义合著he为int型初始值为0
	DECLARE tidcnt INT DEFAULT 0;	-- 定义tidcnt用于单著、合著tidcnt=1为单著，大于1为合著
	DECLARE n INT DEFAULT 1;
	DECLARE cur CURSOR FOR
	 SELECT DISTINCT au_id FROM AUTHORS;	-- 定义游标1 
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET n = 0;	-- 游标结束条件
	DELETE FROM cntauthors;
	OPEN cur;
	FETCH cur INTO aid;	
	WHILE n=1 DO
	   BEGIN
	     DECLARE cur1 CURSOR FOR
	      SELECT title_id FROM titleauthor WHERE au_id=aid;	-- 定义游标2
	      OPEN cur1;
	      FETCH cur1 INTO tid;
	   --   INSERT INTO tttt VALUES(tid);
	      WHILE n=1 DO
	  --        insert into tttt values(tid);
	  -- 	    FETCH cur1 INTO tid;
		SELECT COUNT(1) INTO tidcnt FROM titleauthor WHERE title_id=tid;
		IF tidcnt=1 THEN	-- 如果title_id的数量tidcnt=1
		  SET dan=dan+1;	-- 单著+1
	        ELSEIF tidcnt>1 THEN	-- 如果title_id的数量tidcnt>1
		  SET he=he+1;	-- 合著+1
	        END IF;
	        FETCH cur1 INTO tid;
	      END WHILE;
	      INSERT INTO cntauthors VALUES (aid,dan+he,dan,he);
	      SET dan=0;
	      SET he=0;
	      SET n=1;
	      FETCH cur INTO aid;
	      CLOSE cur1;
	   END;
	END WHILE;
	SELECT * FROM cntauthors;
    END$$
DELIMITER ;
