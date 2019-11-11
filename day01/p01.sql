--查询customers中，cust_name为Wascals的所有信息
select * from customers where cust_name = 'Wascals';
--查询proucts中prod_price为9.99的所有信息
select * from product where prod_price = 9.99;
--查询venders中，vend_name为ACME的vend_address
mysql> select vend_address from vendors  where vend_name = 'ACME';