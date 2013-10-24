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

-- two declaration with the same name
declare
  function f_getArea_Nr( i_rad_nr IN NUMBER, i_prec_nr IN NUMBER )
    return NUMBER is
    v_pi_nr NUMBER := 3.14;
    begin
      return trunc(v_pi_nr * (i_rad_nr**2), i_prec_nr );
    end;

  function f_getArea_Nr( i_rad_nr IN NUMBER, i_ignore_yn IN VARCHAR2 )
    return NUMBER is
    v_pi_nr NUMBER := 3.14;
    begin
      if i_ignore_yn='Y' and i_rad_nr < 5 then
        return 0;
      else
        return v_pi_nr * (i_rad_nr**2);
      end if;
    end;

begin
  DBMS_OUTPUT.put_line('Area (r=3): ' || f_getArea_Nr(3,1));
  DBMS_OUTPUT.put_line('Area (r=3): ' || f_getArea_Nr(3,'N'));
end;