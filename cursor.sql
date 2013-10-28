declare
	cursor c_countemp is 
		select count(*), sum(sal)
			from emp;

	v_count_nr NUMBER;
	v_sum_nr NUMBER;
begin
	open c_countemp;
	fetch c_countemp into v_count_nr, v_sum_nr;
	close c_countemp;

	DBMS_OUTPUT.put_line('number of emps is '||v_count_nr);
	DBMS_OUTPUT.put_line('sum of emp salaries is '||v_sum_nr);
end;


-- by using record type
declare
	cursor c_countemp is
		select count(*), sum(sal) from emp;
	type rt_testRecType is record (v_count_nr NUMBER, v_sum_nr NUMBER);
	r_testRec rt_testRecType;
begin
	open c_countemp;
	fetch c_countemp into r_testRec;
	close c_countemp;
	DBMS_OUTPUT.put_line('number of emps is '||r_testRec.v_count_nr);
	DBMS_OUTPUT.put_line('sum of emp salaries is '||r_testRec.v_sum_nr);
end;

-- by using %ROWTYPE
declare
	cursor c_countEmps is
		select count(*) count_nr, sum(sal) sum_nr from emp;
	r_testRec c_countEmps%ROWTYPE;
begin
	open c_countEmps;
	fetch c_countEmps into r_testRec;
	close c_countEmps;
	DBMS_OUTPUT.put_line('number of emps is '||r_testRec.count_nr);
	DBMS_OUTPUT.put_line('sum of emp salaries is '||r_testRec.sum_nr);
end;