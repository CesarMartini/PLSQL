declare
  v_pi_nr NUMBER := 3.14;
  function f_getDiff_Nr(i_rad1_nr NUMBER, i_rad2_nr NUMBER)
  return NUMBER is
           v_area1_nr NUMBER;
           v_area2_nr NUMBER;
           v_out_nr NUMBER;
    function f_getArea_Nr(i_rad_nr NUMBER)
    	return NUMBER
    	is
    	begin
    		return v_pi_nr*(i_rad_nr**2);
    		end;

    		begin
    			v_area1_nr := f_getArea_Nr(i_rad1_nr);
    			v_area2_nr := f_getArea_Nr(i_rad2_nr);
    			v_out_nr := v_area1_nr - v_area2_nr;
    	return v_out_nr;
    	end;

--testing

begin
	DBMS_OUTPUT.put_line('Diff between 6 and 4 '|| f_getDiff_Nr(6,4));
end;