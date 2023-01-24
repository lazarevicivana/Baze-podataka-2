CREATE OR REPLACE VIEW popular_workers(id_kozmeticara,ime_kozmeticara,prezime_kozmeticara,salon,broj_termina) AS
select r.MBR,r.IME,r.PRZ,s.NAZIV, COUNT(v.KOZMETICAR_MBR) AS broj_termina
from RADNIK r
join VRSI v ON r.MBR = v.KOZMETICAR_MBR
join TERMIN t ON v.TERMIN_ID = t.ID
join KLIJENT k ON t.KLIJENT_ID = k.ID
join KOZMETICKI_SALON s ON r.MBF = s.MBF
group by r.MBR,r.IME, r.PRZ, s.NAZIV
order by broj_termina DESC;