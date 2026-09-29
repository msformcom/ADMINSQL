SELECT * FROM Ventes.Ventes.VentesProduits

-- Table [ActiveSubscriptions] Dans le schema par defaut du user
SELECT * FROM [ActiveSubscriptions]


-- Table [ActiveSubscriptions] Dans le schema dbo
SELECT * FROM [dbo].[ActiveSubscriptions]

-- Table [ActiveSubscriptions] Dans le schema dbo dans la BDD Vents
SELECT * FROM ventes.[dbo].[ActiveSubscriptions]

-- Table [ActiveSubscriptions] Dans le schema dbo dans la BDD Ventes sur l'instance [Mia-SQL\SQL2]
-- (Créer le linked server au préalable)
SELECT * FROM [Mia-SQL\SQL2].ReportServer.[dbo].[ActiveSubscriptions]