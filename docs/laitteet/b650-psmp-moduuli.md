# GE CARESCAPE B650 — PSMP-moduuli syventävästi

*Lukuaika noin 25 minuuttia. Tämä dokumentti syventää
[b650-potilasvalvontamonitori.md](b650-potilasvalvontamonitori.md) -johdantoa ja on
tarkoitettu luettavaksi ennen Lab 3:a. Tavoitteena on ymmärtää PSMP-moduulin rakenne
ja toiminta sillä tasolla, että laboratoriossa tehtävät testit ovat mielekkäitä — ei
pelkkää ohjeiden seuraamista.*

> **Lab 3 -ennakkoluettava.** Tässä dokumentissa käydään läpi PSMP:n jokainen
> mittauskanava sekä toiminnallisen testauksen periaatteet. Kurssin OMA-työtilasta
> löytyvä Pokharel (2024) täydentää käytännön kytkentöjen osalta.

---

## Miksi PSMP on erillinen moduuli?

Biologiset signaalit ovat hämmästyttävän heikkoja. Sydämen sähköinen toiminta
tuottaa ihon pinnalle vain muutaman millivoltin (mV) jännitteen, ja invasiivisen
paineenmittauksen anturi muuntaa painevaihtelun vain noin 25 mikrovoltiksi (uV) per
elohopeamillimetri (mmHg). Näin heikkoa signaalia ei voi johtaa pitkää matkaa kaapelia
pitkin ilman, että sähkömagneettinen häiriö — sairaalaympäristössä varsin runsasta
— sekoittuu siihen peruuttamattomasti.

Ratkaisu on sama kuin äänentoistotekniikassa: mikrofonivahvistin sijoitetaan lähelle
mikrofonia, ei kaukana sijaitsevaan miksauspöytään. PSMP (*Patient Side Module Pro*)
on tuo "mikrofonivahvistin" — moduuli, joka vahvistaa, suodattaa ja digitoi signaalin
heti potilaan vierellä, ennen kuin se siirretään rungon prosessorille. Digitaalinen
signaali kestää siirtoa häiriöttä; analoginen signaali ei.

Toinen syy erillisyydelle on turvallisuusluokittelu. PSMP on luokiteltu CF-laitteeksi
(*Cardiac Floating*, sydämeen soveltuvaksi eristetyksi laitteeksi), mikä tarkoittaa,
että potilaan kehon ja maan välinen sähköinen eristys on CF-laitteen vaatimusten
mukainen. Tämä eristys toteutetaan moduulin sisäisessä elektroniikassa —
optoerottimien ja galvaanisesti eristettyjen virtalähteiden avulla. Runko, jossa
eristysvaatimus on löyhempi, ei voisi tarjota vastaavaa suojausta ilman merkittävää
lisäkompleksisuutta.

Modulaarisuus on myös huollon kannalta järkevä valinta: jos PSMP vioittuu, se
vaihdetaan — koko kallista runkoa ei tarvitse vaihtaa.

---

## Fyysinen rakenne: liitännät ja näppäimet

PSMP:n etupaneelissa on viisi liitintä ja neljä näppäintä. Liittimet ovat
**värikoodattuja**, mikä on ensimmäinen asia, johon laboratoriossa kannattaa kiinnittää
huomiota ennen kaapeleiden kytkemistä.

| Liitin | Väri | Mittausparametrit |
|--------|------|-------------------|
| ECG | Vihreä | EKG ja impedanssihengitys |
| SpO₂ | Sininen | Pulssioksimetria |
| T1-T2 | Ruskea | Kaksi lämpötilaa |
| P1-P2 | Punainen | Kaksi invasiivista painetta |
| NIBP | Musta | Ei-invasiivinen verenpaine |

Värikoodauksen logiikka ei ole satunnainen: punainen on kansainvälisesti varoitusväri
invasiivisille kanavaille, joihin liittyy verenkierto ja steriliteetti. CF-luokan liittimet
on lisäksi merkitty sydänsymbolilla — ne erottaa silmämääräisesti muista.

Neljä näppäintä ovat: **Auto On/Off** (käynnistää/sammuttaa NIBP-automaattijakson),
**Start/Cancel** (aloittaa yksittäisen NIBP-mittauksen tai keskeyttää meneillään olevan),
**Zero P1** ja **Zero P2** (nollaa invasiivisen paineen kanavat). Nollaus (*zeroing*)
on toimenpide, jolla laite asettaa ilmanpaineen nollapisteekseen ennen potilaan
liittämistä; tästä lisää invasiivinen paine -osiossa.

### Kolme sisäistä piirikorttia

PSMP sisältää kolme toiminnallista piirikorttia, jotka jakavat mittaustehtävät
luontevasti fysiologisten signaalityyppien mukaan:

**EKG-kortti** (*ECG board*) käsittelee kaikki EKG-signaalit ja impedanssihengityksen.
Se sisältää esivahvistimet jokaiselle kytkentäparille, tahdistimen (*pacemaker*)
havaitsemispiirit, suodattimet kolmella eri taajuuskaistalla sekä 31,25 kHz:n
siniaaltogeneraattorin, joka syöttää pienen vaihtovirtasignaalin EKG-elektrodien
kautta impedanssihengityksen mittaamiseksi.

**STP-kortti** (*SpO₂/Temperature/Pressure board*) käsittelee pulssioksimetrian,
lämpötilan ja invasiiviset paineet. Nimi kertoo suoraan vastuualueet. Kortilla on
oma mikroprosessori sekä erillinen vakiovirtalähde (38 µA) lämpötila-anturille.

**NIBP-kortti** (*NIBP board*) ohjaa verenpaineen ei-invasiivisen mittauksen
mekaanista puolta: pumppua, venttiileitä ja paineen seurantaa. Kortilla on
pysyvä muisti (*EEPROM*), johon kalibrointiarvot tallennetaan — ne säilyvät
laitteen koko elinkaaren ajan ja ovat luettavissa huoltoliitännän kautta.

Kukin kortti sisältää oman prosessorinsa, joka kommunikoi monitorin rungon kanssa
RS485-sarjaväylän kautta optisesti eristettyinä. Eristyksen korkea jänniteluokka
(6 kV) on osa sitä CF-luokan suojausketjua, joka estää vuotovirran kulkeutumista
potilaaseen.

---

## Kuusi mittauskanavaa syventävästi

### EKG ja impedanssihengitys

EKG (*elektrokardiografia*) perustuu siihen, että sydänlihaksen supistuminen syntyy
sähköisestä aktiopotentiaalista, joka kulkee erikoistuneita solujonoja pitkin ja
aiheuttaa pieniä jännite-eroja kehon pinnalle kiinnitettyjen elektrodien välille.
Standardi 12-kytkentäinen EKG käyttää kymmentä elektrodia, joista lasketaan
matemaattisesti 12 eri "kulmaa" sydämen sähköiseen toimintaan. Kliininen
monitorointi käyttää useimmiten kolmea tai viittä elektrodia ja valitsee niistä
parhaiten erottuvan kytkennän.

PSMP tukee kolmea suodatustilaa, jotka valitaan kliinisen tilanteen mukaan:

- **Monitorointisuodatin** (0,5–30 Hz): normaali potilasvalvonta, poistaa hitaan
  hengityksen aiheuttaman perusviivaelevaation ja korkeat häiriötaajuudet
- **Diagnostinen suodatin** (0,05–150 Hz): 12-kytkentäinen diagnostinen EKG, säilyttää
  ST-segmentin muodon tarkasti; vaaditaan kun haetaan infarktievidenssiä
- **ST-suodatin** (0,05–30 Hz): kompromissi — tarkempi ST-segmentti kuin
  monitorointisuodattimella, mutta parempi häiriönpoisto kuin diagnostisessa tilassa

Tahdistimen (*pacemaker*) havaitseminen on erillinen toiminto. Tahdistinpulssi on
lyhyt (alle 2 ms) mutta voimakas sähköinen piikki, jonka PSMP erottaa
nousunopeuteen (slew rate) perustuvilla piireillä. Tämä on tärkeää: jos tahdistinpiikki
tulkitaan QRS-kompleksiksi, syke lasketaan kaksinkertaiseksi.

**Impedanssihengitys** (*impedance respiration*) käyttää samoja elektrodeja kuin EKG —
lisälaitteita ei tarvita. ECG-kortti syöttää 31,25 kHz:n pienen vaihtovirtasignaalin
valittujen elektrodien kautta. Keuhkojen täyttyessä rintakehän tilavuus kasvaa ja
sähköinen vastus (*impedanssi*) muuttuu rytmisesti. PSMP mittaa tämän muutoksen
ja laskee siitä hengitystaajuuden. Viiden kytkentäisen EKG:n yhteydessä
impedanssimittaus tapahtuu aina R (Right = oikea käsi) - ja F (Foot = vasen jalka) 
-elektrodien välillä riippumatta siitä, mikä EKG-kytkentä on valittu näytölle.

### Pulssioksimetria

Pulssioksimetria (*pulse oximetry*, SpO₂) hyödyntää hemoglobiinin optisia ominaisuuksia.
Hapettunut hemoglobiini (HbO₂) ja hapeton hemoglobiini (Hb) absorboivat valoa eri
tavoin eri aallonpituuksilla: punaisella alueella (660 nm) hapettunut hemoglobiini
läpäisee valoa selvästi paremmin kuin hapeton, lähi-infrapuna-alueella (940 nm)
ero on pienempi mutta käänteinen. Tämä on fysiikan optiikasta tuttu Beer-Lambertin
laki sovellettuna biologiseen kudokseen (Mendelson & Ochs, 1988).

Anturi (*probe*) lähettää kahta aallonpituutta sormen läpi; vastakkaisella puolella
oleva fotodiodi mittaa, kuinka paljon kumpikin aallonpituus absorboituu. Laite
laskee näiden kahden absorption suhteen ja hakee empirisestä kalibrointikäyrästä
vastaavan happikyllästeisyysprosentin. Kalibrointikäyrä on mitattu terveillä
vapaaehtoisilla, joiden valtimoveren happikyllästeisyyttä on vaihdeltu hallitusti.

Pulssioksimetri mittaa nimenomaan **valtimoveren** happikyllästeisyyttä, koska laite
käyttää vain sykkeen tahdissa muuttuvaa signaalikomponenttia (*AC-komponentti*)
— laskimoveri ja kudos muodostavat tasaisen taustan (*DC-komponentti*), joka
suodatetaan pois. Ilman tätä erottelua mittaus heijastaisi
koko kudoksen hapetusta, ei pelkästään valtimoverta.

Rajoitukset ovat kliinisesti tärkeitä: laite tunnistaa vain kahta hemoglobiinilajia
(HbO₂ ja Hb). Häkämyrkytyksen karboksihemoglobiini (COHb) näyttää laitteelle
hapettuneelta hemoglobiinilta — SpO₂ voi olla 100 %, vaikka potilas on myrkyttyneenä.
Tämä ei ole laitevika; se on menetelmän fyysinen rajoite.

### Invasiiviset paineet

Invasiivinen painemittaus (*invasive blood pressure*, IBP) on tarkin jatkuvan
verenpaineen mittausmenetelmä. Katetri viedään verisuoneen — tyypillisesti värttinävaltimon (*radial artery*) — ja liitetään nestetäytteisen letkuston kautta painemuuntimelle (*pressure transducer*).

Painemuunnin on pietsoresistiivinen (*piezo-resistive*) laite: sen sisällä oleva
Wheatstone-silta muuntaa mekaanisen painemuutoksen sähköiseksi jännitteeksi.
PSMP:n STP-kortti syöttää muuntimelle vakiotasoisen 5 V:n jännitteen, ja muunnin
tuottaa ulos noin 25 µV per elohopeamillimetri painetta. Instrumentaatiovahvistin
vahvistaa tämän signaalin ennen A/D-muunnosta.

**Nollaus** (*zeroing*) on käsitteen ymmärtämiseksi keskeinen toimenpide. Painemuunnin 
mittaa ylipaineena suhteessa ilmanpaineeseen. Ennen mittauksen aloittamista muunnin avoidaan 
hetkeksi ilmakehään, ja PSMP asettaa senhetkisen ilmanpaineen nollaviitteeksi. 
Muunnin sijoitetaan sydämen tasolle, jotta nesteen hydrostaattinen paine ei vääristä lukemaa.
Vasta tämän jälkeen mitattu arvo kertoo varsinaisen valtimopaineen. Jos muunnin on eri korkeudella
kuin sydän (13 cm korkeusero aiheuttaa 10 mmHg virheen), paine-ero kompensoidaan siirtämällä muunnin sydämen tasolle — tämä on kliininen vakiokäytäntö. PSMP:ssä nollaus tehdään painamalla etupaneelin
Zero P1 tai Zero P2 -näppäintä.

PSMP mahdollistaa kahden invasiivisen paineen (P1 ja P2) samanaikaisen mittauksen.
Tyypillisiä sovelluksia tehohoidossa ovat valtimopaine ja keskuslaskimopaine samanaikaisesti.

### Lämpötila

Lämpötila mitataan NTC-vastuksen (*Negative Temperature Coefficient resistor*)
avulla. NTC-vastuksen ominaisuus on, että sen sähköinen vastus pienenee lämpötilan
noustessa — käänteinen ilmiö verrattuna tavalliseen metalliseen vastukseen. PSMP:n
STP-kortti syöttää anturille vakiovirran (38 µA) ja mittaa sen yli syntyvän jännitteen.
Koska virta on vakio, jännite heijastaa suoraan vastusta, josta saadaan lämpötila.

PSMP:ssä kalibrointi tehdään kahdella tunnetun lämpötilan
pistokkeella (25 °C ja 45 °C) — laite sovittaa mittauskäyrän näiden pisteiden kautta.

PSMP mittaa kaksi lämpötilaa samanaikaisesti (T1 ja T2), mikä mahdollistaa
esimerkiksi ydinlämpötilan ja perifeerisen lämpötilan vertailun.

### Ei-invasiivinen verenpaine

Ei-invasiivinen verenpaine (*Non-Invasive Blood Pressure*, NIBP) mitataan
oskillometrisella (*oscillometric*) menetelmällä — sama periaate kuin kotona
käytettävissä automaattiverenpainemittareissa, mutta lääkintäluokan tarkkuudella.

Mansetti (*cuff*) täytetään paineeseen, joka ylittää oletetun systolisen verenpaineen.
Sitten paine lasketaan hallitusti alas. Pulsaatiosta johtuva paine-aalto (*oscillation*)
välittyy mansettiletkun kautta PSMP:n NIBP-kortille. Laite havaitsee, millä paineella
pulsaatioamplitudi on suurimmillaan — tämä vastaa suunnilleen keskipainetta
(*mean pressure*). Systolinen ja diastolinen paine lasketaan algoritmisesti
amplitudin kasvamis- ja vähenemispisteistä. Menetelmä on tarkin säännöllisellä
sykkeellä; rytmihäiriöt ja liike lisäävät epävarmuutta.

NIBP-kortin pneumatiikka koostuu pumpusta, kahdesta venttiilistä (pulssiventtiili
ja turvaventtiili) ja kahdesta paineanturista (pääanturi ja turva-anturi). Turvapiiri
on erillinen itsenäinen piiri, joka purkaa mansettipaineen automaattisesti, jos
mittaus kestää liian kauan tai paine nousee liian korkeaksi — tämä on potilasturvallisuuden
kannalta olennainen vaatimus (IEC 60601-2-30).

---

## Toiminnallinen testaus — Lab 3:n näkökulma

Toiminnallinen testaus (*functional check*) on eri asia kuin sähköturvallisuustestaus —
sähköturvallisuustestaus varmistaa, ettei laite aiheuta sähköiskun vaaraa, kun taas
toiminnallinen testaus varmistaa, että laite **mittaa oikein**. Nämä kaksi testausta
täydentävät toisiaan, mutta ovat käsitteellisesti erillisiä.

> **Lab 3 — käytännön yhteys.** Lab 3:ssa testataan PSMP:n jokainen
> mittauskanava ProSim 8 -potilassimulaattorilla. Tämä osio selittää,
> *miksi* testiprotokolla on sellainen kuin on.

### Testauksen logiikka

Toiminnallinen testaus seuraa samaa logiikkaa kaikissa kanavissa:

1. **Kytkentä ja konfigurointi** — laite ja simulaattori kytketään, monitorin
   näyttö konfiguroidaan näyttämään testattava parametri
2. **Tunnettu syöte** — simulaattorille annetaan tarkasti määritelty signaali
   (esim. 80 bpm sinus-rytmi tai 200 mmHg staattinen paine)
3. **Vertailu** — monitorin näyttämää arvoa verrataan odotettuun; hyväksymisrajat
   ovat spesifikaatiossa
4. **Ääritilanteet** — testataan hälytykset (asystolia, apnea, johdon irtoaminen)
   eikä vain normaalitilanne

Filosofia on sama kuin ohjelmistojen yksikkötestauksessa: jokainen moduuli testataan
erikseen, tunnetuilla syötteillä, ennen kuin kokonaisjärjestelmä otetaan käyttöön
(Webster & Clark, 2010).

### EKG-testin rakenne

EKG-testi tarkistaa neljä asiaa järjestyksessä:

Normaali sinusrytmi — simulaattori tuottaa 80 bpm, 1 mV amplitudin. Monitorin
tulee näyttää 80 ± 5 bpm kaikissa 12 kytkennässä ilman kohinaa. Jos yhdessäkin
kytkennässä on kohinaa, vika on tyypillisesti joko kaapelissa tai elektrodin
kosketuksessa.

Tahdistinhavaitseminen — simulaattori tuottaa "Asynchronous Pacemaker Pulse".
Monitorissa tulee näkyä tahdistinpiikit (*pacemaker spikes*) EKG-käyrässä. Tämä
on tärkeä potilasturvallisuustesti: tahdistimet ovat yleisiä tehohoidossa, ja
laite, joka ei tunnista niitä, voi hälyttää väärin.

Asystolian havaitseminen — simulaattori simuloi asystolian. Monitorin tulee
aktivoida asystolia-hälytys. Tämä testaa hälytyslogiikkaa, ei pelkkää
mittauspiiriä.

Johdon irtoamisen havaitseminen (*leads off detection*) — yksi johto irrotetaan
simulaattorista. Monitorin tulee tunnistaa irronnut johto ja vaihtaa automaattisesti
parhaaseen käytettävissä olevaan kytkentään. Tämä on hyödyllinen kliininen
ominaisuus: johdon irtoaminen kesken tehohoidon ei aina aiheuta hälytystä, jos
monitori pystyy löytämään korvaavan kytkennän.

### Invasiivisen paineen testi

Invasiivisen paineen testissä on kaksi vaihetta:

**Nollaus ja staattinen paine** — simulaattori asetetaan ensin 0 mmHg:iin, jolloin
suoritetaan nollaus (Zero P1). Sen jälkeen simulaattori asetetaan 200 mmHg:iin.
Monitorin tulee näyttää 200 ± 10 mmHg. Jos lukema poikkeaa enemmän, kalibrointi
on tarpeen. Hyväksymisraja ± 10 mmHg (5 % virhettä 200 mmHg:n paineella) on
verrattavissa kliiniseen vaatimukseen.

**Paineaaltomalli** — simulaattori tuottaa valtimopaineaallon (*Arterial 120/80*).
Monitorin tulee näyttää systolinen ja diastolinen paine sekä pulsaatiokäyrä.
Käyrän muodon tarkistaminen on laadullinen testi: vääristynyt tai katkonainen
käyrä viittaa anturin vikaantumiseen.

### SpO₂-testi

SpO₂-toiminnallisuus tarkistetaan sormisimulaattorilla (functional SpO2 tester). 
Manuaalin päämenettely (kohta 3.4.6) käyttää oikeaa sormea, mutta note-osiossa mainitaan, että sormisimulaattori sopii toiminnalliseen tarkistukseen — tarkkuuden varmentaminen sillä ei ole mahdollista.

Tämä on funktionaalinen testi eikä tarkkuustesti —
täsmällinen tarkkuuden tarkistus vaatisi valtimoveren näytteenottoa, jota ei näissä harjoituksissa
tehdä.

### NIBP-testi

NIBP-testi on kolmivaiheinen:

Vuototesti (*leak test*) — mansetti kiedotaan jäykän sylinterin ympärille ja
järjestelmä paineistetaan 250 mmHg:iin. Paine ei saa laskea yli 6 mmHg yhden
minuutin aikana. Tämä testaa pneumatiikan tiiveyttä — vuoto vaikuttaisi mittaustarkkuuteen
ja pitkittäisi mittausaikaa.

Kalibroinnin tarkistus (*calibration check*) — verrataan NIBP-kortin mitattua painetta
manometrin lukemaan. Tulos tallennetaan huoltolomakkeelle.

Letkutunnistus — laitteen tulee tunnistaa eri letkutyypit (aikuinen/lapsi)
automaattisesti liittimen tunnisteiden perusteella. Jos lapsen letku (ilman
automaattista tunnistetta) kytketään, laite pyytää käyttäjää valitsemaan
täyttörajan manuaalisesti — potilasturvallisuusominaisuus.

---

## Kalibrointi — milloin ja miksi

Kalibrointi on eri asia kuin toiminnallinen testaus. Testaus *tarkistaa* mittaustarkkuuden;
kalibrointi *korjaa* sen, jos tarkistuksessa löydetään poikkeama.

PSMP:ssä kalibrointi on tarpeen kolmelle parametrille, ja kultakin on eri
trigger-ehdot:

**Invasiivinen paine** — kalibrointi suoritetaan, jos toiminnallisessa tarkistuksessa
200 mmHg:n lukema poikkeaa yli ± 10 mmHg:lla, tai jos painemuunnin vaihdetaan
uuteen. Kalibrointi tehdään vertaamalla PSMP:n lukemaa tarkistetun
manometrin lukemaan 200 mmHg:n paineella.

**Lämpötila** — kalibrointi suoritetaan, jos 37 °C:n lukema poikkeaa yli ± 0,1 °C.
Kalibrointivälineistö on kaksi pistoketta, joiden resistanssi vastaa tarkasti 25 °C
ja 45 °C:n lämpötiloja. Laite sovittaa mittauskäyrän näiden kahden pisteen kautta
— lineaarinen interpolointi NTC-vastuksen kalibroituun käyttäytymiseen.

**NIBP** — kalibrointi suoritetaan jokaisen suunnitellun huollon yhteydessä
(12 kuukauden sykli), jokaisen korjaavan huollon jälkeen ja aina, kun mittaustarkkuus
ei ole spesifikaation mukainen. NIBP-kalibrointi vaatii kalibrointisuojauksen
poistamisen (Auto On/Off ja Start/Cancel -näppäimet samanaikaisesti 3 s) — tämä
estää vahingossa tapahtuvan kalibrointimuutoksen normaalikäytön aikana.

Kaikki kalibrointiarvot tallentuvat NIBP-kortin EEPROM-muistiin ja säilyvät
myös virtakatkosten aikana. Tätä voi verrata auton ECU:n (moottorin ohjausyksikön)
oppimisarvoihin: ne tallennetaan pysyvään muistiin, jotta auto ei unohda kalibrointia
joka kerran kun se sammutetaan.

---

## Vikatilanteiden tulkinta

Laboratoriossa voi ilmaantua virheilmoituksia. Seuraava taulukko kattaa yleisimmät:

| Viesti | Sijainti | Todennäköinen syy | Ensitoimenpide |
|--------|----------|-------------------|----------------|
| `ECG measurements removed` | Viestikenttä | PSMP irrotettu tai yhteys katkennut | Tarkista moduulin istuvuus rungossa |
| `Faulty ECG cable` | Viestikenttä / käyräkenttä | EKG-kaapeli viallinen tai liitin märkä | Vaihda kaapeli; pidä liittimet kuivina |
| `RA/R lead off` | Käyräkenttä | Johto irronnut simulaattorista tai elektrodista | Tarkista johdon kiinnitys |
| `Artifact` | Käyräkenttä | Liikehäiriö tai defibrillaatio | Odota häiriön loppumista; tarkista kytkentä |
| `Zeroing` → `Zeroed` | P1/P2-parametri-ikkuna | Normaali nollaustoimenpide | Odota — tämä on odotettu tila |
| `Zero Failure` | P1/P2-parametri-ikkuna | Nollaus epäonnistui | Tarkista transducer-kaapeli ja liitäntä |
| `Ei Px-anturia` | Parametri-ikkuna | Invasiivisen paineen kanavaan ei ole kytketty anturia | Kytke adapterikaapeli P1/P2-liittimeen |
| `Select inflation limits` | NIBP-kenttä | Lapsen letku ilman automaattitunnistetta | Valitse manuaalisesti täyttöraja |
| `Check NIBP` | NIBP-kenttä | Mansetti ei tiivistä tai mittaus epäonnistui | Tarkista mansetin istuvuus ja letku |
| `Identical SpO2 modules` | Viestikenttä | Kaksi SpO₂-moduulia kytketty samanaikaisesti | Irrota ylimääräinen moduuli |

Yleisin virhetilanne on johdon tai kaapelin irtoaminen. Ennen syvempää
vianmääritystä kannattaa aina ensin tarkistaa kaikki fyysiset liitännät — sekä
PSMP:n etupaneelista että ProSim 8:n päästä.

---

## Manuaalin lukuopas — mistä löydät mitä

| Tarve | Manuaali | Osio |
|-------|----------|------|
| PSMP:n liittimet ja näppäimet | Frames and Modules Technical Manual | Luku 1.3.1 (Figure 5) |
| EKG-piirin toiminta | Frames and Modules Technical Manual | Luku 1.3.3 |
| SpO₂-mittausperiaate | Frames and Modules Technical Manual | Luvut 1.2.5 ja 1.3.4 |
| Toiminnallisen testauksen testiprotokolla | Frames and Modules Technical Manual | Luku 3.4 (3.4.2–3.4.8) |
| Invasiivisen paineen kalibrointi | Frames and Modules Technical Manual | Luku 4.1 |
| Lämpötilan kalibrointi | Frames and Modules Technical Manual | Luku 4.2 |
| NIBP-kalibrointi | Frames and Modules Technical Manual | Luku 4.3 |
| ECG-virheilmoitukset | Frames and Modules Technical Manual | Luku 5.4.1 |
| NIBP-virheilmoitukset | Frames and Modules Technical Manual | Luku 5.4.6 |
| Käytännön kytkennät valokuvineen | Pokharel (2024) | Luvut 2.1–2.2 ja 3.2.1 |

---

## Yhteys muihin kurssin dokumentteihin

- **Yleiskuvaus B650-järjestelmästä** → [b650-potilasvalvontamonitori.md](b650-potilasvalvontamonitori.md)
- **PSMP:n sähköturvallisuustestaus** → [esa615-sahkoturvallisuus.md](esa615-sahkoturvallisuus.md) ja Lab 2
- **ProSim 8:n parametrikohtainen simulaatiologiikka** → [prosim8-potilassimulaattori.md](prosim8-potilassimulaattori.md)
- **ProSim 8:n ohjelmointi Robot Frameworkilla** → [prosim8-robot-framework.md](prosim8-robot-framework.md)

---

## Viitteet

GE Healthcare. (2016). *Module Frames and Modules Technical Manual* (Order code
2062973-004). GE Healthcare. [PSMP-osio: Tab 2, s. 2-1–2-79]

IEC. (2010). *IEC 60601-2-30: Particular requirements for the basic safety and
essential performance of automated non-invasive sphygmomanometers*. International
Electrotechnical Commission.

Jubran, A. (1999). Pulse oximetry. *Critical Care, 3*(2), R11–R17.
https://doi.org/10.1186/cc341

Mendelson, Y., & Ochs, B. D. (1988). Noninvasive pulse oximetry utilizing skin
reflectance photoplethysmography. *IEEE Transactions on Biomedical Engineering,
35*(10), 798–805. https://doi.org/10.1109/10.7286

Pokharel, R. (2024). *Potilasmonitorien testausympäristö*. Metropolia
Ammattikorkeakoulu. [Saatavilla kurssin OMA-työtilasta]

Webster, J. G., & Clark, J. W. (Eds.). (2010). *Medical instrumentation: Application
and design* (4th ed.). Wiley.

---

*Potilasvalvonnan laitteet — TX00EY15 | Metropolia Ammattikorkeakoulu*
