declare
	v_main_nr NUMBER;
begin
	for main_c in 0..5
	loop
	v_main_nr := main_c * 5
		for inner_c in 1..4
		loop
			DBMS_OUTPUT.put_line(v_main_nr);
		end loop;
	end loop;
end;



declare
	v_current_nr NUMBER;
begin
	v_current_nr := 0
	loop
		for inner_c in 1..4
			loop
				DBMS_OUTPUT.put_line(v_current_nr);
			end loop;
		v_current_nr := v_current_nr+5
		exit when v_current_nr>25;
	end loop;
end;



begin
	for main_c in reverse 1..3
	loop
		DBMS_OUTPUT.put_line(main_c);
	end loop;
end;