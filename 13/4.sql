/**
会員の健康診断結果を記録している健康診断テーブル(HEALTH_CHECKUP)より、会員毎に実施日(CHECKUP_DATE)が直近2回の健康診断結果で、今回の体重(WEIGHT)から前回の体重を減算した結果が、5kg以上変動した会員を表示しなさい。
体重はkg単位で小数第一位まで登録されているものとする。また、変動した体重を算出する際は丸め誤差が発生しないように注意すること。ただし、小数点以下がゼロの場合は整数のみの表示とする。

表示項目は以下とする。(エイリアスを使用し→の項目名とする)

最新の実施日 → CK_DATE
MEMBER_CODE → CODE
LAST_NAMEとFIRST_NAMEを連結して表示 → NAME
変動した体重 → CHG_WT
表示順

変動した体重の降順
MEMBER_CODEの降順
rn = 1が最新
**/
--
with
  hc as (
    select
      MEMBER_CODE,
      WEIGHT,
      CHECKUP_DATE,
      ROW_NUMBER() OVER (
        PARTITION BY
          MEMBER_CODE
        ORDER BY
          CHECKUP_DATE DESC
      ) AS rn
    from
      HEALTH_CHECKUP
    order by
      MEMBER_CODE,
      CHECKUP_DATE
  )
select
  hc1.CHECKUP_DATE as CK_DATE,
  ms.MEMBER_CODE as CODE,
  ms.LAST_NAME || ms.FIRST_NAME as NAME,
  round(hc1.WEIGHT - hc2.WEIGHT, 1) as CHG_WT
from
  MEMBER_MST ms
  left outer join hc hc2 on ms.MEMBER_CODE = hc2.MEMBER_CODE
  and hc2.rn = 2
  left outer join hc hc1 on ms.MEMBER_CODE = hc1.MEMBER_CODE
  and hc1.rn = 1
where
  CHG_WT >= 5
  or CHG_WT <= -5
order by
  CHG_WT desc,
  CODE;
