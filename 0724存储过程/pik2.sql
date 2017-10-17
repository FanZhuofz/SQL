DELIMITER $$

DROP PROCEDURE IF EXISTS `pik2`$$

CREATE
    PROCEDURE `pubs10`.`pik2`(s VARCHAR(20))
	
    BEGIN
    
    -- 按au_id查询
	-- select * from authors where au_id=s;
	
	
    -- 按作者名查询出书名
	-- SELECT t.title FROM titles t WHERE t.title_id IN(
	-- 	SELECT ti.title_id FROM titleauthor ti WHERE ti.au_id IN(
	-- 		SELECT au.au_id FROM AUTHORS au WHERE au.au_lname=s
	-- 	)
	-- );
    END$$

DELIMITER ;