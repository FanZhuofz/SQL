DELIMITER $$

USE `pubs10`$$

DROP PROCEDURE IF EXISTS `pp4`$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pp4`()
BEGIN
    -- 定义变量
	DECLARE cnt INT DEFAULT 0;
	DECLARE i INT DEFAULT 1;
	DECLARE aid VARCHAR(20);
	
    -- 删除linshi_1表，清空cntauthors表
	DROP TABLE IF EXISTS linshi_1;
	DELETE FROM cntauthors;
	
    -- 查询作者总数（不重复），将序号和作者id存储在linshi_1表里
	SET @a=0;
        CREATE TABLE linshi_1 SELECT  @a:=@a+1 AS xh,au_id FROM (SELECT DISTINCT au_id FROM AUTHORS) a;
     -- create table linshi_1 SELECT @a:=@a+1 AS xh,au_id FROM titleauthor GROUP BY au_id; -- 运用group by语句也可以
	-- select * from linshi_1;
	
    -- 查询linshi_1表里的作者总数
	SELECT COUNT(1) INTO cnt FROM linshi_1;
	
    -- 遍历linshi_1表，将作者id赋给pp3()存储结构
	WHILE i<=cnt DO
	  SELECT au_id INTO aid FROM linshi_1 WHERE xh=i;
	  CALL pp3(aid,1);
	  SET i=i+1;
	END WHILE;
	
    -- 查询并显示cntauthors表数据
	SELECT * FROM cntauthors;
    END$$

DELIMITER ;