# projektwoche

# Anleitung: Installation von VirtualBox

Diese Anleitung beschreibt, wie man Oracle VirtualBox auf einem Windows System installiert.

## Voraussetzungen

- Ein Computer mit Windows
- Eine Internetverbindung
- Admin-Rechte auf deinem System

## Schritt 1: VirtualBox herunterladen

1. Öffne die offizielle VirtualBox-Webseite: [https://www.virtualbox.org](https://www.virtualbox.org)
2. Klicke auf **"Downloads"**.
3. Wähle das passende Installationspaket:
   - **Windows hosts** für Windows
   - **OS X hosts** für macOS
   - **Linux distributions** für Linux

## Schritt 2: Installation unter Windows

1. Doppelklicke auf die heruntergeladene `.exe`-Datei.
2. Folge dem Installationsassistenten:
   - Belasse die Voreinstellungen, wenn du unsicher bist.
   - Klicke auf **"Next"** → **"Next"** → **"Yes"** → **"Install"**.
3. Bestätige ggf. Benutzerkontensteuerung (UAC).
4. Klicke auf **"Finish"**, um die Installation abzuschließen.

## Schritt 2: VM in VirtualBox von Gold-Image erstellen

1. **Starte VirtualBox**
2. Gehe zu **Datei → Appliance importieren**
3. Wähle die `.ova`-Datei aus
4. Klicke auf **Weiter**
5. **Überprüfe die Einstellungen:**
   - Wähle eine **RAM-Größe**, z. B. **6144 MB** (abhängig von deinem System).
   - **Netzwerkkarten:** kannst du auf _„nicht verbunden“_ setzen
   - **Speicherort:** ggf. anpassen
7. **Wähle bei MAC-Adressen:**
   - 🔘 **Neue MAC-Adressen generieren**  
8. Klicke auf **Importieren**

---

### Git-Repo

Clonen des Repos von GitHub

```bash
git clone https://github.com/Sling2009/projektwoche.git
```

---

[Docker- Doku](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository)
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

anscließend installieren 
```bash
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

und testen 
```bash
sudo docker run hello-world
```
[Docker-Post Install](https://docs.docker.com/engine/install/linux-postinstall/)

Wir erstellen eine docker gruppe und packe uns ins die Docker Gruppe
```bash
sudo groupadd docker
sudo usermod -aG docker $USER
```

---

installation von k8s kind.io
```bash
[ $(uname -m) = x86_64 ] && \
curl -Lo ./kind https://kind.sigs.k8s.io/dl/latest/kind-linux-amd64 && \
chmod +x ./kind && \
sudo mv ./kind /usr/local/bin/
```
Was passiert hier, wir prüfen ob wir wirklich eine x86 Archtektur haben mir "[ $(uname -m) = x86_64 ]" dann downloaden uns kind.io latest. machen die binary ausführbar und verschieben sie nach /usr/local/bin/

Installation k9s
```bash
[ "$(uname -m)" = "x86_64" ] && \
curl -Lo k9s.tar.gz https://github.com/derailed/k9s/releases/download/v0.50.4/k9s_Linux_amd64.tar.gz && \
tar -xzf k9s.tar.gz && \
chmod +x k9s && \
sudo mv k9s /usr/local/bin/ && \
rm k9s.tar.gz LICENSE README.md
```
