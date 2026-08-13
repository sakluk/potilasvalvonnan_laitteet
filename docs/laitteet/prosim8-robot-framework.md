# Prosim 8 -ohjaus Robot Frameworkilla

> **Lab 4 -ennakkoluettava.** Asenna kaikki ohjelmistot ennen labraan tuloa —
> labrassa ei ole aikaa asennuksille. Tarkistuslistat löytyvät [tämän sivun
> lopusta](#ennen-labraa-tarkistuslistat).

---

## Miksi automatisoida potilassimulaattorin ohjaus?

Manuaalisessa testauksessa laboratoriohoitaja tai lääkintäteknikko painaa
Prosim 8:n nappuloita yksi kerrallaan: asettaa sykkeen, käynnistää EKG-aallon,
odottaa, vaihtaa simulaatioparametreja. Tämä on hidasta, altista virheille ja
vaikea toistaa täsmälleen samanlaisena.

Automatisoitu testaus tarkoittaa, että tietokone suorittaa saman toimenpidesarjan
ohjelmakoodin perusteella — sekuntien tarkkuudella, täsmälleen samalla tavalla
joka kerta. Tämä on olennaista esimerkiksi silloin, kun halutaan varmistaa, että
potilasmonitorin hälytysraja laukeaa juuri oikeassa arvoissa.

Robot Framework on testaukseen tarkoitettu avoimen lähdekoodin työkalu, joka
toimii Pythonin päällä. Ajattele sitä kuin reseptiä: resepti kuvaa vaiheistuksen
sanallisesti ja selkeästi, mutta tietokone suorittaa sen automaattisesti.

```
*** Test Cases ***
EKG Normal Sinus Rhythm 60 bpm
    Set ECG Waveform    NSR
    Set Heart Rate      60
    Wait                5s
    Log                 Monitor should display 60 bpm NSR
```

Reseptin askeleet eivät ole Python-koodia — ne kirjoitetaan lähes luonnollisella
kielellä (tai suomeksi kommenteissa). Taustalla Python-kirjastot hoitavat
varsinaisen kommunikaation laitteen kanssa.

---

## Miten tietokone kommunikoi Prosim 8:n kanssa?

Prosim 8:ssa on USB-portti, jonka kautta se voidaan kytkeä tietokoneeseen.
Yhteys ei kuitenkaan ole "moderni USB" — Prosim 8 käyttää sarjaporttia (serial /
RS-232), joka on peräisin 1960-luvulta. USB toimii tässä vain johtimena:
käyttöjärjestelmä luo virtuaalisen COM-portin (Windows: COM3, COM4…), jonka
kautta lähetetään tekstimuotoisia komentoja.

```
Tietokone (Python/Robot Framework)
    │
    │  USB-kaapeli
    ▼
USB-sarjamuunnin (ajuri luo virtuaalisen COM-portin)
    │
    │  Sarjaportti: 115 200 baud, 8N1
    ▼
Prosim 8 (vastaanottaa ja suorittaa komennot)
```

Komentoprotokollan periaate on yksinkertainen: tietokone lähettää
lyhyen ASCII-tekstikomennon, Prosim 8 vahvistaa vastaanoton tai palauttaa
arvon. Analogia: käskyt ovat kuin tekstiviestit laitteelle, joka osaa
lukea vain tiettyjä sanoja.

| Komento | Merkitys |
|---------|---------|
| `ECGRUN NSR` | Käynnistä EKG, normaali sinusrytmi |
| `NSRA 80` | Aseta syketaajuus 80 bpm |
| `SAT 95` | Aseta SpO2-arvo 95 % |
| `TEMP C 37.0` | Aseta kehonlämpötila 37,0 °C (Celsius) |
| `RESPRUN` | Käynnistä hengityssimulaatio |

Yksityiskohtaisempi komentoprotokolla löytyy Pokharel (2024) luvusta 3.2.2
sekä Prosim 8:n *Remote Control* -manuaalista.

---

## Ohjelmistopino

Lab 4:n ohjausympäristö koostuu neljästä kerroksesta:

| Kerros | Komponentti | Tehtävä |
|--------|------------|---------|
| Testiskriptit | Robot Framework `.robot`-tiedostot | Testien logiikka, luettava kielellinen kuvaus |
| Kommunikaatiokirjasto | `CustomSerialLibrary.py` | Avaa COM-portin, lähettää/vastaanottaa komentoja |
| Sarjaporttituki | `pyserial` Python-kirjasto | Alustason COM-porttioperaatiot |
| Suoritusympäristö | Python 3.x + kehitysympäristö (PyCharm) | Koodin ajaminen, debuggaus |

Robot Framework kutsuu `CustomSerialLibrary.py`-kirjastoa, joka käyttää
`pyserial`-kirjastoa COM-portin avaamiseen. Sinun tehtäväsi labrassa on
kirjoittaa ja suorittaa `.robot`-testiskriptejä — et kirjoita sarjakommunikaatiota
itse.

---

## Ennen labraa: tarkistuslistat

> ⚠️ **Asenna ohjelmat kotona ennen labraan tuloa.** Labrassa ei ole aikaa
> asennuksille — asennusvirheitä ei ehdi korjata, ja sessio on lyhyt.

### Asennusohjeet

Yksityiskohtaiset asennusohjeet (kuvakaappauksineen) löytyvät kurssin
OMA-työtilasta: **Pokharel (2024): Potilasmonitorien testausympäristö,
luku 3.2.2** (sivut 67–70). Seuraa ohjeiden vaiheita 1–10 järjestyksessä.

Asennettavat komponentit lyhyesti:

1. **Python 3.x** — [python.org](https://www.python.org/downloads/)
   Asennuksen aikana valitse *"Add Python to PATH"*
2. **PyCharm Community Edition** — [jetbrains.com/pycharm](https://www.jetbrains.com/pycharm/download/)
   (tai muu Python-kehitysympäristö, esim. VS Code)
3. **Python-kirjastot** — asenna komentoriviltä:
   ```
   pip install pyserial
   pip install robotframework
   pip install robotframework-seriallibrary
   pip install robotframework-lsp
   ```
4. **USB-sarjamuuntimen ajuri** — tarvitaan, jos tietokone ei tunnista
   Prosim 8:aa automaattisesti. Katso malli Prosim 8:n takapaneelista;
   ajuri löytyy valmistajan sivuilta.
5. **CustomSerialLibrary.py** — kurssin OMA-työtilasta (ladataan projektin
   kansioon ennen labraa)

### Toimivuuden tarkistuslista

Ennen labraan tuloa, tarkista nämä omalla tietokoneellasi:

- [ ] `python --version` tulostaa version (3.x) komentoriviltä
- [ ] `pip show pyserial` tulostaa versiotiedot (ei virhettä)
- [ ] `pip show robotframework` tulostaa versiotiedot
- [ ] PyCharm (tai valittu IDE) avautuu ja tunnistaa Python-tulkin
- [ ] `CustomSerialLibrary.py` on ladattu projektin kansioon

Prosim 8:n kytkemistä tietokoneeseen ja COM-portin tunnistamista harjoitellaan
labrassa yhdessä.

---

## Valmistautuminen Lab 4:ään

Lab 4 on kurssin ohjelmointisessio. Tavoitteena on kirjoittaa Robot Framework
-testiskriptejä, jotka ohjaavat Prosim 8:aa automaattisesti.

**Ennen labraa lue:**

| Materiaali | Osio | Miksi |
|-----------|------|-------|
| Pokharel (2024) | Luku 3.2.2 (ss. 67–70) | Asennusvaiheet ja ympäristön konfigurointi |
| Pokharel (2024) | Luku 3.2 (etäsimulointi-osio) | Komentoprotokollan periaate ja esimerkkikomennot |
| Robot Framework -dokumentaatio | [robotframework.org/robotframework/](https://robotframework.org/robotframework/) | Testiskriptin rakenne (`*** Test Cases ***`, `*** Keywords ***`) |

**Labraan tuo:**
- Oma kannettava tietokone, johon ohjelmistot on asennettu
- USB-A-kaapeli (Prosim 8:n liitäntä)
- Kurssin OMA:sta ladattu `CustomSerialLibrary.py`

---

*Potilasvalvonnan laitteet — TX00EY15 | Metropolia Ammattikorkeakoulu*
