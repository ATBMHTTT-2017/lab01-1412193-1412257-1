-- HR
create or replace function vpd_chitieu_hidden_sotien1
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
		return 'EXISTS(select * from PHONGBAN , DUAN where DUAN = MADA and MAPHONG = PHONGCHUTRI and TRUONGPHONG = ' || user || ')';
	end if;
    	return '';
  end if;
end  vpd_chitieu_hidden_sotien1;

--gan chinh sach vpd
BEGIN
  SYS.DBMS_RLS.ADD_POLICY(
  	object_schema   => 'hr',
  	object_name     => 'CHITIEU',
  	policy_name     => 'chitieu_vpd2s',
  	function_schema => 'hr',
  	policy_function => 'vpd_chitieu_hidden_sotien1',
	sec_relevant_cols       => 'SOTIEN',
 	sec_relevant_cols_opt   => DBMS_RLS.ALL_ROWS);
 END;
