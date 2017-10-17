CALL pp3('',0);

CALL pp4();


-- 定义游标 【CURSOR FOR游标关键字；游标只使用于select】
  DECLARE cur CURSOR FOR SELECT i FROM test.t;
  
  
  
  -- 定义变量在前面、然后创建游标、创建游标结束条件、将结束标志绑定到游标、然后打开游标
  
  SELECT DISTINCT title_id FROM titleauthor;
  
  CALL pp5_cur();	-- pp5游标练习【查询titleauthor里面所有title_id,放在linshi表中】
  
  
  CALL pp3('213-46-8915',0);
  CALL pp3_cur('213-46-8915',0);	-- 将pp3存储过程改为游标
  
  CALL pp4_cur();
  
  SELECT COUNT(1) INTO tidcnt FROM titleauthor WHERE title_id='PS3333';
  
  DELETE FROM tttt;
  
  DELETE FROM cntauthors;