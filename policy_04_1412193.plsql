-- (HR)
create view DUAN_CN as
select maDA, tenDA, kinhphi, tenPhong, tenCN, hoTen, sum(soTien) as Tongchi
from DuAn a, PhongBan b, ChiNhanh c, NhanVien d,
ChiTieu e
where a.phongChuTri = b.maPhong
and b.chiNhanh = c.maCN
and a.TruongDA = d.manv
and a.maDA = e.duAN
group by maDA, tenDA, kinhphi, tenPhong, tenCN, hoTen

grant select on DUAN_CN to GIAMDOC;
grant GIAMDOC on "1412239";
