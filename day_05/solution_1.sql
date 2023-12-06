call process_components();

select min(id)
from component
where category_id = 8;