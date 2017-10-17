DELIMITER $$

DROP PROCEDURE IF EXISTS pik $$


CREATE

    -- PROCEDURE `pubs10`.`pik`(a int,b int)
	PROCEDURE `pubs10`.`pik`()
    BEGIN
	
	-- declare c int default 0;	-- 定义内存变量c为int类型，默认为0
	-- set c=a+b;	-- 给内存变量赋值
	-- select c;	-- 返回c值
	
	
	-- DECLARE c INT DEFAULT 0;	-- 定义内存变量c为int类型，默认为0
	-- if a>b then	-- 如果a>b
	-- set c=a;	-- 把a赋给c
	-- elseif a<b; then	-- 如果a<b
	-- set c=b;		-- 把b赋给c
	-- ELSEIF 			-- 如果a=b
	-- SET c=a+b;		-- 把a+b值赋给c
	-- end if;
	-- SELECT c;		-- 返回c的值
	
	
	 DECLARE c INT DEFAULT 0;
	 DECLARE i INT DEFAULT 1;
	-- aa:loop
	-- 	if(i>100) then
	-- 	leave aa;
	-- end if;
	-- 	set c=c+i;
	-- 	set i=i+1;
	-- end loop;
	
	
	WHILE i<100 DO
		SET c=c+i;
		SET i=i+1;
	END WHILE;
	
		SELECT c;
	
    END$$

DELIMITER ;