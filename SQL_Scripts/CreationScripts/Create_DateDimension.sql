-- date dimension scipt is from here: http://blog.jontav.com/post/9380766884/calendar-tables-are-incredibly-useful-in-sql very much much appreciated
declare @start_dt as date = '1/1/2020';		-- Date from which the calendar table will be created.
declare @end_dt as date = '1/1/2021';		-- Calendar table will be created up to this date (not including).

declare @dates as table (
 date_id date primary key,
 date_year smallint,
 date_month tinyint,
 date_day tinyint,
 weekday_id tinyint,
 weekday_nm varchar(10),
 month_nm varchar(10),
 day_of_year smallint,
 quarter_id tinyint,
 first_day_of_month date,
 last_day_of_month date,
 start_dts datetime,
 end_dts datetime
)

while @start_dt < @end_dt
begin
	insert into @dates(
		date_id, date_year, date_month, date_day, 
		weekday_id, weekday_nm, month_nm, day_of_year, quarter_id, 
		first_day_of_month, last_day_of_month, 
		start_dts, end_dts
	)	
	values(
		@start_dt, year(@start_dt), month(@start_dt), day(@start_dt), 
		datepart(weekday, @start_dt), datename(weekday, @start_dt), datename(month, @start_dt), datepart(dayofyear, @start_dt), datepart(quarter, @start_dt),
		dateadd(day,-(day(@start_dt)-1),@start_dt), dateadd(day,-(day(dateadd(month,1,@start_dt))),dateadd(month,1,@start_dt)), 
		cast(@start_dt as datetime), dateadd(second,-1,cast(dateadd(day, 1, @start_dt) as datetime))
	)
	set @start_dt = dateadd(day, 1, @start_dt)
end

select * into [wow].[Dim.Dates]
from @dates d
