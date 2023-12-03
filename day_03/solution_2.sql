select sum(gr) from (select symbol_id, gear_ratio(symbol_id) as gr
from (select symbol_id, count(part_id) as part_count from part_star group by symbol_id) as sipc
where sipc.part_count = 2) as sig;