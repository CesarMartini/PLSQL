create or replace function f_makeAddress_tx(
								i_address_tx VARCHAR2,
								i_city_tx VARCHAR2,
								i_state_tx VARCHAR2,
								i_zip_tx VARCHAR2)
	return VARCHAR2
	is
		e_badZip EXCEPTION;
		pragma EXCEPTION_init(e_badZip, -20900); -- 20999 to 20000
		v_out_tx VARCHAR2(256);
		begin
		p_validateZip(i_zip_tx);
		v_out_tx := i_address_tx ||', '|| i_city_tx ||', '||i_state_tx||', '||i_zip_tx;
		return v_out_tx;
	exception
		when e_badZip then
			return i_zip_tx || ': Invalid zip code.';
	end;

create or replace procedure p_validateZip( i_zipCode_tx VARCHAR2)
	is
		e_tooShort EXCEPTION;
		e_tooLong EXCEPTION;
		e_badZip EXCEPTION;
		pragma EXCEPTION_init(e_badZip, -20901);

		v_tempZip_nr NUMBER;

		begin
			if lenght(i_zipCode_tx)<5 then
				Raise e_tooShort;
			elseif lenght(i_zipCode_tx)>6 then
				Raise e_tooLong;
			end if;

			v_tempZip_nr := to_number(i_zipCode_tx);

		exception
			when e_tooLong then
				insert into t_LogError (error_tx) values('long zip');
				raise e_badZip;
			when e_tooShort then
				insert into t_LogError (error_tx) values('shor zip');
				raise e_badZip;
			when value_error then
				insert into t_LogError (error_tx) values('non-numeric zip');
				raise e_badZip;
		end;