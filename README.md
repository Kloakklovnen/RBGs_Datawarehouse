# RBGs_Datawarehouse
Scripts for creating a data warehouse for the RBGs done in World of Warcraft, via the data collected from the addon REFlex
Major thanks to those creating the addon; https://github.com/AcidWeb/REFlex !

During downtime waiting in qeues for RBGs, I made some scripts in order to make a data warehouse. My intention was mostly to see at which points during the week I make the most points in RBGs, using BI tools that are free, or practically free. My theory is early evening and mid day weekends. Anyway, I don't have a time-dimension to manage the clock during the day, but I have made a date dimension, spec dimension, etc, to see other relevant stuff. 
Im pushing it here, in case others find it interesting.

# Current state:
As it is now, it's in a state of proof of concept. My spec dimension only contains specs for prist and druid, fx. As all data comes in .csv format from REFlex, and I will never manage to maintain more than 1 character at a time, I don't know how REFlex output reacts to people having a holy priest and holy pala, fx. 

Input from others will be appreciated. Alternatively I will add stuff myself, without testing. You have been warned.

# Whats needed, or stuff I don't know yet:

Examples of .csv files, where a player has multiple characters, preferably where names of specs overlap, like 'holy' something.
Perhaps opinions in my grouping of maps. I hope it makes sense.
If playing on mulitple characters, is it a single file that comes from REFlex, or one per char? In that case, the truncation needs rethinking.
Complete dimension for all specs, and a way to handle overlapping names in specs.
Proper frontend work on the visuals/stats, so it's easy to make different reports.

# HOW-TO:

My base is Azure and Microsoft land, so the SQL scripts are exported to various SQL versions, 2008r2, Azure SQL DB, etc. In time, I will upload version to fit MySQL, PostgreSQL and SQLite. Contributions are very much welcome, so everyone who have different kind of servers running can go a head without issues.

To use this, you need data exported from the REFlex addon, into an extract table in a database. I think I will add ARM templates, as I use Azure data factory to run this.

Create tables and schema from creation script. The date dimension contains the year 2020 but you can truncate it, and run the script called Create_DateDimension.sql if you want other periods. 

Run the ETL_flow_SP_\*.sql script when you have imported data from REFlex to the extract table.

Connect to the data from PowerBI (its free using the local client, and you can avoid creating a user) or Quicksight from AWS, that -as I remember- is free for the first GB which is way enough for RBG data.

Finally, make your visualizations and analyse the statistics.

# Isn't it overkill to involve a database and tables, etc, for some fairly small amount of data delivered in a .csv file?

It most like is. But as i suck at modeling data in PowerBI i took the long way, and got a few functional stats to show. If someone can use the dimensions, or similar, and just make a .pbix that accepts the .csv from REFlex addon, that would be nice.

# So no good functional .pbix are available, the backend is the only really working thing.

Indeed. As stated above, I suck at the front end part, and untill I can pull favors in a few months time, things will stay mostly the same, unless someone assists on that part. 

That was a hint.

# Your stats are shit.

I know, but being healer was emergency situations, and balance was pure peer pressure.
