/**
表示項目は以下とする。(エイリアスを使用し→の項目名とする)

人気順位 → RANK
商品コード → CODE
商品名称 → NAME
おすすめ商品順位 → RCM_RANK
表示順

人気順位の昇順
商品コードの降順
**/
select
  ITEM_POPULAR_RANK as RANK,
  ITEM_CODE as CODE,
  ITEM_NAME as NAME,
  RECOMMEND_ITEM_RANK as RCM_RANK
from
  item
order by
  RANK asc,
  CODE desc;
