# Workshop Docker & Kubernetes am 11.06.2025 - 12.06.2025
In diesem Repo sind alle notwendigen Dateien für den Workshop Docker & Kubernetes am 11.06.2025 - 12.06.2025 enthalten. Es dient als Orientierung und Unterstützung zum Vortrag. Es umfasst sowohl Lösungen als auch eine Sammlung von Links für die jeweils genutzte Software in der VM.

## Anleitung: Installation von VirtualBox

Diese Anleitung beschreibt, wie man Oracle VirtualBox auf einem Windows-System installiert.

### Voraussetzungen

1. Ein Computer mit Windows  
2. Eine Internetverbindung  
3. Admin-Rechte auf deinem System  

### Schritt 1: VirtualBox herunterladen

1. Öffne die offizielle VirtualBox-Webseite: [https://www.virtualbox.org](https://www.virtualbox.org)  
2. Klicke auf **"Downloads"**  
3. Wähle das passende Installationspaket:  
   - **Windows hosts** für Windows  
   - **OS X hosts** für macOS  
   - **Linux distributions** für Linux  

### Schritt 2: Installation unter Windows

1. Doppelklicke auf die heruntergeladene `.exe`-Datei  
2. Folge dem Installationsassistenten:  
   - Belasse die Voreinstellungen, wenn du unsicher bist  
   - Klicke auf **"Next"** → **"Next"** → **"Yes"** → **"Install"**  
3. Bestätige ggf. die Benutzerkontensteuerung (UAC)  
4. Klicke auf **"Finish"**, um die Installation abzuschließen  

### Schritt 3: VM in VirtualBox von Gold-Image erstellen

1. **Starte VirtualBox**  
2. Gehe zu **Datei → Appliance importieren**  
3. Wähle die `.ova`-Datei aus  
4. Klicke auf **Weiter**  
5. **Überprüfe die Einstellungen:**  
   - Wähle eine **RAM-Größe**, z. B. **6144 MB** (abhängig von deinem System)  
   - **Netzwerkkarten:** kannst du auf _„nicht verbunden“_ setzen  
   - **Speicherort:** ggf. anpassen  
6. **Wähle bei MAC-Adressen:**  
   - 🔘 **Neue MAC-Adressen generieren**  
7. Klicke auf **Importieren**  

## Git-Repo
Clonen des Repos von GitHub
```bash
git clone https://github.com/Sling2009/projektwoche.git
```
## Docker
Docker heerunterladen wie in der [Docker-Doku](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository) beschrieben
```bash
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
```
Anschließend installieren:
```bash
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```
Und testen:
```bash
sudo docker run hello-world
```
Nach erfolgreicher INstallation [Docker-Post Install](https://docs.docker.com/engine/install/linux-postinstall/) durch führen

Wir erstellen eine Docker-Gruppe und fügen $USER dieser hinzu:
```bash
sudo usermod -aG docker $USER
loginctl terminate-session $XDG_SESSION_ID
```

## kubectl instalieren
```bash
[ $(uname -m) = x86_64 ] && \
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
chmod +x ./kubectl && \
sudo mv ./kubectl /usr/local/bin/
```

## k8s kind.io
Download [kind.io](https://kind.sigs.k8s.io/) und installieren
```bash
[ $(uname -m) = x86_64 ] && \
curl -Lo ./kind https://kind.sigs.k8s.io/dl/latest/kind-linux-amd64 && \
chmod +x ./kind && \
sudo mv ./kind /usr/local/bin/
```
Was passiert hier? Wir prüfen, ob wir wirklich eine x86-Architektur haben mit [ $(uname -m) = x86_64 ], dann laden wir die aktuelle Version von kind.io herunter, machen die Binary ausführbar und verschieben sie nach /usr/local/bin/.

### k9s
Download [k9s](https://k9scli.io/) und installieren
```bash
[ "$(uname -m)" = "x86_64" ] && \
curl -Lo k9s.tar.gz https://github.com/derailed/k9s/releases/download/v0.50.4/k9s_Linux_amd64.tar.gz && \
tar -xzf k9s.tar.gz && \
chmod +x k9s && \
sudo mv k9s /usr/local/bin/ && \
rm k9s.tar.gz LICENSE README.md
```

### Docker Befehle
docker build --build-arg APP_VERSION=1.0.0 -t http-app:latest .
docker run -d --name http-app -e PORT=8686 -p 8080:8686 http-app:latest
