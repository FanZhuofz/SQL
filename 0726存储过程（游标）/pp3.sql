DELIMITER $$

USE `pubs10`$$

DROP PROCEDURE IF EXISTS `pp3`$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pp3`(aid VARCHAR(20),var INT)
BEGIN
	DECLARE cnt INT DEFAULT 0;	-- 定义书总数cnt为int类型初始值为0
	DECLARE dan INT DEFAULT 0;	-- 定义单著dan为int型初始值为0
	DECLARE he INT DEFAULT 0;	-- 定义合著he为int型初始值为0
	DECLARE i INT DEFAULT 1;	-- 定义变量i为int类型初始值为1
	DECLARE tid VARCHAR(10);	-- 定义tid为title_id
	DECLARE tidcnt INT DEFAULT 0;	-- 定义tidcnt用于单著、合著tidcnt=1为单著，大于1为合著
	
	DROP TABLE IF EXISTS linshi;	-- 如果临时表存在，删除临时表
	-- 如果传递的var=0，则删除cntauthors表中数据
	IF var=0 THEN
	    DELETE FROM cntauthors;
	END IF;
	SET @a=0;
	CREATE TABLE linshi SELECT @a:=@a+1 AS xh,title_id FROM titleauthor WHERE au_id=aid;	-- 按au_id查询对应的title_id，并编号，将查询结果存储到linshi表中
	
	SELECT COUNT(1) INTO cnt FROM linshi;	-- 查询linshi表中的数据总数，将查询结果存储到变量cnt中
	-- select * from cnt
	
	WHILE i<=cnt DO 		-- 如果自增变量i小于cnt(临时表中的数据总数)执行循环语句
	
	     SELECT title_id INTO tid FROM linshi WHERE xh=i;	
	     SELECT COUNT(1) INTO tidcnt FROM titleauthor WHERE title_id=tid;
		-- 以上两句相当于SELECT COUNT(1) FROM titleauthor WHERE title_id='bu2075'（bu2075相当于xh）
	     
	     IF tidcnt=1 THEN	-- 如果title_id的数量tidcnt=1
		SET dan=dan+1;	-- 单著+1
	     ELSEIF(tidcnt>1) THEN	-- 如果title_id的数量tidcnt>1
		SET he=he+1;	-- 合著+1
	     END IF;
		SET i=i+1;	-- i自加1
	END WHILE;	-- 不满足while条件，退出循环
	INSERT INTO cntauthors VALUES (aid,cnt,dan,he);
	IF var=0 THEN
	    SELECT * FROM cntauthors;	-- 显示作者编号au_id、书籍总数cnt、单著dan、合著he
	END IF;
	
    END$$

DELIMITER ;