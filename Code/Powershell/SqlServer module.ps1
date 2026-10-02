# ==========================================================
# Sauvegarde Copy-Only de toutes les bases utilisateur
# ==========================================================
Import-Module SqlServer -force

$ServerInstance = "MIA-SQL"            # Remplacez par votre instance (ex: "MONSERVEUR\VENTES")
$BackupPath     = "C:\Backups\CopyOnly\" # Dossier de destination

# Création du dossier cible s'il n'existe pas
if (!(Test-Path $BackupPath)) {
    New-Item -ItemType Directory -Force -Path $BackupPath | Out-Null
}

Write-Host "Recherche des bases de données utilisateur sur [$ServerInstance]..." -ForegroundColor Cyan

# Récupération uniquement des bases utilisateur en état normal (exclut les systèmes : master, model, msdb, tempdb)
$UserDatabases = Get-SqlDatabase -ServerInstance $ServerInstance | Where-Object { $_.IsSystemObject -eq $false -and $_.Status -eq "Normal" }

foreach ($db in $UserDatabases) {
    $DbName =$db.Name
    $Timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
    $BackupFile = "$BackupPath\${DbName}_CopyOnly_${Timestamp}.bak"
    
    Write-Host "-> Sauvegarde (Copy-Only) en cours pour : $DbName" -ForegroundColor Yellow
    
    try {
        # Exécution de la sauvegarde avec l'option CopyOnly et la compression activée
        Backup-SqlDatabase -ServerInstance $ServerInstance `
                           -Database $DbName `
                           -BackupFile $BackupFile `
                           -CopyOnly `
                           -CompressionOption On
                           
        Write-Host "   Succès : $BackupFile" -ForegroundColor Green
    }
    catch {
        Write-Host "   ERREUR sur $DbName :$_" -ForegroundColor Red
    }
}

Write-Host "=== Opération de sauvegarde Copy-Only terminée ===" -ForegroundColor Cyan