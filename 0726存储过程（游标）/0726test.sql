-- 按图书编号，查询某一本图书的销量
-- 查询某作者所有出版图的销量，按图书编号，销量2个字段
-- 查询某一个图书类型销量的情况，显示图书编号，作者名字和销量，按销量降序显示


-- --------------------------------------qty_tid存储结构------------------------------------------------
-- 按图书编号，查询某一本图书的销量
SELECT SUM(qty) FROM sales WHERE title_id='BU1032';

CALL qty_tid('BU1032');



-- --------------------------------------tidqty_aid存储结构---------------------------------------------
-- 查询某作者所有出版图书的销量，按图书编号，销量2个字段
SELECT qty FROM sales WHERE title_id 

SELECT DISTINCT title_id FROM titles;

SELECT title_id,qty FROM sales s WHERE s.title_id IN(
 SELECT DISTINCT s.title_id FROM titleauthor ti WHERE ti.au_id IN(
   SELECT ti.au_id FROM AUTHORS au WHERE au.au_id='213-46-8915'
 )
) ;
-- ---------思路：1、根据作者编号查出该作者所出版的图书编号（不重复）
-- -------------- 2、根据图书编号查出图书销售数量

-- 以下纯属想多-----------------------------
-- 根据作者id查出图书编号
SELECT au_id FROM AUTHORS WHERE au_id='213-46-8915'
SELECT title_id FROM titleauthor WHERE au_id='213-46-8915'
SELECT DISTINCT title_id FROM sales WHERE title_id='bu1032'
SELECT title_id FROM sales WHERE title_id='bu2075'

-- 根据图书编号查出销售总量
SELECT qty FROM sales WHERE title_id='bu1032'
SELECT qty FROM sales WHERE title_id='bu2075'

-- 根据图书编号查出销售总量（不重复）
SELECT SUM(qty) salcnt FROM sales WHERE title_id='bu1032'
SELECT SUM(qty) salcnt FROM sales WHERE title_id='bu2075'

-- 根据作者编号查出该作者所出版的图书编号（不重复）
SELECT DISTINCT s.title_id FROM sales s WHERE s.title_id IN(
 SELECT ti.title_id FROM titleauthor ti WHERE ti.au_id IN(
   SELECT au.au_id FROM AUTHORS au WHERE au.au_id='213-46-8915'
 )
)

-- 根据图书编号查询销售总量（不重复）
SELECT SUM(qty) salcnt FROM sales WHERE title_id=''


SELECT title_id,qty FROM sales s WHERE s.title_id IN(
 SELECT s.title_id FROM titleauthor ti WHERE ti.au_id IN(
   SELECT ti.au_id FROM AUTHORS au WHERE au.au_id='213-46-8915'
 )
) ;
-- -----------------------这两句足矣----------------------------------------------------
SELECT DISTINCT title_id  FROM titleauthor WHERE au_id='213-46-8915';  -- 根据作者编号查出该作者所出版的图书编号（不重复）

SELECT SUM(qty) salcnt FROM sales WHERE title_id='bu1032'  -- 根据图书编号查询销售总量（不重复）

CALL tidqty_aid('213-46-8915');


-- ----------------------------------tidauqty_aid存储结构----------------------------------------------------

-- 查询某一个图书类型销量的情况，显示图书编号，作者名字和销量，按销量降序显示

-- 查询某图书类型的销量
SELECT SUM(qty) FROM sales WHERE title_id IN (
 SELECT title_id FROM titles WHERE TYPE='business'
)

-- 1、根据图书编号查出该图书类型的销售情况
-- 2、根据图书编号查出作者名字



SELECT title_id,qty FROM sales WHERE title_id IN (
 SELECT title_id FROM titles WHERE TYPE='business' 
) ORDER BY qty DESC;

SELECT au_lname FROM AUTHORS WHERE au_id IN(
 SELECT au_id FROM titleauthor WHERE title_id='TC7777')
