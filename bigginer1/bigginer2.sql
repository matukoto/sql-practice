/**
顧客名(CUST_NAME)の先頭が「株式会社」、または、顧客名に「商事」の文字が含まれているデータ

顧客コード → CODE
顧客名 → NAME
顧客担当者名 → USER_NAME

顧客コードの降順
**/
select
  cust_code as CODE,
  cust_name as NAME,
  cust_user_name as USER_NAME,
from
  CUSTOMER
where
  cust_name like '株式会社%'
  or cust_name like '%商事%'
order by
  CODE desc;
