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
