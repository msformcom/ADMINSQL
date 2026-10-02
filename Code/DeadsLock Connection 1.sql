BEGIN TRAN

UPDATE [dbo].[DatabaseLog] SET DatabaseUser='toto'
 WHERE [DatabaseLogID] =1 -- Lock Acquis sur la ligne 1

 UPDATE [dbo].[DatabaseLog] SET DatabaseUser='toto'
 WHERE [DatabaseLogID] =2