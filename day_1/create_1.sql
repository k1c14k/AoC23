create table if not exists calibration_values
(
    value character varying
);

create or replace view calibration_numbers as select cast((regexp_match(value, '^[a-z]*([0-9]).*'))[1] || (regexp_match(value, '.*([0-9])[a-z]*'))[1] as decimal) as val from calibration_values;

select sum(val) from calibration_numbers;