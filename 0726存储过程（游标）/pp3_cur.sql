DELIMITER $$
USE `pubs10`$$
DROP PROCEDURE IF EXISTS `pp3_cur`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `pp3_cur`(aid VARCHAR(20),var INT)
     BEGIN
	DECLARE cnt INT DEFAULT 0;	-- 定义书总数cnt为int类型初始值为0
	DECLARE dan INT DEFAULT 0;	-- 定义单著dan为int型初始值为0
	DECLARE he INT DEFAULT 0;	-- 定义合著he为int型初始值为0
	DECLARE i INT DEFAULT 1;	-- 定义变量i为int类型初始值为1
	DECLARE tid VARCHAR(10);	-- 定义tid为title_id
	DECLARE tidcnt INT DEFAULT 0;	-- 定义tidcnt用于单著、合著tidcnt=1为单著，大于1为合著
	DECLARE n INT DEFAULT 1;	-- 定义n为游标结束条件 n=0游标结束；n=1执行循环
	DECLARE cur CURSOR FOR
	SELECT DISTINCT title_id FROM titleauthor WHERE au_id=aid;		-- 定义游标cur，查询titleauthor表里的title_id
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET n = 0;	-- 将结束标志n=0绑定到游标
	DROP TABLE IF EXISTS linshi;	-- 如果临时表存在，删除临时表
	OPEN cur;		-- 打开游标
	-- 当n=0时执行
	FETCH cur INTO tid;	-- 将游标遍历的数据存放到tid	
	-- 如果传递的var=0，则删除cntauthors表中数据
	IF var=0 THEN
	    DELETE FROM cntauthors;
	END IF;
	WHILE n=1 DO 		-- 如果变量n=1执行循环语句
		
	     SELECT COUNT(1) INTO tidcnt FROM titleauthor WHERE title_id=tid;
		-- 以上两句相当于SELECT COUNT(1) FROM titleauthor WHERE title_id='bu2075'（bu2075相当于xh）
	     
	     IF tidcnt=1 THEN	-- 如果title_id的数量tidcnt=1
		SET dan=dan+1;	-- 单著+1
	     ELSEIF(tidcnt>1) THEN	-- 如果title_id的数量tidcnt>1
		SET he=he+1;	-- 合著+1
	     END IF;
	     FETCH cur INTO tid;	-- 将游标遍历的数据存放到tid
	END WHILE;	-- 不满足while条件，退出循环
	INSERT INTO cntauthors VALUES (aid,dan+he,dan,he);
	IF var=0 THEN
	    SELECT * FROM cntauthors;	-- 显示作者编号au_id、书籍总数cnt、单著dan、合著he
	END IF;
	CLOSE cur;			-- 关闭游标
    END$$
DELIMITER ;