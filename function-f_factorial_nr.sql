create or replace function f_factorial_nr ( i_nr NUMBER )
	return NUMBER
	is
	begin
		if sign(i_nr)=-1 or abs(i_nr)!=i_nr
		then
			return null;
		else
			if i_nr = 1
			then
				return 1;
			else
				return i_nr*f_factorial_nr(i_nr-1);
			end if;
		end if;
	end;