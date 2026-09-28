select d.dept_name,
    e.emp_name,
    e.salary
from employee e 
join  department d 
on d.dept_id = e.dept_id where
e.salary>(
    select avg(e1.salary)
    from employee e1 
    where e1.dept_id = e.dept_id 
)
and e.dept_id in(
    select dept_id
    from employee
    group by dept_id
    having count(*) >= 3
)