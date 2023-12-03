create table if not exists calibration_values
(
    value character varying
);

create or replace view calibration_numbers as
select cast((regexp_match(value, '^[a-z]*([0-9]).*'))[1] ||
            (regexp_match(value, '.*([0-9])[a-z]*'))[1] as decimal) as val
from calibration_values;

select sum(val)
from calibration_numbers;

create or replace function real_number(in_text text) returns character as
$$
declare
    result character;
begin
    case in_text
        when 'one' then result = '1';
        when 'two' then result = '2';
        when 'three' then result = '3';
        when 'four' then result = '4';
        when 'five' then result = '5';
        when 'six' then result = '6';
        when 'seven' then result = '7';
        when 'eight' then result = '8';
        when 'nine' then result = '9';
        else result = in_text;
        end case;
    return result;
end;
$$ language plpgsql;

create or replace view calibration_numbers_pt2 as
select cast(real_number((regexp_match(value, '^[a-z]*?(one|two|three|four|five|six|seven|eight|nine|zero|[0-9]).*'))[1]) ||
            real_number((regexp_match(value, '.*(one|two|three|four|five|six|seven|eight|nine|zero|[0-9])[a-z]*?$'))[1]) as decimal) as val
from calibration_values;

select sum(val) from calibration_numbers_pt2;