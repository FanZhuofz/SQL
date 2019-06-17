Oracle通过SqlPlus生成AWR报告

1、打开sqlplus：输入用户名：sys as sysdba   口令：******  登录

2、输入 @? /rdbms/admin/awrrpt.sql

3、输入report_type的值  可以输入html

4、输入num_days的值  输入1
选择要生成报告的日期是多少天以前的记录，输入1，则表示要生成今天0点开始到现在之内的某个时间段的报告，输入2，则表示要生成昨天0点开始
到现在的某个时间段的报告，以此类推。缺省记录最近7天。

5、输入begin_snap的值：报告的开始时间(第一行)【Snap Id】

6、输入end_snap的值：报告的结束时间(最后一行)【Snap Id】

7、输入报告的文件名字【report_name的值】test.html
等待，直到出现Peport written to test.html

8、生成成功的报告在C:\app\Me\product\11.2.0\dbhome_1\BIN安装目录下
