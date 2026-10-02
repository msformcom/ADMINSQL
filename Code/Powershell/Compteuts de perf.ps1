# ==========================================
# Collecte Avancée - Baseline Matérielle SQL
# ==========================================
$OutputFile = "C:\Backups\SQL_Hardware_Baseline.csv"
$IntervalSec = 30     # Intervalle de 30 secondes pour capturer les pics
$TotalSamples = 120   # 120 échantillons = 1 heure de surveillance fine

# Liste élargie des compteurs système et matériels
$Counters = @(
    # --- PROCESSEUR (CPU & Contention) ---
    "\Processor(_Total)\% Processor Time",
    "\Processor(_Total)\% Privileged Time",       # Temps passé en mode noyau (souvent lié aux drivers disques/réseau)
    "\System\Processor Queue Length",             # Nombre de threads en attente de CPU (> 2 par cœur = saturation)

    # --- MÉMOIRE PHYSIQUE & PAGINATION ---
    "\Memory\Available MBytes",
    "\Memory\Pages/sec",                          # Nombre de pages lues/écrites sur le fichier d'échange (Swap). Élevé = manque de RAM.
    "\Memory\Committed Bytes",                    # Mémoire totale engagée par le système

    # --- DISQUES & STOCKAGE (I/O Latence - Crucial pour SQL) ---
    "\LogicalDisk(*)\Avg. Disk sec/Read",         # Temps de réponse en lecture (Idéal < 10ms, Mauvais > 20-25ms)
    "\LogicalDisk(*)\Avg. Disk sec/Write",        # Temps de réponse en écriture (Idéal < 5ms, Critique pour les journaux de transactions)
    "\LogicalDisk(*)\Avg. Disk Queue Length",     # File d'attente des disques
    "\LogicalDisk(*)\Disk Transfers/sec",         # IOPS globales par disque

    # --- RÉSEAU ---
    "\Network Interface(*)\Bytes Total/sec",
    "\Network Interface(*)\Output Queue Length"   # File d'attente réseau (> 0 indique une saturation de la carte réseau)
)

Write-Host "Démarrage de la collecte des compteurs matériels..." -ForegroundColor Cyan
$Results = @()

for ($i = 1; $i -le $TotalSamples; $i++) {
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    
    $CounterData = Get-Counter -Counter $Counters -ErrorAction SilentlyContinue
    
    foreach ($TimeSeries in $CounterData.CounterSamples) {
        $Results += [PSCustomObject]@{
            Timestamp     = $Timestamp
            Instance      = $TimeSeries.InstanceName # Permet de distinguer les disques (C:, D:) ou cartes réseau
            Path          = $TimeSeries.Path
            CookedValue   = [Math]::Round($TimeSeries.CookedValue, 4)
        }
    }
    
    Write-Host "Échantillon $i / $TotalSamples collecté à $Timestamp"
    if ($i -lt $TotalSamples) { Start-Sleep -Seconds $IntervalSec }
}

$Results | Export-Csv -Path $OutputFile -NoTypeInformation -Encoding UTF8
Write-Host "Collecte terminée ! Rapport enregistré dans : $OutputFile" -ForegroundColor Green