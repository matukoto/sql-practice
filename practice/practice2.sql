-- 問題2
/**
都道府県別 入院率を算出
入院率の高い順
**/
select
  p.pf_code as 都道府県コード,
  p.pf_name as 都道府県名,
  round(
    (
      CAST(h.inp_yes AS REAL) / (h.inp_yes + h.inp_no + h.unidentified)
    ) * 100,
    1
  ) as 入院率
from
  prefecture p
  inner join hospitalization h on p.pf_code = h.pf_code
order by
  入院率 desc,
  都道府県コード asc;
