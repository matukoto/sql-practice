/**
売上データ(SALES)、売上データ明細(SALES_DTL)より、売上日(SALES_DATE)が2024年4月1日から2024年4月10日までのデータの出荷状況を表示
売上数量(SALES_QTY)に対して、実際に出荷された数量が出荷数量(DELIVERED_QTY)に設定される仕組みとなっている。

出荷状況は、売上データ明細の明細単位に下記の条件で判断して設定すること。
出荷数量がゼロ → '未出荷'
出荷数量がゼロ以外で、売上数量 > 出荷数量 → '一部出荷'
売上数量 = 出荷数量 → '出荷済'


売上日 → SAL_DATE
売上データの売上番号 → NO
商品コード → ITEM_CODE
売上数量 → SAL_QTY
出荷数量 → DEL_QTY
出荷状況 → SHIP_STS

売上日の降順
売上データの売上番号の昇順
商品コードの昇順
**/
select
  n.sales_date as SAL_DATE,
  n.sales_no as NO,
  d.item_code as ITEM_CODE,
  d.sales_qty as SAL_QTY,
  d.delivered_qty as DEL_QTY,
  case
    when d.delivered_qty = 0 then '未出荷'
    when d.sales_qty > d.delivered_qty then '一部出荷'
    when d.sales_qty = d.delivered_qty then '出荷済'
  end as SHIP_STS
from
  sales n
  inner join sales_dtl d on n.sales_no = d.sales_no
where
  n.sales_date between '2024-04-01' and '2024-04-10'
order by
  SAL_DATE desc,
  n.sales_no asc,
  ITEM_CODE asc;
