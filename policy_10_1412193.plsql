--Tao policy
conn lbacsys/2444@pdborcl
grant select on hr.chitieu to public;
BEGIN
  SA_SYSDBA.CREATE_POLICY(
    policy_name => 'chitieu_policy',
    column_name => 'chitieu_label',
    default_options => 'no_control'
  );

  SA_COMPONENTS.CREATE_LEVEL('chitieu_policy',10,'KNC','Nhay_cam');
  SA_COMPONENTS.CREATE_LEVEL('chitieu_policy',20,'NC','Khong_nhay_cam');
  SA_COMPONENTS.CREATE_LEVEL('chitieu_policy',30,'BM','Bi_mat');
  SA_COMPONENTS.CREATE_COMPARTMENT('chitieu_policy',10,'L','Luong');
  SA_COMPONENTS.CREATE_COMPARTMENT('chitieu_policy',20,'QL','Quan_ly');
  SA_COMPONENTS.CREATE_COMPARTMENT('chitieu_policy',30,'VL','Vat_lieu');
  SA_COMPONENTS.CREATE_GROUP('chitieu_policy',10,'QL','Quan_ly');
  SA_COMPONENTS.CREATE_GROUP('chitieu_policy',20,'NV','Nhan_vien', 'QL');
END;
/

BEGIN
  SA_LABEL_ADMIN.CREATE_LABEL('chitieu_policy',1000,'KNC:L:QL');
  SA_LABEL_ADMIN.CREATE_LABEL('chitieu_policy',1001,'NC:L:QL');
  SA_LABEL_ADMIN.CREATE_LABEL('chitieu_policy',1002,'BM:L:QL');
  SA_LABEL_ADMIN.CREATE_LABEL('chitieu_policy',1003,'KNC:QL:QL');
  SA_LABEL_ADMIN.CREATE_LABEL('chitieu_policy',1004,'NC:QL:QL');
  SA_LABEL_ADMIN.CREATE_LABEL('chitieu_policy',1005,'BM:QL:QL');
  SA_LABEL_ADMIN.CREATE_LABEL('chitieu_policy',1006,'KNC:VL:QL');
  SA_LABEL_ADMIN.CREATE_LABEL('chitieu_policy',1007,'NC:VL:QL');
  SA_LABEL_ADMIN.CREATE_LABEL('chitieu_policy',1008,'BM:VL:QL');
  SA_LABEL_ADMIN.CREATE_LABEL('chitieu_policy',1009,'KNC:L:NV');
  SA_LABEL_ADMIN.CREATE_LABEL('chitieu_policy',1010,'NC:L:NV');
  SA_LABEL_ADMIN.CREATE_LABEL('chitieu_policy',1011,'BM:L:NV');
  SA_LABEL_ADMIN.CREATE_LABEL('chitieu_policy',1012,'KNC:QL:NV');
  SA_LABEL_ADMIN.CREATE_LABEL('chitieu_policy',1013,'NC:QL:NV');
  SA_LABEL_ADMIN.CREATE_LABEL('chitieu_policy',1014,'BM:QL:NV');
  SA_LABEL_ADMIN.CREATE_LABEL('chitieu_policy',1015,'KNC:VL:NV');
  SA_LABEL_ADMIN.CREATE_LABEL('chitieu_policy',1016,'NC:VL:NV');
  SA_LABEL_ADMIN.CREATE_LABEL('chitieu_policy',1017,'BM:VL:NV');
end;
/

begin
  SA_POLICY_ADMIN.APPLY_TABLE_POLICY(
    policy_name       => 'chitieu_policy',
    schema_name       => 'hr',
    table_name        => 'chitieu',
    table_options  => null,
    label_function => null,
    predicate         => null
  );
end;
/

--Gan nhan nguoi dung
--Gia su NV 1412193 la nhan vien NC:L,QL:NV
EXECUTE SA_USER_ADMIN.SET_USER_LABELS('CHITIEU_POLICY','1412193','NC:L,QL:NV');
EXECUTE SA_USER_ADMIN.SET_USER_LABELS('CHITIEU_POLICY','1412257','BM:VL:NV');
--1412258 la quan ly, duoc xem het chi tieu cua nhan vien
EXECUTE SA_USER_ADMIN.SET_USER_LABELS('CHITIEU_POLICY','1412173','NC:L,QL,VL:QL');

--Gan nhan cho data
UPDATE hr.chitieu SET chitieu_label = CHAR_TO_LABEL('CHITIEU_POLICY','KNC:QL:NV') where machitieu='CT001';
UPDATE hr.chitieu SET chitieu_label = CHAR_TO_LABEL('CHITIEU_POLICY','BM:VL:NV') where machitieu='CT002';
UPDATE hr.chitieu SET chitieu_label = CHAR_TO_LABEL('CHITIEU_POLICY','KNC:QL:QL') where machitieu='CT003';
UPDATE hr.chitieu SET chitieu_label = CHAR_TO_LABEL('CHITIEU_POLICY','BM:VL:QL') where machitieu='CT004';
UPDATE hr.chitieu SET chitieu_label = CHAR_TO_LABEL('CHITIEU_POLICY','NC:L:NV') where machitieu='CT005';
COMMIT;

--Apply policy
BEGIN
SA_SYSDBA.ALTER_POLICY(
  policy_name => 'CHITIEU_POLICY',
  default_options => 'read_control, label_default'
);
SA_POLICY_ADMIN.REMOVE_TABLE_POLICY(
  policy_name => 'CHITIEU_POLICY',
  schema_name => 'hr',
  table_name  => 'chitieu',
  drop_column => false
);
SA_POLICY_ADMIN.APPLY_TABLE_POLICY(
  policy_name => 'CHITIEU_POLICY',
  schema_name => 'hr',
  table_name  => 'chitieu'
);
END;
