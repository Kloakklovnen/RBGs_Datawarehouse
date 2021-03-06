/****** Object:  StoredProcedure [dbo].[RBGS_ETLFlow]    Script Date: 17-05-2020 13:29:58 ******/
DROP PROCEDURE [dbo].[RBGS_ETLFlow]
GO
/****** Object:  StoredProcedure [dbo].[RBGS_ETLFlow]    Script Date: 17-05-2020 13:29:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[RBGS_ETLFlow]

AS
BEGIN



--  truncate table  [wow].[Extract_Reflex]
    truncate table  [wow].[staging_RBG_DW]
    truncate table [wow].[RBGs_DW]
   


-- staging:
INSERT INTO  [wow].[staging_RBG_DW]
select dateadd(S,  [Timestamp], '1970-01-01') AS TimeStamp,
   [Map]
      ,[duration]
      ,[victory]
      ,[KillingBlows]
      ,[HonorKills]
      ,[Deaths]
      ,[Damage]
      ,[Healing]
      ,[Honor]
      ,[RatingChange]
      ,[MMR]
      ,[EnemyMMR]
      ,[specialization]
	   
  FROM [wow].[Extract_Reflex]
   where israted = 'true' 


--update for dims:    --MUST HANDLE LATER FOR SEVERAL CLASSES, WITH SIMILAR SPEC-NAME, DEPENDING ON HOW REFLEX HANDLES/NAMES THAT SITUATION.
update [wow].[staging_RBG_DW]
set specialization = '0'
where specialization = 'Balance'

update [wow].[staging_RBG_DW]
set specialization = '1'
where specialization = 'Feral'

update [wow].[staging_RBG_DW]
set specialization = '2'
where specialization = 'Guardian'

update [wow].[staging_RBG_DW]
set specialization = '3'
where specialization = 'Restoration'

update [wow].[staging_RBG_DW]
set TimeStamp = dateadd(hh,4,timestamp) --Reflex using Unix time, the conversion almost fits. Adding 4 hours though, to fit Copenhagen time. Haven't dived in to summer/winter time, etc :/


   
-- DW:
INSERT INTO [wow].[RBGs_DW]
  select 
       HASHBYTES('SHA2_256', concat( [Timestamp], damage, healing))  AS ID -- unique ID derived from timestamp, damage + healing done. In theory 2 poeple from 1 game can have identical stats, or somthing if DW is extended in future, but not really possible.
		, convert(date, TimeStamp ) as Date 
		,convert(time, TimeStamp ) as Time
		,[Map]
      ,[duration]
      
      ,[victory]
	  ,[specialization]
	  ,[RatingChange]
	  ,[MMR]
      ,[EnemyMMR]
	  ,[Damage]
      ,[Healing]
	  ,[Deaths]   
      ,[KillingBlows]
      ,[HonorKills]
      ,[Honor]
  FROM  [wow].[staging_RBG_DW]  




END
GO
