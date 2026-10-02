
CREATE OR ALTER   PROCEDURE [dbo].[SauvegardeBDD]
 @DatabaseName SYSNAME = N'Ventes'              -- Nom de la base de données
 
 AS
 
 BEGIN 
	DECLARE @BackupFolder NVARCHAR(400) = N'C:\Backups'
       -- Dossier de destination (doit se terminer par unanti-slash)
	DECLARE @Timestamp NVARCHAR(50);
	DECLARE @BackupPath NVARCHAR(500);
	DECLARE @Sql NVARCHAR(MAX);

	-- 1. Générer l'horodatage au format YYYYMMDD_HHMMSS (ex: 20260930_085350)
	-- SELECT FORMAT(GETDATE(), 'yyyyMMdd_HHmmss')
	SET @Timestamp = FORMAT(GETDATE(), 'yyyyMMdd_HHmmss');

	-- 2. Construire le chemin complet du fichier de sauvegarde avec l'horodatage
	SET @BackupPath = @BackupFolder +'\' + @DatabaseName +'\'+ @DatabaseName +'_' + @Timestamp + N'.bak';

	-- 3. Construire la commande SQL dynamique pour le BACKUP
	SET @Sql = N'BACKUP DATABASE ' + QUOTENAME(@DatabaseName) + 
			   N' TO DISK = N''' + @BackupPath + N'''' +
			   N' WITH NAME = N''' + @DatabaseName + N'-Full Database Backup - ' + @Timestamp + N'''' +
			   N', COMPRESSION, STATS = 10;';

	-- 4. Afficher le script généré pour vérification (optionnel)
	PRINT 'Exécution de la commande : ' + @Sql;

	-- 5. Exécuter la sauvegarde
	EXEC sp_executesql @Sql;

END


CREATE OR ALTER   PROCEDURE [dbo].[SauvegardeDiffBDD]
 @DatabaseName SYSNAME               -- Nom de la base de données
 
 AS
 
 BEGIN 
	DECLARE @BackupFolder NVARCHAR(400) = N'C:\Backups'
       -- Dossier de destination (doit se terminer par unanti-slash)
	DECLARE @Timestamp NVARCHAR(50);
	DECLARE @BackupPath NVARCHAR(500);
	DECLARE @Sql NVARCHAR(MAX);

	-- 1. Générer l'horodatage au format YYYYMMDD_HHMMSS (ex: 20260930_085350)
	-- SELECT FORMAT(GETDATE(), 'yyyyMMdd_HHmmss')
	SET @Timestamp = FORMAT(GETDATE(), 'yyyyMMdd_HHmmss');

	-- 2. Construire le chemin complet du fichier de sauvegarde avec l'horodatage
	SET @BackupPath = @BackupFolder +'\' + @DatabaseName +'\Diff_'+ @DatabaseName +'_' + @Timestamp + N'.bak';

	-- 3. Construire la commande SQL dynamique pour le BACKUP
	SET @Sql = N'BACKUP DATABASE ' + QUOTENAME(@DatabaseName) + 
			   N' TO DISK = N''' + @BackupPath + N'''' +
			   N' WITH DIFFERENTIAL, NAME = N''' + @DatabaseName + N'-Diff Database Backup - ' + @Timestamp + N'''' +
			   N', COMPRESSION, STATS = 10;';

	-- 4. Afficher le script généré pour vérification (optionnel)
	PRINT 'Exécution de la commande : ' + @Sql;

	-- 5. Exécuter la sauvegarde
	EXEC sp_executesql @Sql;

END

CREATE OR ALTER   PROCEDURE [dbo].[SauvegardeLogBDD]
 @DatabaseName SYSNAME               -- Nom de la base de données
 
 AS
 
 BEGIN 
	DECLARE @BackupFolder NVARCHAR(400) = N'C:\Backups'
       -- Dossier de destination (doit se terminer par unanti-slash)
	DECLARE @Timestamp NVARCHAR(50);
	DECLARE @BackupPath NVARCHAR(500);
	DECLARE @Sql NVARCHAR(MAX);

	-- 1. Générer l'horodatage au format YYYYMMDD_HHMMSS (ex: 20260930_085350)
	-- SELECT FORMAT(GETDATE(), 'yyyyMMdd_HHmmss')
	SET @Timestamp = FORMAT(GETDATE(), 'yyyyMMdd_HHmmss');

	-- 2. Construire le chemin complet du fichier de sauvegarde avec l'horodatage
	SET @BackupPath = @BackupFolder +'\' + @DatabaseName +'\Log_'+ @DatabaseName +'_' + @Timestamp + N'.bak';

	-- 3. Construire la commande SQL dynamique pour le BACKUP
	SET @Sql = N'BACKUP LOG ' + QUOTENAME(@DatabaseName) + 
			   N' TO DISK = N''' + @BackupPath + N'''' +
			   N' WITH  NAME = N''' + @DatabaseName + N'-Log Database Backup - ' + @Timestamp + N'''' +
			   N', COMPRESSION, STATS = 10;';

	-- 4. Afficher le script généré pour vérification (optionnel)
	PRINT 'Exécution de la commande : ' + @Sql;

	-- 5. Exécuter la sauvegarde
	EXEC sp_executesql @Sql;

END


CREATE OR ALTER   PROCEDURE [dbo].[SauvegardeTailLogBDD]
 @DatabaseName SYSNAME               -- Nom de la base de données
 
 AS
 
 BEGIN 
	DECLARE @BackupFolder NVARCHAR(400) = N'C:\Backups'
       -- Dossier de destination (doit se terminer par unanti-slash)
	DECLARE @Timestamp NVARCHAR(50);
	DECLARE @BackupPath NVARCHAR(500);
	DECLARE @Sql NVARCHAR(MAX);

	-- 1. Générer l'horodatage au format YYYYMMDD_HHMMSS (ex: 20260930_085350)
	-- SELECT FORMAT(GETDATE(), 'yyyyMMdd_HHmmss')
	SET @Timestamp = FORMAT(GETDATE(), 'yyyyMMdd_HHmmss');

	-- 2. Construire le chemin complet du fichier de sauvegarde avec l'horodatage
	SET @BackupPath = @BackupFolder +'\' + @DatabaseName +'\TailLog_'+ @DatabaseName +'_' + @Timestamp + N'.bak';

	-- 3. Construire la commande SQL dynamique pour le BACKUP
	SET @Sql = N'BACKUP LOG ' + QUOTENAME(@DatabaseName) + 
			   N' TO DISK = N''' + @BackupPath + N'''' +
			   N' WITH CONTINUE_AFTER_ERROR, NAME = N''' + @DatabaseName + N'-TailLog Database Backup - ' + @Timestamp + N'''' +
			   N', COMPRESSION, STATS = 10;';

	-- 4. Afficher le script généré pour vérification (optionnel)
	PRINT 'Exécution de la commande : ' + @Sql;

	-- 5. Exécuter la sauvegarde
	EXEC sp_executesql @Sql;

END