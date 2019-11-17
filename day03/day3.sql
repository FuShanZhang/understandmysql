drop database day3_homework;
create database day3_homework;
use day3_homework;

CREATE TABLE tb_dept
(
    id       INT(11) PRIMARY KEY,
    name     VARCHAR(22) NOT NULL,
    location VARCHAR(50)
);

CREATE TABLE tb_emp
(
    id     INT(11) PRIMARY KEY,
    name   VARCHAR(25),
    deptId INT(11),
    salary FLOAT
);
-- 修改tb_emp表，创建外键约束，使用tb_dept中的id作为外键，关联deptId。
alter table tb_emp add foreign key (deptid) references tb_dept(id);
-- 使用SHOW CREATE TABLE查看表tb_emp的结构
show create table tb_emp;
-- 建立名为tb_emp1的表，结构和tb_emp一样，直接在建表的时候声明外键关联tb_dept的id
create table tb_emp1( id int(11) not null, name varchar(25), deptid int(11), salary float, PRIMARY KEY (`id`),FOREIGN KEY (`deptId`) REFERENCES `tb_dept` (`id`));
-- 建立名为tb_dept1的表，结构和tb_dept表结构一致，将tb_emp外键删除，关联到tb_dept1上
alter table tb_emp drop foreign key `tb_emp_ibfk_1`;
alter table tb_emp add foreign key (deptid) references tb_dept1(id);

CREATE TABLE fruits
(
    f_id    char(10)      NOT NULL,
    s_id    INT           NOT NULL,
    f_name  char(255)     NOT NULL,
    f_price decimal(8, 2) NOT NULL,
    PRIMARY KEY (f_id)
);

INSERT INTO fruits (f_id, s_id, f_name, f_price)
VALUES ('a1', 101, 'apple', 5.2),
       ('b1', 101, 'blackberry', 10.2),
       ('bs1', 102, 'orange', 11.2),
       ('bs2', 105, 'melon', 8.2),
       ('t1', 102, 'banana', 10.3),
       ('t2', 102, 'grape', 5.3),
       ('o2', 103, 'coconut', 9.2),
       ('c0', 101, 'cherry', 3.2),
       ('a2', 103, 'apricot', 2.2),
       ('l2', 104, 'lemon', 6.4),
       ('b2', 104, 'berry', 7.6),
       ('m1', 106, 'mango', 15.6),
       ('m2', 105, 'xbabay', 2.6),
       ('t4', 107, 'xbababa', 3.6),
       ('m3', 105, 'xxtt', 11.6),
       ('b5', 107, 'xxxx', 3.6);

CREATE TABLE customers
(
    c_id      int       NOT NULL AUTO_INCREMENT,
    c_name    char(50)  NOT NULL,
    c_address char(50)  NULL,
    c_city    char(50)  NULL,
    c_zip     char(10)  NULL,
    c_contact char(50)  NULL,
    c_email   char(255) NULL,
    PRIMARY KEY (c_id)
);

INSERT INTO customers(c_id, c_name, c_address, c_city,
                      c_zip, c_contact, c_email)
VALUES (10001, 'RedHook', '200 Street ', 'Tianjin',
        '300000', 'LiMing', 'LMing@163.com'),
       (10002, 'Stars', '333 Fromage Lane',
        'Dalian', '116000', 'Zhangbo', 'Jerry@hotmail.com'),
       (10003, 'Netbhood', '1 Sunny Place', 'Qingdao', '266000',
        'LuoCong', NULL),
       (10004, 'JOTO', '829 Riverside Drive', 'Haikou',
        '570000', 'YangShan', 'sam@hotmail.com');
SELECT COUNT(*) AS cust_num
FROM customers;

CREATE TABLE orderitems
(
    o_num      int           NOT NULL,
    o_item     int           NOT NULL,
    f_id       char(10)      NOT NULL,
    quantity   int           NOT NULL,
    item_price decimal(8, 2) NOT NULL,
    PRIMARY KEY (o_num, o_item)
);

INSERT INTO orderitems(o_num, o_item, f_id, quantity, item_price)
VALUES (30001, 1, 'a1', 10, 5.2),
       (30001, 2, 'b2', 3, 7.6),
       (30001, 3, 'bs1', 5, 11.2),
       (30001, 4, 'bs2', 15, 9.2),
       (30002, 1, 'b3', 2, 20.0),
       (30003, 1, 'c0', 100, 10),
       (30004, 1, 'o2', 50, 2.50),
       (30005, 1, 'c0', 5, 10),
       (30005, 2, 'b1', 10, 8.99),
       (30005, 3, 'a2', 10, 2.2),
       (30005, 4, 'm1', 5, 14.99);

CREATE TABLE suppliers
(
    s_id   int      NOT NULL AUTO_INCREMENT,
    s_name char(50) NOT NULL,
    s_city char(50) NULL,
    s_zip  char(10) NULL,
    s_call CHAR(50) NOT NULL,
    PRIMARY KEY (s_id)
);

INSERT INTO suppliers(s_id, s_name, s_city, s_zip, s_call)
VALUES (101, 'FastFruit Inc.', 'Tianjin', '300000', '48075'),
       (102, 'LT Supplies', 'Chongqing', '400000', '44333'),
       (103, 'ACME', 'Shanghai', '200000', '90046'),
       (104, 'FNK Inc.', 'Zhongshan', '528437', '11111'),
       (105, 'Good Set', 'Taiyuang', '030000', '22222'),
       (106, 'Just Eat Ours', 'Beijing', '010', '45678'),
       (107, 'DK Inc.', 'Zhengzhou', '450000', '33332');

CREATE TABLE orders
(
    o_num  int      NOT NULL AUTO_INCREMENT,
    o_date datetime NOT NULL,
    c_id   int      NOT NULL,
    PRIMARY KEY (o_num)
);
INSERT INTO orders(o_num, o_date, c_id)
VALUES (30001, '2008-09-01', 10001),
       (30002, '2008-09-12', 10003),
       (30003, '2008-09-30', 10004),
       (30004, '2008-10-03', 10005),
       (30005, '2008-10-08', 10001);
-- 查询供应f_id= ‘a1’的水果供应商提供的其他水果种类，内连接
select * from fruits f inner join fruits f1 on f.s_id = f1.s_id and f.f_id = 'a1';
-- 在customers表和orders表中，查询所有客户，包括没有订单的客户，左连接
select * from customers left join orders on customers.c_id = orders.c_id;
-- 在customers表和orders表中，查询所有订单，包括没有客户的订单，右连接
select * from customers right join orders on customers.c_id = orders.c_id;
-- 在customers表和orders表中，使用INNER JOIN语法查询customers表中ID为10001的客户的订单信息
select * from customers c inner join orders o on c.c_id = o.c_id where c.c_id = 10001;
-- 查询fruits表所有信息附加一列suppliers的供应商名称，使用INNER JOIN语法进行内连接查询，并对查询结果排序
select f.*, s.s_name from fruits f inner join suppliers s on s.s_id = f.s_id order by s.s_name;
-- 查询所有价格小于9的水果的信息，查询s_id等于101和103所有的水果的信息，使用UNION连接查询结果
select f.* from fruits f where f.f_price<9 union select f1.* from fruits f1 where f1.s_id in (101,103);
-- 查询所有价格小于9的水果的信息，查询s_id等于101和103的所有水果的信息，使用UNION ALL连接查询结果
select f.* from fruits f where f.f_price<9 union all select f1.* from fruits f1 where f1.s_id in (101,103);
-- 为orders表取别名o，查询30001订单的下单日期
select o.o_date from orders o where o.o_num = 30001;--多余显示下单时间。
-- 查询fruits表，为f_name取别名fruit_name，f_price取别名fruit_price，为fruits表取别名f1，查询表中f_price < 8的水果的名称
select f1.f_name fruit_name from fruits f1 where f1.f_price<8;
-- 查询suppliers表中字段s_name和s_city，使用CONCAT函数连接这两个字段值，并取列别名为suppliers_title。
select concat(s_name,s_city) suppliers_title from suppliers;

CREATE TABLE student
(
    id         INT(10)     NOT NULL PRIMARY KEY,
    name       VARCHAR(20) NOT NULL,
    sex        VARCHAR(4),
    birth      YEAR,
    department VARCHAR(20),
    address    VARCHAR(50)
);

CREATE TABLE score
(
    id     INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    stu_id INT(10) NOT NULL,
    c_name VARCHAR(20),
    grade  INT(10)
);
INSERT INTO student
VALUES (901, '张老大', '男', 1985, '计算机系', '北京市海淀区');
INSERT INTO student
VALUES (902, '张老二', '男', 1986, '中文系', '北京市昌平区');
INSERT INTO student
VALUES (903, '张三', '女', 1990, '中文系', '湖南省永州市');
INSERT INTO student
VALUES (904, '李四', '男', 1990, '英语系', '辽宁省阜新市');
INSERT INTO student
VALUES (905, '王五', '女', 1991, '英语系', '福建省厦门市');
INSERT INTO student
VALUES (906, '王六', '男', 1988, '计算机系', '湖南省衡阳市');

INSERT INTO score
VALUES (NULL, 901, '计算机', 98);
INSERT INTO score
VALUES (NULL, 901, '英语', 80);
INSERT INTO score
VALUES (NULL, 902, '计算机', 65);
INSERT INTO score
VALUES (NULL, 902, '中文', 88);
INSERT INTO score
VALUES (NULL, 903, '中文', 95);
INSERT INTO score
VALUES (NULL, 904, '计算机', 70);
INSERT INTO score
VALUES (NULL, 904, '英语', 92);
INSERT INTO score
VALUES (NULL, 905, '英语', 94);
INSERT INTO score
VALUES (NULL, 906, '计算机', 90);
INSERT INTO score
VALUES (NULL, 906, '英语', 85);

-- 查询李四的考试科目（c_name）和考试成绩（grade）
select s.c_name,s.grade from student st inner join score s on st.id = s.stu_id where st.name='李四';
-- 查询所有学生的信息和考试信息
select stu.*,s.* from student stu inner join score s where stu.id = s.stu_id;
-- 计算每个学生的总成绩
select stu.name,sum(grade) from student stu inner join score s on stu.id = s.stu_id group by stu.name;
-- 计算每个考试科目的平均成绩
select avg(grade) from score group by c_name;
-- 查询计算机成绩低于95的学生信息
select stu.* from student stu inner join score s on stu.id = s.stu_id where s.c_name = '计算机' and s.grade<95;
-- 查询同时参加计算机和英语考试的学生的信息
select stu1.* from student stu1 ,(select stu_id from score where c_name = '计算机' or c_name = '英语' group by stu_id having count(stu_id)>1) stu2 where  stu1.id = stu2.stu_id;select stu.id from student stu union all select s.stu_id from score s;
-- 查询姓张或者姓王的同学的姓名、院系和考试科目及成绩
select stu.name , stu.department , s.c_name,s.grade from student stu inner join score s on s.stu_id = stu.id where stu.name like '张%' or stu.name like '王';
-- 查询都是湖南的学生的姓名、年龄、院系和考试科目及成绩
select stu.name , year(now()) -stu.birth,stu.department , s.c_name,s.grade from student stu inner join score s on s.stu_id = stu.id where stu.address like '湖南%';

DROP TABLE IF EXISTS `dept`;
CREATE TABLE `dept`
(
    `deptno` int(2) NOT NULL,
    `dname`  varchar(14) DEFAULT NULL,
    `loc`    varchar(13) DEFAULT NULL,
    PRIMARY KEY (`deptno`)
) ;
INSERT INTO `dept`
VALUES (10, 'ACCOUNTING', 'NEW YORK'),
       (20, 'RESEARCH', 'DALLAS'),
       (30, 'SALES', 'CHICAGO'),
       (40, 'OPERATIONS', 'BOSTON'),
       (50, 'HR', 'SY'),
       (60, NULL, 'MARKET');

DROP TABLE IF EXISTS `emp`;
CREATE TABLE `emp`
(
    `empno`    int(4) NOT NULL,
    `ename`    varchar(20)  DEFAULT NULL,
    `job`      varchar(9)   DEFAULT NULL,
    `mgr`      int(4)       DEFAULT NULL,
    `hiredate` date         DEFAULT NULL,
    `sal`      double(7, 2) DEFAULT NULL,
    `comm`     double(7, 2) DEFAULT NULL,
    `deptno`   int(2)       DEFAULT NULL,
    PRIMARY KEY (`empno`)
);

INSERT INTO `emp`
VALUES (7369, 'SMITH', 'CLERK', 7902, '1980-12-17', 800.00, NULL, 20),
       (7499, 'ALLEN', 'SALESMAN', 7698, '1981-02-20', 1600.00, 300.00, 30),
       (7521, 'WARD', 'SALESMAN', 7698, '1981-02-22', 1250.00, 500.00, 30),
       (7566, 'JONES', 'MANAGER', 7839, '1981-04-02', 2975.00, NULL, 20),
       (7654, 'MARTIN', 'SALESMAN', 7698, '1981-09-28', 1250.00, 1400.00, 30),
       (7698, 'BLAKE', 'MANAGER', 7839, '1981-05-01', 2850.00, NULL, 30),
       (7782, 'CLARK', 'MANAGER', 7839, '1981-06-09', 2450.00, NULL, 10),
       (7788, 'SCOTT', 'ANALYST', 7566, '1987-04-19', 3000.00, NULL, 20),
       (7839, 'KING', 'PRESIDENT', NULL, '1981-11-17', 5000.00, NULL, 10),
       (7844, 'TURNER', 'SALESMAN', 7698, '1981-09-08', 1500.00, 0.00, 30),
       (7876, 'ADAMS', 'CLERK', 7788, '1987-05-23', 1100.00, NULL, 20),
       (7900, 'JAMES', 'CLERK', 7698, '1981-12-03', 950.00, NULL, 30),
       (7902, 'FORD', 'ANALYST', 7566, '1981-12-03', 3000.00, NULL, 20),
       (7934, 'MILLER', 'CLERK', 7782, '1982-01-23', 1300.00, NULL, 10);

DROP TABLE IF EXISTS `salgrade`;
CREATE TABLE `salgrade`
(
    `grade` int(11) DEFAULT NULL,
    `losal` int(11) DEFAULT NULL,
    `hisal` int(11) DEFAULT NULL
);
INSERT INTO `salgrade`
VALUES (1, 700, 1200),
       (2, 1201, 1400),
       (3, 1401, 2000),
       (4, 2001, 3000),
       (5, 3001, 9999);

-- 取得每个部门最高薪水的人员名称
select ename,sal from emp where sal in (select max(sal) from emp group by deptno);
-- 哪些人的薪水在部门的平均薪水之上
select t.* from (select * from emp e inner join (select avg(e1.sal) a,e1.deptno edeptno
from emp e1
group by deptno) d_avg 
on d_avg.edeptno = e.deptno ) t where t.sal>t.a;
-- 取得部门中(所有人)平均薪水的等级
SELECT * FROM( SELECT avg( e.sal ) a, e.deptno d FROM emp e GROUP BY e.deptno ) t1,
	salgrade 
WHERE
	a BETWEEN losal 
	AND hisal;
-- 取得部门中(所有人)薪水的平均等级
select deptno,avg(grade) from (select * from emp,salgrade where sal between losal and hisal) a group by deptno;
-- 取得平均薪水最高的部门的编号
select avg(sal) a,deptno from emp group by deptno order by a desc limit 1;
-- 求平均薪水的等级最高的部门的部门名称
select dname from dept inner join (select * from (select deptno,avg(sal) a from emp group by deptno) t1 inner join 
salgrade on (a>=losal and a<=hisal) where grade = (select max(grade) from (select deptno,avg(sal) a from emp group by deptno) t1 inner join 
salgrade on (a>=losal and a<=hisal))) t2 on dept.deptno = t2.deptno;

-- 取得比普通员工的最高薪水还要高的领导人姓名
select distinct e1.ename from emp e1,emp e2 where e1.empno = e2.mgr and e1.sal > (select max(t1.sal) from (select e3.* from emp e3 where empno not in (select distinct e1.empno from emp e1,emp e2 where e1.empno = e2.mgr)) 
t1);
-- 取得每个薪水等级有多少员工
SELECT grade,count(grade) FROM emp t1,
	salgrade 
WHERE
	t1.sal BETWEEN losal 
	AND hisal group by grade;
-- 列出受雇日期早于其直接上级领导的所有员工编号，姓名、部门名称
select e1.* from emp e1,emp e2 where e1.hiredate<e2.hiredate and e1.mgr = e2.empno;
-- 列出部门名称和这些员工信息同时列出那些没有员工的部门
select dept.dname,emp.* from dept left join emp on dept.deptno = emp.deptno;
-- 列出至少有五个员工的部门详细信息
SELECT
	dept.*,count(empno) from dept
	LEFT JOIN emp ON dept.deptno = emp.deptno
GROUP BY
	dept.deptno having count(empno) > 4;
-- 列出所有“CLERK”(办事员)的姓名及其部门名称，部门人数
select  e1.ename, t.dname ,t.cnt from emp e1 inner join (select d.dname dname,count(e.empno) cnt,d.deptno deptno from dept d inner join emp e on d.deptno = e.deptno group by d.deptno) t  on e1.deptno = t.deptno where e1.job = 'clerk';
-- 列出最低薪金大于1500的各种工作及从事此工作的全部雇员人数
select job,count(job) from emp group by job having min(sal) > 1500;
-- 列出部门在“SALES”<销售部>工作的姓名
select e.ename from emp e inner join dept on dept.deptno = e.deptno where dept.dname = 'sales';
-- 列出薪金高于公司平均薪金的所有员工、所在的部门、上级领导、雇员的工资等级
select e1.ename,e1.deptno,e2.ename mname , s.grade from emp e1 left join emp e2 on e1.mgr = e2.empno inner join salgrade s on e1.sal >= losal and e1.sal<=hisal where e1.sal>(select avg(sal) from emp) ;
-- 列出所有与“SCOTT”从事相同工作的所有员工及部门名称
select ename , dname from emp inner join dept on emp.deptno = dept.deptno where job = (select job from emp where ename = 'scott');
-- 列出每个部门工作的员工数量，平均工资、平均服务期限
select count(empno),avg(empno),avg(year(now()) - year(hiredate)) from emp group by deptno;
-- 列出各个部门MANAGER的最低薪金
select min(e2.sal) from emp e1 inner join emp e2 on e1.mgr = e2.empno group by e1.deptno;

