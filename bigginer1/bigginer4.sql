/**

倉庫データ(WAREHOUSE)の倉庫名(WH_NAME)が「浦和倉庫」となっている倉庫コード(WH_CODE)が設定されている受注データ(ORDERS)より、下記の条件で、該当倉庫の売れ筋商品を表示しなさい。
該当する受注データに紐付く受注データ明細(ORDERS_DTL)の受注数量(ORDER_QTY)を商品コード(ITEM_CODE)毎に集計して、集計した数量が50個以上となる商品を表示すること。ただし、商品データ(ITEM)に該当の商品コードが存在しない場合は、商品名称は非表示(NULL)のままとする。

表示項目は以下とする。(エイリアスを使用し→の項目名とする)
受注データ明細の商品コード → CODE
商品名称 → NAME
集計した受注数量 → SUM_QTY

表示順
集計した受注数量の降順
商品コードの降順

**/
select
  d.item_code as CODE,
  i.item_name as NAME,
  sum(d.order_qty) as SUM_QTY
from
  orders_dtl d
  left join orders o using (order_no)
  left join item i using (item_code)
  left join warehouse w using (wh_code)
where
  w.wh_name = '浦和倉庫'
group by
  d.item_code
having
  SUM_QTY >= 50
order by
  SUM_QTY desc,
  CODE desc;
