create table t_logError( 
	error_tx VARCHAR2(4000), 
	date_dt date default sysdate, 
	loggedby_tx VARCHAR2(32) default user);


create or replace function f_get_speed_nr ( i_distance_nr NUMBER, i_timeSec_nr NUMBER)
	return NUMBER
	is
	v_out_nr NUMBER;
	begin
		v_out_nr := i_distance_nr/i_timeSec_nr;
		return v_out_nr;
		
		exception
		when ZERO_DIVIDE then
			insert into t_logError(error_t) values 
				('Divide by zero in the F_GET_SPEED_NR');
			return null;
	end;