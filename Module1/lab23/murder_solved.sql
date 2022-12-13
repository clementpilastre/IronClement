select * from crime_scene_report
where city = "SQL City"
and date = 20180115;

-- The first witness lives at the last house on "Northwestern Dr". 
-- The second witness, named Annabel, lives somewhere on "Franklin Ave".

select *, max(address_number) 
from person p
join interview i 
on p.id = i.person_id
where p.address_street_name = "Northwestern Dr"
;

-- I heard a gunshot and then saw a man run out. He had a "Get Fit Now Gym" bag. 
-- The membership number on the bag started with "48Z". Only gold members have those bags. 
-- The man got into a car with a plate that included "H42W".

select *
from person p
join interview i 
on p.id = i.person_id
where p.address_street_name = "Franklin Ave"
and p.name LIKE "Annabel%"
;

-- I saw the murder happen, and I recognized the killer from my gym when I was working out last week on January the 9th.

select *
from person p
join drivers_license dl
on p.license_id = dl.id
where dl.plate_number LIKE "%H42W%"
;

-- 51739	Tushar Chandra	664760	312	Phi St	137882671	664760	21	71	black	black	male	4H42WR	Nissan	Altima
-- 67318	Jeremy Bowers	423327	530	Washington Pl, Apt 3A	871539279	423327	30	70	brown	brown	male	0H42W2	Chevrolet	Spark LS
-- 78193	Maxine Whitely	183779	110	Fisk Rd	137882671	183779	21	65	blue	blonde	female	H42W0X	Toyota	Prius

select *
from get_fit_now_member gf
join person p
on gf.person_id = p.id
where p.id = 51739
or p.id = 67318
or p.id = 78193
;

-- Jeremy Bowers

select *
from interview i
join person p
on i.person_id = p.id
where p.name = 'Jeremy Bowers'
;

-- I was hired by a woman with a lot of money. I don't know her name but I know she's around 5'5" (65") or 5'7" (67"). 
-- She has red hair and she drives a Tesla Model S. I know that she attended the SQL Symphony Concert 3 times in December 2017.

select * from drivers_license dl
join person p
on dl.id = p.license_id
join facebook_event_checkin fec
on p.id = fec.person_id
WHERE height BETWEEN 64 AND 68
and hair_color = 'red'
and car_make = 'Tesla'
and car_model = 'Model S'
;

-- Miranda Priestly	