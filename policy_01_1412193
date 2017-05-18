--HR
create or replace function nhanvien_vpd1
(p_schema varchar2,
p_obj varchar2)
return varchar2
is
user varchar2(100);
usersx number;
phongban varchar2(100);
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
	select count(*) into usersx from DUAN where TRUONGDA = user;
	if (usersx > 0) then
		return '';
	end if;
	select maPhog into phongban from NHANVIEN where manv = user;
	return 'maPhog = ' || q'[']'|| phongban || q'[']';
  end if;
end  nhanvien_vpd1;


BEGIN
  SYS.DBMS_RLS.ADD_POLICY(
  	object_schema   => 'hr',
  	object_name     => 'NHANVIEN',
  	policy_name     => 'nhanvien_vpd1s',
  	function_schema => 'hr',
  	policy_function => 'nhanvien_vpd1',
	statement_types => 'SELECT, UPDATE');
 END;


create or replace function nhanvien_vpd2
(p_schema varchar2,
p_obj varchar2)
return varchar2
is
user varchar2(100);
usersx number;
phongban varchar2(100);
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
	select count(*) into usersx from DUAN where TRUONGDA = user;
	if (usersx > 0) then
		return '';
	end if;
	return 'MANV = ' || user;
  end if;
end  nhanvien_vpd2;


BEGIN
  SYS.DBMS_RLS.ADD_POLICY(
  	object_schema   => 'hr',
  	object_name     => 'NHANVIEN',
  	policy_name     => 'nhanvien_vpd2s',
  	function_schema => 'hr',
  	policy_function => 'nhanvien_vpd2',
	sec_relevant_cols       => 'LUONG',
 	sec_relevant_cols_opt   => DBMS_RLS.ALL_ROWS);
 END;
