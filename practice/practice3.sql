/**
2015~2020
人口が増加した都道府県を抽出
人口増加率の小数点以下は四捨五入
表示項目
- PF_CODE → 都道府県コード
- PF_NAME → 都道府県名
- 2015年のTOTAL_AMT → 総人口2015年
- 2020年のTOTAL_AMT → 総人口2020年
- 人口増加率を%で表示(小数点以下は四捨五入) → 人口増加率
表示順
- 人口増加率の降順
- 都道府県コードの昇順
**/
select
  p.pf_code as 都道府県コード,
  p.pf_name as 都道府県名,
  amt2015.total_amt as 総人口2015年,
  amt2020.total_amt as 総人口2020年,
  round(
    (
      CAST(amt2020.total_amt AS REAL) - CAST(amt2015.total_amt AS REAL)
    ) / CAST(amt2015.total_amt AS REAL) * 100,
    0
  ) + 100 as 人口増加率
from
  prefecture p
  inner join popu_transition amt2015 on p.pf_code = amt2015.pf_code
  and amt2015.survey_year = 2015
  inner join popu_transition amt2020 on p.pf_code = amt2020.pf_code
  and amt2020.survey_year = 2020
where
  amt2015.total_amt < amt2020.total_amt
order by
  人口増加率 desc,
  都道府県コード asc;
