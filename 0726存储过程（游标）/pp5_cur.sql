DELIMITER $$

DROP PROCEDURE IF EXISTS pp5_cur $$


CREATE PROCEDURE `pubs10`.`pp5_cur`()
 
    BEGIN
	DECLARE n INT DEFAULT 1;	-- 定义n为游标结束条件 n=0游标结束；n=1执行循环
	DECLARE tid VARCHAR(20);	-- 定义tid来存放游标遍历的title_id
	DECLARE i INT DEFAULT 1;	-- 定义i来自增序号
	
	DECLARE cur CURSOR FOR
	 SELECT DISTINCT title_id FROM titleauthor;		-- 定义游标cur，查询titleauthor表里的title_id
	
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET n = 0;	-- 将结束标志n=0绑定到游标
	
	DELETE FROM linshi;	-- 清空linshi表
	OPEN cur;		-- 打开游标
	-- 当n=0时执行
	FETCH cur INTO tid;	-- 将游标遍历的数据存放到tid【tid是一个字段，要是多个字段得先定义，后写在into后面用逗号隔开，例：FETCH cur INTO tid,a,b;】
	
	-- 开始循环，将数据遍历插入到linshi表
	WHILE n=1 DO
		INSERT INTO linshi VALUES(i,tid);
		SET i=i+1;		-- 变量i（序号）自增
		FETCH cur INTO tid;	-- 将游标遍历的数据存放到tid
	END WHILE;			-- 结束循环
	CLOSE cur;			-- 关闭游标
	SELECT * FROM linshi;		-- 查询显示linshi表
    END$$

DELIMITER ;