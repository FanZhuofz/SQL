DELIMITER $$
DROP PROCEDURE IF EXISTS tidqty_aid $$
CREATE PROCEDURE `pubs`.`tidqty_aid`(aid VARCHAR(20))
    
    BEGIN
	DECLARE n INT DEFAULT 1;
	DECLARE tid VARCHAR(20);
	DECLARE salsum VARCHAR(20);
-- 定义游标1,根据作者编号查出该作者所出版的图书编号（不重复）
	DECLARE curtid CURSOR FOR
		SELECT DISTINCT title_id  FROM titleauthor WHERE au_id = aid;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET n = 0;	-- 游标结束条件
	
	OPEN curtid;
	FETCH curtid INTO tid;	-- 游标遍历的数据放在tid中
	
	DELETE FROM tidqty_aid;
	
	WHILE n=1 DO
	  SELECT SUM(qty) INTO salsum FROM sales WHERE title_id=tid;	-- 根据title_id查询书的销售总量
	  INSERT INTO tidqty_aid VALUES(tid,salsum);
	  FETCH curtid INTO tid;-- 游标遍历的数据放在tid中	
	END WHILE;
	
	SELECT * FROM tidqty_aid;
	CLOSE curtid;
    END$$

DELIMITER ;