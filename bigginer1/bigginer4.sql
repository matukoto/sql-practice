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
  detail.item_code as CODE,
  detail.item_name as NAME,
  sum(detail.D_SUM_QTY) as SUM_QTY
from
  orders o
  inner join warehouse w on o.wh_code = w.wh_code
  and w.wh_name = '浦和倉庫'
  inner join (
    select
      d.order_no,
      d.line_no,
      d.item_code,
      i.item_name,
      sum(d.order_qty) as D_SUM_QTY
    from
      orders_dtl d
      left outer join item i on d.item_code = i.item_code
    group by
      d.order_no,
      d.line_no,
      d.item_code,
      i.item_name
  ) as detail on detail.order_no = o.order_no
group by
  CODE,
  NAME
having
  SUM_QTY >= 50
order by
  SUM_QTY desc,
  CODE desc;

select
  d.order_no,
  d.line_no,
  d.item_code,
  i.item_name,
  sum(d.order_qty) as D_SUM_QTY
from
  orders_dtl d
  left outer join item i on d.item_code = i.item_code
group by
  d.order_no,
  d.line_no,
  d.item_code,
  i.item_name
