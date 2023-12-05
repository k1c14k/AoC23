insert into scratchcard_count
select id
from scratchcard;

call process_cards();

select sum(count)
from scratchcard_count;