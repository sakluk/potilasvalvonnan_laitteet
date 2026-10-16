# Asennusohjeet: Python, Robot Framework ja ProSim 8

Tässä ohjeessa asennetaan testausympäristö Windows- tai macOS-tietokoneelle. Lisäksi tarkistetaan yhteys ProSim 8 -laitteeseen ja tallennetaan projekti tarvittaessa GitHubiin.

Etene ohjeen mukaisessa järjestyksessä. Valitse käyttöjärjestelmääsi vastaavat komennot. Suorita terminaalin komennot yksi rivi kerrallaan ja odota, että komento päättyy ennen seuraavaa vaihetta.

Windowsissa käytetään **PowerShelliä**. macOS:ssä käytetään **Terminalia eli Päätettä**. Terminaali on ikkuna, johon kirjoitetaan komentoja. VS Codessa terminaali avataan ohjelman sisällä.

## Sisällysluettelo

1. [Tarkista tarvittavat työkalut](#1-tarkista-tarvittavat-työkalut)
2. [Tarkista ja asenna Python](#2-tarkista-ja-asenna-python)
3. [Asenna VS Code ja lisäosat](#3-asenna-vs-code-ja-lisäosat)
4. [Tarkista ja asenna Node.js tarvittaessa](#4-tarkista-ja-asenna-nodejs-tarvittaessa)
5. [Luo projekti ja virtuaaliympäristö](#5-luo-projekti-ja-virtuaaliympäristö)
6. [Asenna Robot Framework ja SerialLibrary](#6-asenna-robot-framework-ja-seriallibrary)
7. [Testaa asennus ilman laitetta](#7-testaa-asennus-ilman-laitetta)
8. [Tarkista ProSim 8 -yhteys laboratoriossa](#8-tarkista-prosim-8--yhteys-laboratoriossa)
9. [Pikakomennot ja ongelmatilanteet](#9-pikakomennot-ja-ongelmatilanteet)
10. [Tallenna projekti GitHubiin](#10-tallenna-projekti-githubiin)

## 1. Tarkista tarvittavat työkalut

| Työkalu | Käyttötarkoitus |
|---|---|
| Python | Suorittaa Robot Frameworkin ja Python-koodin. |
| pip | Asentaa Python-paketit. |
| venv | Luo projektille oman virtuaaliympäristön. |
| VS Code | Ohjelma koodin ja testitiedostojen muokkaamiseen. |
| RobotCode-lisäosa | Tukee Robot Framework -testien kirjoittamista VS Codessa. |
| Robot Framework | Suorittaa testit ja luo testiraportit. |
| SerialLibrary ja pySerial | Mahdollistavat sarjaporttiyhteyden laitteeseen. |
| Node.js ja npm | Tarvitaan, jos käytössä oleva lisäosa tai muu kurssin työkalu edellyttää niitä. |
| Git ja GitHub-tili | Tarvitaan vain, jos projekti tallennetaan GitHubiin. |

- pip ja venv sisältyvät tavalliseen Pythonin asennukseen. ProSim 8 -laite ja sen USB-kaapeli tarvitaan vasta yhteyden testaamiseen laboratoriossa.

## 2. Tarkista ja asenna Python

### Windows

1. Avaa Käynnistä-valikko.
2. Kirjoita **PowerShell** ja avaa ohjelma.
3. Tarkista Python ja pip:

```powershell
python --version
python -m pip --version
```

Jos `python` ei löydy, kokeile:

```powershell
py --version
py -m pip --version
```

Jos Python puuttuu:

1. Avaa [Pythonin lataussivu](https://www.python.org/downloads/).
2. Lataa ja asenna **Python Install Manager**.
3. Avaa uusi PowerShell ja asenna oletusversio:

```powershell
pymanager install default
```

4. Tarkista Python ja pip uudelleen.

**Tarkistus:** molemmat tarkistuskomennot näyttävät versionumeron.

### macOS

1. Paina **Cmd + Space**.
2. Kirjoita **Terminal** tai **Pääte** ja paina Enter.
3. Tarkista Python ja pip:

```bash
python3 --version
python3 -m pip --version
```

Jos Python puuttuu tai sen versio ei täytä kurssin vaatimuksia:

1. Tarkista macOS-versio kohdasta **Apple-valikko → Tietoja tästä Macista**.
2. Avaa [Pythonin macOS-lataussivu](https://www.python.org/downloads/macos/).
3. Lataa macOS-versiollesi sopiva vakaa Python 3:n `.pkg`-asennuspaketti.
4. Avaa paketti ja seuraa asennusohjeita.
5. Avaa **Ohjelmat / Applications** -kansiosta oman Python-versiosi kansio. Suorita siellä **Install Certificates.command**.
6. Avaa uusi Terminal ja tarkista Python ja pip uudelleen.

**Tarkistus:** molemmat tarkistuskomennot näyttävät versionumeron.

## 3. Asenna VS Code ja lisäosat

1. Lataa [Visual Studio Code eli VS Code](https://code.visualstudio.com/download).
2. Windowsissa suorita asennusohjelma. macOS:ssä pura ladattu tiedosto ja siirrä VS Code **Ohjelmat / Applications** -kansioon.
3. Avaa VS Code.
4. Avaa vasemman reunan **Extensions**-näkymä eli lisäosat.
5. Asenna seuraavat lisäosat:

   - **Python**, julkaisija Microsoft.
   - **RobotCode – Robot Framework Support**.

## 4. Tarkista ja asenna Node.js tarvittaessa

Node.js suorittaa JavaScript-koodia. Sen mukana asentuu npm, jolla hallitaan JavaScript-paketteja. Asenna Node.js, jos kurssin työkalu edellyttää sitä tai virheilmoitus kertoo, että `node` tai `npm` puuttuu.

Tässä ohjeessa Robot Framework ja SerialLibrary asennetaan Pythonin pip-työkalulla. Niiden asennuskomennot eivät edellytä Node.js:ää.

### Tarkista asennus

Avaa PowerShell tai Terminal ja suorita:

```text
node --version
npm --version
```

Jos molemmat komennot näyttävät versionumeron, voit jatkaa seuraavaan vaiheeseen. Jos Windowsissa `node` toimii mutta `npm` antaa ilmoituksen skriptien suorittamisen estosta, katso luvun 9 ohje.

### Windows

1. Avaa [Node.js:n lataussivu](https://nodejs.org/en/download).
2. Valitse **LTS-versio** eli pitkään tuettu versio.
3. Valitse käyttöjärjestelmäksi **Windows** ja lataa tietokoneellesi sopiva **Installer (.msi)** -asennuspaketti.
4. Avaa paketti ja seuraa asennusohjeita. Säilytä npm:n asennus ja **Add to PATH** -valinta. PATH-asetus auttaa terminaalia löytämään ohjelman.
5. Sulje VS Code sekä avoimet PowerShell-ikkunat. Avaa VS Code uudelleen ja luo uusi terminaali.
6. Suorita `node --version` ja `npm --version` uudelleen.

### macOS

1. Avaa [Node.js:n lataussivu](https://nodejs.org/en/download).
2. Valitse **LTS-versio**.
3. Valitse käyttöjärjestelmäksi **macOS** ja lataa **Installer (.pkg)** -asennuspaketti.
4. Avaa paketti ja seuraa asennusohjeita.
5. Sulje VS Code ja avoimet Terminal-ikkunat. Avaa VS Code uudelleen ja luo uusi terminaali.
6. Suorita `node --version` ja `npm --version` uudelleen.

**Tarkistus:** molemmat komennot näyttävät versionumeron. Node.js asennetaan tietokoneelle, joten sitä ei lisätä Pythonin `requirements.txt`-tiedostoon.

## 5. Luo projekti ja virtuaaliympäristö

Virtuaaliympäristö pitää projektin Python-paketit erillään muiden projektien paketeista. Se tallentuu `.venv`-kansioon.

1. Luo kansio nimeltä `harjoitus`.
2. Avaa kansio VS Codessa: **File → Open Folder**.
3. Avaa terminaali: **Terminal → New Terminal**. Käytä Windowsissa **PowerShelliä**.

Suorita seuraavat komennot `harjoitus`-kansiossa.

### Windows: PowerShell

Luo ja aktivoi virtuaaliympäristö:

```powershell
python -m venv .venv
.\.venv\Scripts\Activate.ps1
```

Jos `python` ei löydy, luo ympäristö komennolla `py -m venv .venv`.

### macOS: Terminal

Luo ja aktivoi virtuaaliympäristö:

```bash
python3 -m venv .venv
source .venv/bin/activate
```

### Tarkista ja valitse ympäristö

Aktivoinnin jälkeen käytä molemmissa käyttöjärjestelmissä `python`-komentoa. Tarkista ympäristö:

```text
python -c "import sys; print(sys.executable)"
python -m pip --version
```

**Tarkistus:** molemmissa poluissa näkyy projektin `.venv`-kansio.

Valitse sama ympäristö VS Codessa:

1. Avaa komentovalikko: **Ctrl + Shift + P** Windowsissa tai **Cmd + Shift + P** macOS:ssä.
2. Valitse **Python: Select Interpreter**.
3. Valitse projektin `.venv`-kansion Python.

**Jatka projektikansiossa, virtuaaliympäristö aktivoituna.** Aktivoi ympäristö aina uudessa terminaalissa. Jos PowerShell estää aktivoinnin, katso luvun 9 ohje.

## 6. Asenna Robot Framework ja SerialLibrary

1. Luo VS Codessa projektikansion juureen tiedosto `requirements.txt`.
2. Lisää tiedostoon seuraavat rivit ja tallenna tiedosto:

```text
robotframework
pyserial
robotframework-seriallibrary
```

3. Asenna tiedostossa luetellut paketit:

```text
python -m pip install -r requirements.txt
```

4. Tarkista asennus:

```text
python -m robot --version
python -m pip show robotframework pyserial robotframework-seriallibrary
python -m pip check
```

**Tarkistus:** Robot Framework näyttää versionumeron, kaikkien kolmen paketin tiedot löytyvät ja `pip check` ei ilmoita pakettien välisistä riippuvuusongelmista.

RobotCode-lisäosaa varten ei tarvitse asentaa erillistä `robotframework-lsp`-pakettia.

## 7. Testaa asennus ilman laitetta

Tässä testissä käytetään ohjelmallista sarjaporttia `loop://`. Se palauttaa lähetetyn tekstin takaisin. Fyysistä laitetta ei tarvita.

1. Luo projektikansioon kansio `tests`.
2. Luo sen sisään tiedosto `asennus.robot`.
3. Lisää tiedostoon seuraava sisältö ja tallenna se. Säilytä esimerkin sisennykset ja vähintään kaksi välilyöntiä komentojen ja niiden argumenttien välissä.

```robotframework
*** Settings ***
Library    SerialLibrary    loop://    encoding=ascii    timeout=3
Library    String

*** Test Cases ***
Asennuksen tarkistus
    [Documentation]    Tarkistaa sarjaporttikirjaston toiminnan ilman laitetta.
    [Teardown]    Close Port
    Open Port
    Port Should Be Open
    Write Data    ASENNUS_OK\n
    ${vastaus}=    Read Until    terminator=\n
    ${vastaus}=    Strip String    ${vastaus}
    Should Be Equal As Strings    ${vastaus}    ASENNUS_OK
```

4. Suorita testi projektikansion juuressa:

```text
python -m robot -d results tests/asennus.robot
```

**Tarkistus:** testin tulos on `PASS`. Raportti tallentuu tiedostoon `results/report.html`. Tämä testi tarkistaa ohjelmiston toiminnan, mutta ProSim-yhteys tarkistetaan erikseen seuraavassa vaiheessa.

## 8. Tarkista ProSim 8 -yhteys laboratoriossa

### Etsi laitteen sarjaportti

1. Käynnistä ProSim 8.
2. Kytke laitteen **USB Device** -portti tietokoneeseen laitteen USB-kaapelilla. Käytä tarvittaessa tietokoneellesi sopivaa sovitinta.
3. Listaa sarjaportit aktivoidussa virtuaaliympäristössä:

```text
python -m serial.tools.list_ports -v
```

Jos porttia on vaikea tunnistaa, suorita komento ennen laitteen kytkemistä ja uudelleen kytkemisen jälkeen. Etsi listaan ilmestynyt uusi portti.

| Käyttöjärjestelmä | Esimerkki portin nimestä |
|---|---|
| Windows | `COM3` |
| macOS | `/dev/cu.usbserial-XXXX` |

Windowsissa portti näkyy myös kohdassa **Laitehallinta → Portit (COM ja LPT)**. Jos porttia ei näy, tarkista kaapeli, sovitin ja sarjaporttiajuri opettajan kanssa. macOS-yhteys edellyttää, että laite näkyy käyttöjärjestelmässä sarjaporttina.

### Luo yhteystesti

Varmista ennen testiä, että laite on paikallisohjauksessa eli `LOCAL`-tilassa. Testi siirtää laitteen etäohjaukseen, tarkistaa käyttötilan ja palauttaa laitteen paikallisohjaukseen. Lopuksi portti suljetaan.

Luo tiedosto `tests/prosim_yhteys.robot` ja lisää siihen seuraava sisältö:

```robotframework
*** Settings ***
Library    SerialLibrary    ${PORTTI}    encoding=ascii    baudrate=115200    timeout=3    rtscts=True
Library    String

*** Variables ***
${PORTTI}    /dev/cu.usbserial-14110

*** Test Cases ***
Test Serial Connection
    [Documentation]    Testaa ProSim 8 -laitteen sarjaporttiyhteyden.
    [Teardown]    Close Port

    Open Port
    Port Should Be Open

    # Siirry etäohjaukseen
    Write Data    REMOTE\n
    ${response}=    Read Until    terminator=\n
    ${response}=    Strip String    ${response}
    Log    Vastaanotettu: ${response}
    Should Be Equal As Strings    ${response}    RMAIN

    # Tarkista käyttötila
    Write Data    QMODE\n
    ${response}=    Read Until    terminator=\n
    ${response}=    Strip String    ${response}
    Log    Vastaanotettu: ${response}
    Should Be Equal As Strings    ${response}    RMAIN

    # Palauta paikallisohjaukseen
    Write Data    LOCAL\n
    ${response}=    Read Until    terminator=\n
    ${response}=    Strip String    ${response}
    Log    Vastaanotettu: ${response}
    Should Be Equal As Strings    ${response}    LOCAL
```

Esimerkin oletusportti `/dev/cu.usbserial-14110` on macOS-portti. Korvaa se oman laitteesi portilla tai anna portti seuraavan kohdan ajokomennossa. Ajokomennon `PORTTI`-arvo korvaa tiedoston oletusarvon myös Windowsissa.

Tiedonsiirtonopeus on 115 200 baudia, ja RTS/CTS-vuonohjaus on käytössä. Odotetut vastaukset ovat `RMAIN`, `RMAIN` ja `LOCAL`.

**Huomaa:** `[Teardown]` sulkee portin myös testin epäonnistuessa. Jos testi epäonnistuu ennen `LOCAL`-komentoa, laite voi jäädä etäohjaukseen. Palauta se tällöin paikallisohjaukseen laitteen käyttöliittymästä. Tämä testi ei lue laitteen tunnistetta.

### Suorita yhteystesti

Korvaa ajokomennon portti oman laitteesi portilla. Käytä muuttujan nimeä `PORTTI`, kuten testitiedostossa.

**Windows-esimerkki:**

```powershell
python -m robot -d results --variable "PORTTI:COM3" tests/prosim_yhteys.robot
```

**macOS-esimerkki:**

```bash
python -m robot -d results --variable "PORTTI:/dev/cu.usbserial-XXXX" tests/prosim_yhteys.robot
```

**Tarkistus:** testin tulos on `PASS`. Laitteen vastaukset näkyvät tiedostossa `results/log.html`. Testin onnistuessa laite palautuu paikallisohjaukseen.

## 9. Pikakomennot ja ongelmatilanteet

### Tavalliset komennot

| Tehtävä | Windows: PowerShell | macOS: Terminal |
|---|---|---|
| Näytä nykyinen kansio | `pwd` | `pwd` |
| Listaa tiedostot | `ls` | `ls` |
| Siirry kansioon | `cd "oma kansio"` | `cd "oma kansio"` |
| Siirry ylempään kansioon | `cd ..` | `cd ..` |
| Aktivoi virtuaaliympäristö | `.\.venv\Scripts\Activate.ps1` | `source .venv/bin/activate` |
| Avaa testiraportti | `Start-Process .\results\report.html` | `open results/report.html` |

Seuraavat komennot toimivat molemmissa käyttöjärjestelmissä:

| Tehtävä | Komento |
|---|---|
| Näytä Python-paketit | `python -m pip list` |
| Listaa sarjaportit | `python -m serial.tools.list_ports -v` |
| Suorita asennustesti | `python -m robot -d results tests/asennus.robot` |
| Tarkista Node.js | `node --version` |
| Tarkista npm | `npm --version` |
| Poistu virtuaaliympäristöstä | `deactivate` |

Keskeytä käynnissä oleva komento tarvittaessa näppäimillä **Ctrl + C**.

### Yleisimmät ongelmat

| Ongelma tai virheilmoitus | Toimi näin |
|---|---|
| Python ei löydy. | Avaa uusi terminaali asennuksen jälkeen. Windowsissa kokeile `py --version`, macOS:ssä `python3 --version`. |
| `No module named robot` tai `SerialLibrary` ei löydy. | Aktivoi projektin `.venv` ja suorita `python -m pip install -r requirements.txt`. Tarkista myös VS Coden Python-valinta. |
| `node` tai `npm` ei löydy; ilmoituksessa näkyy esimerkiksi `command not found` tai `not recognized`. | Asenna Node.js luvun 4 mukaan. Käynnistä VS Code uudelleen ja avaa uusi terminaali. |
| Node.js on asennettu, mutta `node` ei löydy vieläkään. | Tarkista Windowsissa `Get-Command node` ja macOS:ssä `command -v node`. Jos komentoa ei löydy, tarkista asennuspolku ja PATH-asetus opettajan kanssa. |
| Testitiedostoa ei löydy. | Tarkista, että terminaali on projektikansion juuressa. Tarkista tiedoston nimi, sijainti ja tallennus. Tiedostopäätteen pitää olla `.robot`. |
| Portti on varattu. | Sulje muut samaa sarjaporttia käyttävät ohjelmat ja suorita testi uudelleen. |
| ProSim 8 ei vastaa. | Tarkista laitteen virta, portin nimi, USB-kaapeli, ajuri ja yhteysasetukset. Jatka selvittämistä opettajan kanssa. |
| `REMOTE`-komennon vastaus on `!02`. | Tarkista, että laite on ennen testiä `LOCAL`-tilassa. |

### PowerShell estää virtuaaliympäristön aktivoinnin

Voit käyttää virtuaaliympäristön Pythonia suoraan. Korvaa ohjeen `python`-komento polulla `.\.venv\Scripts\python.exe`, esimerkiksi:

```powershell
.\.venv\Scripts\python.exe -m pip install -r requirements.txt
.\.venv\Scripts\python.exe -m robot -d results tests/asennus.robot
```

### PowerShell estää npm-komennon

Jos `node --version` toimii mutta `npm --version` ilmoittaa, ettei `npm.ps1`-skriptiä saa suorittaa, kokeile:

```powershell
npm.cmd --version
```

Jos tämä näyttää versionumeron, npm on asennettu. Käytä tarvittaessa Windowsissa `npm.cmd`-komentoa `npm`-komennon sijasta.

## 10. Tallenna projekti GitHubiin

Tämä vaihe on valinnainen. Ohje koskee uutta paikallista projektia ja uutta, tyhjää GitHub-tietovarastoa eli repoa. Git tallentaa projektin muutoshistorian. GitHubissa projektia voidaan säilyttää ja jakaa verkossa.

### Valmistele projekti

1. Tarkista Git:

```text
git --version
```

Jos Git puuttuu, asenna Windowsissa [Git for Windows](https://git-scm.com/install/windows). macOS:ssä suorita `xcode-select --install` ja seuraa asennusohjeita. Avaa asennuksen jälkeen uusi terminaali.

2. Luo projektikansion juureen tiedosto `.gitignore`. Lisää siihen:

```gitignore
.venv/
__pycache__/
*.py[cod]
results/
.env
node_modules/
```

Tiedosto määrittää, mitä tiedostoja ja kansioita Git jättää pois versionhallinnasta.

3. Tallenna tämä ohje projektikansioon nimellä `README.md`.
4. Luo GitHubissa uusi repo. Jätä README-, `.gitignore`- ja lisenssivalinnat pois, jotta repo on aluksi tyhjä.

### Lähetä ensimmäinen versio

Suorita projektikansiossa seuraavat komennot. Korvaa nimi, sähköpostiosoite ja repon osoite omilla tiedoillasi:

```text
git init -b main
git config user.name "Oma Nimi"
git config user.email "oma.email@example.com"
git add .
git status
```

Tarkista `git status` -tulos ennen seuraavia komentoja. `.venv`, `results` ja mahdollinen `node_modules` eivät saa olla lisättävien tiedostojen joukossa.

```text
git commit -m "Ensimmäinen versio"
git remote add origin https://github.com/OMA-TUNNUS/OMA-REPO.git
git push -u origin main
```

Seuraa mahdollisesti avautuvaa selainkirjautumista. Jos terminaali pyytää GitHub-salasanaa HTTPS-yhteydellä, käytä [henkilökohtaista käyttöoikeustunnusta eli PAT-tunnusta](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens).

**Tarkistus:** projektin tiedostot näkyvät GitHub-repossa.

### Tallenna myöhemmät muutokset

```text
git add .
git status
```

Tarkista lisättävät tiedostot. Suorita sitten:

```text
git commit -m "Päivitä projektia"
git push
```

## Lähteet ja lisäohjeet

- [Python Windowsissa](https://docs.python.org/3/using/windows.html)
- [Python macOS:ssä](https://docs.python.org/3/using/mac.html)
- [RobotCoden käyttöönotto](https://robotcode.io/02_get_started/)
- [Robot Frameworkin käyttöohje](https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html)
- [Node.js:n lataussivu](https://nodejs.org/en/download)
- [Node.js:n ja npm:n asennus](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm/)
- [Node.js VS Codessa](https://code.visualstudio.com/docs/nodejs/nodejs-tutorial)
- [ProSim 8:n tiedonsiirto-ohje, versio 3.17](https://www.flukebiomedical.com/sites/default/files/software/prosim8_-_communications_interface_ver3.17.pdf)
- [Paikallisen projektin lisääminen GitHubiin](https://docs.github.com/en/migrations/importing-source-code/using-the-command-line-to-import-source-code/adding-locally-hosted-code-to-github)

