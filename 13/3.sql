/**
ある映画館の座席の予約状況を管理している、座席予約テーブル(SEAT_RESERVE)がある。座席数は、列ID(LINE_ID)がA~Eの5列で各列に1~15まで席番号(SEAT_NO)があり全部で75席で、データも75席分が揃っているものとする。
また、予約されている席は、予約状況(RSV_STATUS)が '1' となっており、予約されていない席は '0' となっている。
この座席予約テーブルから、列ID単位で予約されていない連続した3つの席を探して列IDと先頭の座席番号と3番目の座席番号を表示しなさい。

表示項目は以下とする。(エイリアスを使用し→の項目名とする)

列ID → LINE
先頭の座席番号 → SEAT_F
3番の座席番号 → SEAT_T
表示順

列IDの降順
先頭の座席番号の昇順
**/
with
  abv as (
    select
      line_id,
      seat_no as SEAT_M,
      rsv_status,
      lag (seat_no) over (
        partition by
          line_id
        order by
          line_id,
          seat_no
      ) as SEAT_F,
      lead (seat_no) over (
        partition by
          line_id
        order by
          line_id,
          seat_no
      ) as SEAT_T
    from
      SEAT_RESERVE
    where
      RSV_STATUS = '0'
  )
select
  abv.line_id as LINE,
  abv.SEAT_F as SEAT_F,
  abv.SEAT_T as SEAT_T
from
  abv
where
  abv.SEAT_T abv.SEAT_F = 2
order by
  LINE_ID desc,
  SEAT_F;
