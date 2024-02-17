 use production;
select scooterId, 
case 
#when 
#`userLocationAtBookingLat`>= 24.7464554239531
#and 
#`#userLocationAtBookingLat`<= 24.7616023022575
#and 
#`userLocationAtBookingLong`>= 46.6815375210468
#and 
#`userLocationAtBookingLong`<=46.6991726120005
#Then "STC"
when 
`userLocationAtBookingLat`>= 24.3456375663016
and 
`userLocationAtBookingLat`<= 25.3351316485914
and 
`userLocationAtBookingLong`>= 46.0426316998935
and 
`userLocationAtBookingLong`<=47.1549974225497
Then "Riyadh"
when 
`userLocationAtBookingLat`>= 25.9714874799726
and 
`userLocationAtBookingLat`<= 26.655912546767
and 
`userLocationAtBookingLong`>= 49.7199254365956
and 
`userLocationAtBookingLong`<=50.3955846162831
Then  "Dammam"
else "Others"  End  as city_,
TerritoryName

, count(*) as Total_Rides,
#round(sum(2 * 6371 * ASIN(SQRT(
       # POWER(SIN((`userLocationAtDropOffLat` - abs(`userLocationAtBookingLat`)) * pi()/180 / 2), 2) +
      #  COS(`userLocationAtBookingLat` * pi()/180) * COS( `userLocationAtDropOffLat`* pi()/180) *
     #   POWER(SIN((`userLocationAtDropOffLong`- `userLocationAtBookingLong`) * pi()/180 / 2), 2)
    #)))) AS distance_km
    #,
    #round(sum(2 * 6371 * ASIN(SQRT(
     #   POWER(SIN((`userLocationAtDropOffLat` - abs(`userLocationAtBookingLat`)) * pi()/180 / 2), 2) +
      #COS(`userLocationAtBookingLat` * pi()/180) * COS( `userLocationAtDropOffLat`* pi()/180) *
       # POWER(SIN((`userLocationAtDropOffLong`- `userLocationAtBookingLong`) * pi()/180 / 2), 2)
   # ))*1000)) AS distance_Metr
    round(sum(`totalFare`/100),0) as total_Fare
,sum(TIMESTAMPDIFF(MINUTE, FROM_UNIXTIME((`pickUpTime`/1000)), FROM_UNIXTIME((`dropOffTime`/1000)))) as total_minutes
    from TripView
    

where

FROM_UNIXTIME((`pickUpTime`/1000)) >= '2024-01-25 04:00:00'
and FROM_UNIXTIME((`pickUpTime`/1000)) <= '2024-01-26 05:00:00'

#and city_ like "%Ri"

group by scooterId,TerritoryName , city_
order by Total_Rides desc 
