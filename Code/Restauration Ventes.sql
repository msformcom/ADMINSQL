USE [master]

-- Avant de restaurer, il faut s'assurer que tout ce qui peut être sauvegardé est sauvegardé

BACKUP LOG Ventes ON DISK='C:\Backups\TailLogVentesBackup.bak' WITH CONTINUE_AFTER_ERROR


RESTORE DATABASE [Ventes] FROM  DISK = N'C:\Backups\Ventes-1_20260929_053312.bak', 
 DISK = N'C:\Backups\Ventes-2_20260929_053312.bak' WITH  FILE = 1,  NORECOVERY

RESTORE DATABASE [Ventes] FROM  DISK = N'C:\Backups\Ventes-diff-1_20260929_054632.bak',  
DISK = N'C:\Backups\Ventes-diff-2_20260929_054632.bak' WITH  FILE = 1,  NORECOVERY,  NOUNLOAD,  STATS = 5

RESTORE LOG [Ventes] FROM  DISK = N'C:\Backups\Ventes-log-1_20260929_055019.bak',  
DISK = N'C:\Backups\Ventes-log-2_20260929_055019.bak' WITH  FILE = 1,  NORECOVERY,  NOUNLOAD,  STATS = 5

RESTORE LOG [Ventes] FROM  DISK = N'C:\Backups\Ventes-log-1_20260929_062606.bak',  
DISK = N'C:\Backups\Ventes-log-2_20260929_062606.bak' WITH  FILE = 1,  NORECOVERY,  NOUNLOAD,  STATS = 5

RESTORE LOG [Ventes] FROM  DISK = N'C:\Backups\Ventes-log-1_20260929_062727.bak',  
DISK = N'C:\Backups\Ventes-log-2_20260929_062727.bak' WITH  FILE = 1,  NORECOVERY,  NOUNLOAD,  STATS = 5

RESTORE LOG [Ventes] FROM  DISK = N'C:\Backups\Ventes-log-1_20260929_063504.bak',  
DISK = N'C:\Backups\Ventes-log-2_20260929_063504.bak' WITH  FILE = 1,  NOUNLOAD,  STATS = 5

GO


