
create or replace package pkg_emp is
	gv_current_empNo NUMBER;

		procedure p_setCurrentEmpNo ( i_empNo NUMBER );
		function f_getCurrentEmpNo return NUMBER;
		procedure p_giveRaise ( i_pcnt NUMBER );

	end;

create or replace package body pkg_emp is
	gv_LOGUSER_tx VARCHAR2(256);

		procedure p_ValidateUser is 
		begin
			if gv_LOGUSER_tx is null then
				raise_application_error ( -20999, 'no valid user!' );
			else
				if gv_LOGUSER_tx not like 'SCOTT%' then
					raise_application_error ( -20999, 'no enough privileges!' );
				end if;
			end if;
		end;

		procedure p_setCurrentEmpNo ( i_empno NUMBER ) is
			begin
				gv_LOGUSER_tx:=user||'|'||sys_context('userenv', 'ip_address');
				gv_current_empno:=i_empNo;
			end;

		function f_getCurrentEmpno return NUMBER is
			begin
				return gv_current_empNo;
			end;

		procedure p_giveRaise ( i__pcnt NUMBER ) is
			begin
				p_ValidateUser;

				update emp
				set sal= sal*(i_pcnt/100)+sal
				where empno = f_getCurrentEmpno;
			end;
	end;