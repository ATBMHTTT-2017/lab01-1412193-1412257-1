--HR
create or replace function vpd_chitieu_duan1
(p_schema varchar2,
p_obj varchar2)
return varchar2
is
user varchar2(100);
usersx number;
begin
  user := SYS_CONTEXT('USERENV','SESSION_USER');
  if ('SYS_CONTEXT(''USERENV'',''ISDBA'')' = 'TRUE') then
    return '';
  else
	select count(*) into usersx from PHONGBAN where TRUONGPHONG = user;
	if (usersx > 0) then
		return '';
	end if;
	select count(*) into usersx from CHINHANH where TRUONGCHINHANH = user;
	if (usersx > 0) then
		return '';
	end if;
   	return 'EXISTS(select * from DUAN where MADA = DUAN and TRUONGDA = ' || user || ')';

  end if;
end vpd_chitieu_duan1;

BEGIN
  SYS.DBMS_RLS.ADD_POLICY(
  	object_schema   => 'hr',
  	object_name     => 'CHITIEU',
  	policy_name     => 'chitieu_vpd1s',
  	function_schema => 'hr',
  	policy_function => 'vpd_chitieu_duan1',
	statement_types => 'SELECT, UPDATE');
 END;
