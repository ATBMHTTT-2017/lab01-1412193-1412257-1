--Gan DBA cho LBACSYS
conn /@pdborcl as sysdba
alter session set "_ORACLE_SCRIPT"=true;
grant dba to lbacsys;

--tao user HR
conn /@pdborcl as sysdba
create user hr identified by hr;
grant create session, create table, unlimited tablespace to hr;

--tao du lieu
conn hr/hr@pdborcl
/* tao du lieu da co o cac cau truoc */

--Tao policy
conn lbacsys/2444@pdborcl
grant select on hr.duan to public;
BEGIN
-- Create OLS Policy
-- Notice that the default_options is set to no_control to disable the policy
-- in order add labels to the existing data items
SA_SYSDBA.CREATE_POLICY(
  policy_name => 'duan_policy',
  column_name => 'duan_label',
  default_options => 'no_control'
);

SA_COMPONENTS.CREATE_LEVEL('duan_policy',10,'BT','Binh_thuong');
SA_COMPONENTS.CREATE_LEVEL('duan_policy',20,'GH','Gioi_han');
SA_COMPONENTS.CREATE_LEVEL('duan_policy',30,'BM','Bi_mat');
SA_COMPONENTS.CREATE_LEVEL('duan_policy',40,'BMC','Bi_mat_cao');
SA_COMPONENTS.CREATE_COMPARTMENT('duan_policy',10,'NS','Nhan_su');
SA_COMPONENTS.CREATE_COMPARTMENT('duan_policy',20,'KT','Ke_toan');
SA_COMPONENTS.CREATE_COMPARTMENT('duan_policy',30,'KH','Ke_hoach');
SA_COMPONENTS.CREATE_GROUP('duan_policy',10,'TPHCM','TP_Ho_Chi_Minh');
SA_COMPONENTS.CREATE_GROUP('duan_policy',20,'HN','Ha_Noi');
SA_COMPONENTS.CREATE_GROUP('duan_policy',30,'DN','Da_Nang');

-- Create data labels
SA_LABEL_ADMIN.CREATE_LABEL('duan_policy',100,'BT:NS:TPHCM');
SA_LABEL_ADMIN.CREATE_LABEL('duan_policy',101,'GH:NS:TPHCM');
SA_LABEL_ADMIN.CREATE_LABEL('duan_policy',102,'BM:NS:TPHCM');
SA_LABEL_ADMIN.CREATE_LABEL('duan_policy',103,'BMC:NS:TPHCM');
SA_LABEL_ADMIN.CREATE_LABEL('duan_policy',104,'BT:KT:TPHCM');
SA_LABEL_ADMIN.CREATE_LABEL('duan_policy',105,'GH:KT:TPHCM');
SA_LABEL_ADMIN.CREATE_LABEL('duan_policy',106,'BM:KT:TPHCM');
SA_LABEL_ADMIN.CREATE_LABEL('duan_policy',107,'BMC:KT:TPHCM');
SA_LABEL_ADMIN.CREATE_LABEL('duan_policy',108,'BT:KH:TPHCM');
SA_LABEL_ADMIN.CREATE_LABEL('duan_policy',109,'GH:KH:TPHCM');
SA_LABEL_ADMIN.CREATE_LABEL('duan_policy',110,'BM:KH:TPHCM');
SA_LABEL_ADMIN.CREATE_LABEL('duan_policy',111,'BMC:KH:TPHCM');
SA_LABEL_ADMIN.CREATE_LABEL('duan_policy',112,'BT:NS:HN');
SA_LABEL_ADMIN.CREATE_LABEL('duan_policy',113,'GH:NS:HN');
SA_LABEL_ADMIN.CREATE_LABEL('duan_policy',114,'BM:NS:HN');
SA_LABEL_ADMIN.CREATE_LABEL('duan_policy',115,'BMC:NS:HN');
SA_LABEL_ADMIN.CREATE_LABEL('duan_policy',116,'BT:KT:HN');
SA_LABEL_ADMIN.CREATE_LABEL('duan_policy',117,'GH:KT:HN');
SA_LABEL_ADMIN.CREATE_LABEL('duan_policy',118,'BM:KT:HN');
SA_LABEL_ADMIN.CREATE_LABEL('duan_policy',119,'BMC:KT:HN');
SA_LABEL_ADMIN.CREATE_LABEL('duan_policy',120,'BT:KH:HN');
SA_LABEL_ADMIN.CREATE_LABEL('duan_policy',121,'GH:KH:HN');
SA_LABEL_ADMIN.CREATE_LABEL('duan_policy',122,'BM:KH:HN');
SA_LABEL_ADMIN.CREATE_LABEL('duan_policy',123,'BMC:KH:HN');
SA_LABEL_ADMIN.CREATE_LABEL('duan_policy',124,'BT:NS:DN');
SA_LABEL_ADMIN.CREATE_LABEL('duan_policy',125,'GH:NS:DN');
SA_LABEL_ADMIN.CREATE_LABEL('duan_policy',126,'BM:NS:DN');
SA_LABEL_ADMIN.CREATE_LABEL('duan_policy',127,'BMC:NS:DN');
SA_LABEL_ADMIN.CREATE_LABEL('duan_policy',128,'BT:KT:DN');
SA_LABEL_ADMIN.CREATE_LABEL('duan_policy',129,'GH:KT:DN');
SA_LABEL_ADMIN.CREATE_LABEL('duan_policy',130,'BM:KT:DN');
SA_LABEL_ADMIN.CREATE_LABEL('duan_policy',131,'BMC:KT:DN');
SA_LABEL_ADMIN.CREATE_LABEL('duan_policy',132,'BT:KH:DN');
SA_LABEL_ADMIN.CREATE_LABEL('duan_policy',133,'GH:KH:DN');
SA_LABEL_ADMIN.CREATE_LABEL('duan_policy',134,'BM:KH:DN');
SA_LABEL_ADMIN.CREATE_LABEL('duan_policy',135,'BMC:KH:DN');
-- Apply access_pol policy on table gov.flight
SA_POLICY_ADMIN.APPLY_TABLE_POLICY(
  policy_name       => 'duan_policy',
  schema_name       => 'hr',
  table_name        => 'duan',
  table_options  => null,
  label_function => null,
  predicate         => null
);
end;
/

-- Add user authorizations (i.e. clearance levels)
--Gan nhan co truong chi nhanh TPHCM 1412193 (CN001)
BEGIN
 SA_USER_ADMIN.SET_LEVELS (
  policy_name   => 'DUAN_POLICY',
  user_name     => '1412193',
  max_level     => 'BMC',
  min_level     => 'BT',
  def_level     => 'BMC',
  row_level     => 'BMC');
 SA_USER_ADMIN.SET_COMPARTMENTS (
  policy_name   => 'DUAN_POLICY',
  user_name     => '1412193',
  read_comps    => 'NS,KT,KH',
  write_comps   => '',
  def_comps     => 'NS,KT,KH',
  row_comps     => '');
 SA_USER_ADMIN.SET_GROUPS (
  policy_name   => 'DUAN_POLICY',
  user_name     => '1412193',
  read_groups   => 'TPHCM',
  write_groups  => '',
  def_groups    => 'TPHCM',
  row_groups    => '');
END;
/
--Gan nhan co truong chi nhanh DN 1412176 (CN002)
BEGIN
 SA_USER_ADMIN.SET_LEVELS (
  policy_name   => 'DUAN_POLICY',
  user_name     => '1412176',
  max_level     => 'BMC',
  min_level     => 'BT',
  def_level     => 'BMC',
  row_level     => 'BMC');
 SA_USER_ADMIN.SET_COMPARTMENTS (
  policy_name   => 'DUAN_POLICY',
  user_name     => '1412176',
  read_comps    => 'NS,KT,KH',
  write_comps   => NULL,
  def_comps     => 'NS,KT,KH',
  row_comps     => NULL);
 SA_USER_ADMIN.SET_GROUPS (
  policy_name   => 'DUAN_POLICY',
  user_name     => '1412176',
  read_groups   => 'DN',
  write_groups  => NULL,
  def_groups    => 'DN',
  row_groups    => NULL);
END;
/
--Gan nhan cho truong chi nhanh HN 1412195 (CN003)
BEGIN
 SA_USER_ADMIN.SET_LEVELS (
  policy_name   => 'DUAN_POLICY',
  user_name     => '1412195',
  max_level     => 'BMC',
  min_level     => 'BT',
  def_level     => 'BMC',
  row_level     => 'BMC');
 SA_USER_ADMIN.SET_COMPARTMENTS (
  policy_name   => 'DUAN_POLICY',
  user_name     => '1412195',
  read_comps    => 'NS,KT,KH',
  write_comps   => NULL,
  def_comps     => 'NS,KT,KH',
  row_comps     => NULL);
 SA_USER_ADMIN.SET_GROUPS (
  policy_name   => 'DUAN_POLICY',
  user_name     => '1412195',
  read_groups   => 'DN,HN,TPHCM',
  write_groups  => NULL,
  def_groups    => 'DN,HN,TPHCM',
  row_groups    => NULL);
END;
/
--Gan nhan cho truong phong PB001 NS (phong Nhan su) 1412200
BEGIN
 SA_USER_ADMIN.SET_LEVELS (
  policy_name   => 'DUAN_POLICY',
  user_name     => '1412200',
  max_level     => 'BMC',
  min_level     => 'BT',
  def_level     => 'BMC',
  row_level     => 'BMC');
 SA_USER_ADMIN.SET_COMPARTMENTS (
  policy_name   => 'DUAN_POLICY',
  user_name     => '1412200',
  read_comps    => 'NS,KT,KH',
  write_comps   => 'NS',
  def_comps     => 'NS,KT,KH',
  row_comps     => 'NS');
 SA_USER_ADMIN.SET_GROUPS (
  policy_name   => 'DUAN_POLICY',
  user_name     => '1412200',
  read_groups   => 'TPHCM', --TPHCM vi 1412200 la chi nhanh TPHCM
  write_groups  => 'TPHCM',
  def_groups    => 'TPHCM',
  row_groups    => 'TPHCM');
END;
/
--Gan nhan cho truong phong PB002 KT (ke toan) 1412001
BEGIN
 SA_USER_ADMIN.SET_LEVELS (
  policy_name   => 'DUAN_POLICY',
  user_name     => '1412201',
  max_level     => 'BMC',
  min_level     => 'BT',
  def_level     => 'BMC',
  row_level     => 'BMC');
 SA_USER_ADMIN.SET_COMPARTMENTS (
  policy_name   => 'DUAN_POLICY',
  user_name     => '1412201',
  read_comps    => 'NS,KT,KH',
  write_comps   => 'KT',
  def_comps     => 'NS,KT,KH',
  row_comps     => 'KT');
 SA_USER_ADMIN.SET_GROUPS (
  policy_name   => 'DUAN_POLICY',
  user_name     => '1412201',
  read_groups   => 'TPHCM',
  write_groups  => 'TPHCM',
  def_groups    => 'TPHCM',
  row_groups    => 'TPHCM');
END;
/
--Gan nhan cho truong phong PB002 KH (ke hoach) 1412002
BEGIN
 SA_USER_ADMIN.SET_LEVELS (
  policy_name   => 'DUAN_POLICY',
  user_name     => '1412202',
  max_level     => 'BMC',
  min_level     => 'BT',
  def_level     => 'BMC',
  row_level     => 'BMC');
 SA_USER_ADMIN.SET_COMPARTMENTS (
  policy_name   => 'DUAN_POLICY',
  user_name     => '1412202',
  read_comps    => 'NS,KT,KH',
  write_comps   => 'KH',
  def_comps     => 'NS,KT,KH',
  row_comps     => 'KH');
 SA_USER_ADMIN.SET_GROUPS (
  policy_name   => 'DUAN_POLICY',
  user_name     => '1412202',
  read_groups   => 'TPHCM',
  write_groups  => 'TPHCM',
  def_groups    => 'TPHCM',
  row_groups    => 'TPHCM');
END;
/

--Gan nhan cho nhan vien 1412210 BT:NS:TPHCM (Gia su da thoa man bang Phan cong)
--Gan nhan cho nhan vien 1412211 GH:KT:TPHCM
--Gan nhan cho nhan vien 1412212 BT:NS:TPHCM
--Gan nhan cho nhan vien 1412213 BM:KH:TPHCM
BEGIN
  SA_USER_ADMIN.SET_USER_LABELS('duan_policy','1412210','BT:NS:TPHCM');
  SA_USER_ADMIN.SET_USER_LABELS('duan_policy','1412211','BMC:KT:TPHCM');
  SA_USER_ADMIN.SET_USER_LABELS('duan_policy','1412212','BM:NS:HN');
  SA_USER_ADMIN.SET_USER_LABELS('duan_policy','1412213','BM:KH:TPHCM');
END;
/

--Gan nhan cho du lieu (tung du an)
--lbacsys
UPDATE hr.duan SET duan_label = CHAR_TO_LABEL('DUAN_POLICY','BT:NS:TPHCM') where mada='DA001';
UPDATE hr.duan SET duan_label = CHAR_TO_LABEL('DUAN_POLICY','GH:KT:TPHCM') where mada='DA002';
UPDATE hr.duan SET duan_label = CHAR_TO_LABEL('DUAN_POLICY','BM:KH:TPHCM') where mada='DA003';
UPDATE hr.duan SET duan_label = CHAR_TO_LABEL('DUAN_POLICY','BMC:NS:HN') where mada='DA004';
UPDATE hr.duan SET duan_label = CHAR_TO_LABEL('DUAN_POLICY','BT:KT:DN') where mada='DA005';
UPDATE hr.duan SET duan_label = CHAR_TO_LABEL('DUAN_POLICY','GH:KT:TPHCM') where mada='DA006';
UPDATE hr.duan SET duan_label = CHAR_TO_LABEL('DUAN_POLICY','BT:NS:TPHCM') where mada='DA007';
UPDATE hr.duan SET duan_label = CHAR_TO_LABEL('DUAN_POLICY','BM:KT:TPHCM') where mada='DA008';
UPDATE hr.duan SET duan_label = CHAR_TO_LABEL('DUAN_POLICY','BT:KH:TPHCM') where mada='DA009';
UPDATE hr.duan SET duan_label = CHAR_TO_LABEL('DUAN_POLICY','BT:NS:HN') where mada='DA010';
UPDATE hr.duan SET duan_label = CHAR_TO_LABEL('DUAN_POLICY','GH:NS:TPHCM') where mada='DA011';
UPDATE hr.duan SET duan_label = CHAR_TO_LABEL('DUAN_POLICY','BM:KT:TPHCM') where mada='DA012';
UPDATE hr.duan SET duan_label = CHAR_TO_LABEL('DUAN_POLICY','BT:KH:TPHCM') where mada='DA013';
COMMIT;

--Apply policy
BEGIN
-- Now we change the policy to enfoce on read by first altering the policy
-- and then removing and applying the policy again
SA_SYSDBA.ALTER_POLICY(
  policy_name => 'duan_policy',
  default_options => 'read_control, label_default'
);
SA_POLICY_ADMIN.REMOVE_TABLE_POLICY(
  policy_name => 'duan_policy',
  schema_name => 'hr',
  table_name  => 'duan',
  drop_column => false
);
SA_POLICY_ADMIN.APPLY_TABLE_POLICY(
  policy_name => 'duan_policy',
  schema_name => 'hr',
  table_name  => 'duan'
);
END;
