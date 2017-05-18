--(HR)
CREATE OR REPLACE Procedure UpdatePhongBan5d
(
	MP phongban.maPhong%TYPE,
	TP phongban.tenphong%TYPE,
	NNC phongban.ngaynhanchuc%TYPE,
	SNV phongban.sonhanvien%TYPE
)
IS
user varchar2(100);
checking number;
checking1 number;
userx varchar2(100);
BEGIN
	user := SYS_CONTEXT('USERENV','SESSION_USER');
	select count(*) into checking from PHONGBAN where TRUONGPHONG = user  and MAPHONG = MP;

	select count(*) into checking1 from CHINHANH a, PHONGBAN b where a.TRUONGCHINHANH = user and a.MACN = b.CHINHANH and b.MAPHONG =
MP ;
 	IF (checking <= 0 and checking1 <= 0) THEN
		rollback;
		return;
	END IF;
	UPDATE phongban set tenphong = TP, ngaynhanchuc = NNC, sonhanvien = SNV where maPhong = MP;
	commit;
END;


GRANT EXECUTE ON UpdatePhongBan5d TO TRUONGPHONG;
GRANT EXECUTE ON UpdatePhongBan5d TO TRUONGCHINHANH;
