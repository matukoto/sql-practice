-- 問題1
SELECT
  district_name AS 都道府県名,
  total_amt AS 総人口
FROM
  population
WHERE
  lvl = 2
ORDER BY
  total_amt DESC;

-- 問題2
/**
都道府県別 入院率を算出
入院率の高い順
**/
select
  p.pf_code as 都道府県コード,
  p.pf_name as 都道府県名,
  (
    h.inp_yes / (h.inp_yes + h.inp_no + h.unidentified)
  ) * 100 as 入院率
from
  prefecture p
  inner join hospitalization h
order by
  入院率;
