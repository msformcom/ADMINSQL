-- 1) Liste des bases de données qui ne sont pas en mode full => Avec journal

SELECT 
    name AS [Nom de la base de données],
    recovery_model_desc AS [Mode de récupération],
    state_desc AS [État]
FROM sys.databases
WHERE recovery_model_desc <> 'FULL'
  -- Optionnel : Exclure les bases de données système (master, model, msdb, tempdb)
  AND database_id > 4
ORDER BY name;

-- 2) Liste des BDD dont la dernière sauvegarde du journal date de plus d'une heure

SELECT 
    d.name AS [Nom de la base de données],
    d.recovery_model_desc AS [Mode de récupération],
    MAX(b.backup_finish_date) AS [Dernière sauvegarde du journal],
    DATEDIFF(MINUTE, MAX(b.backup_finish_date), GETDATE()) AS [Minutes écoulées depuis]
FROM sys.databases d
LEFT JOIN msdb.dbo.backupset b 
    ON d.name = b.database_name 
    AND b.type = 'L' -- 'L' correspond au type Transaction Log Backup
WHERE d.state_desc = 'ONLINE'
  -- Exclure les bases en mode SIMPLE (qui ne font pas de log backups)
  AND d.recovery_model_desc <> 'SIMPLE'
  -- Exclure les bases système si besoin (optionnel)
  AND d.database_id > 4
GROUP BY d.name, d.recovery_model_desc
HAVING MAX(b.backup_finish_date) < DATEADD(HOUR, -1, GETDATE())
   OR MAX(b.backup_finish_date) IS NULL
ORDER BY [Dernière sauvegarde du journal] ASC;