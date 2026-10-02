BEGIN TRAN

UPDATE [dbo].[DatabaseLog] SET DatabaseUser='toto'
 WHERE [DatabaseLogID] =2 -- Lock Acquis sur la ligne 2

 UPDATE [dbo].[DatabaseLog] SET DatabaseUser='tata'
 WHERE [DatabaseLogID] =1 -- Attente sur la ligne 1