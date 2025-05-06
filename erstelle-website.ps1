# Website lokal erstellen und auf GitHub Pages hochladen

# === Benutzer-Eingaben ===
$repoName = "Kerstins-Wanderritte"
$siteTitle = "Kerstins Wanderritte"
$username = Read-Host "GitHub Benutzername"
$token = Read-Host "GitHub-PAT (Token ohne Anführungszeichen)"

# === Projektverzeichnis anlegen ===
$localPath = "$env:USERPROFILE\Documents\$repoName"
New-Item -ItemType Directory -Path $localPath -Force | Out-Null

# === index.html erstellen ===
$html = @"
<!DOCTYPE html>
<html lang='de'>
<head>
    <meta charset='UTF-8'>
    <title>$siteTitle</title>
    <link rel='stylesheet' href='style.css'>
</head>
<body>
    <header><h1>$siteTitle</h1><p>Willkommen auf meiner Reit-Galerie!</p></header>
    <div class='galerie'>
        <img src='bilder/ritt1.jpg' alt='Ritt 1'>
        <img src='bilder/ritt2.jpg' alt='Ritt 2'>
        <img src='bilder/ritt3.jpg' alt='Ritt 3'>
    </div>
</body>
</html>
"@
Set-Content -Path "$localPath\index.html" -Value $html

# === style.css erstellen ===
$css = @"
body { font-family: Arial; background-color: #fafafa; margin: 0; padding: 0; }
header { background-color: #4CAF50; color: white; padding: 2em; text-align: center; }
.galerie { display: flex; justify-content: center; flex-wrap: wrap; padding: 20px; }
.galerie img { margin: 10px; width: 300px; height: 200px; object-fit: cover; border-radius: 8px; }
"@
Set-Content -Path "$localPath\style.css" -Value $css

# === Bilderordner vorbereiten ===
New-Item -ItemType Directory -Path "$localPath\bilder" -Force | Out-Null
Write-Host "➕ Lege deine Bilder in den Ordner '$localPath\bilder' und nenne sie z. B. ritt1.jpg, ritt2.jpg..."

# === Git init und Push ===
Set-Location $localPath
git init
git config user.name "$username"
git config user.email "$username@users.noreply.github.com"
git remote add origin "https://$token@github.com/$username/$repoName.git"

git add .
git commit -m "erste Website"
git branch -M main
git push -u origin main

# === GitHub Pages aktivieren ===
Start-Process "https://github.com/$username/$repoName/settings/pages"

Write-Host "`n✅ Fertig! Die Seite erscheint bald unter:"
Write-Host "➡ https://$username.github.io/$repoName/"