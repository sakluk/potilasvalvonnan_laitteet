# GE CARESCAPE B650 — Käsitteellinen johdanto

*Tämä dokumentti on tarkoitettu luettavaksi ennen Potilasvalvonnan laitteet -kurssin
laboratoriotöitä (Lab 1–3). Tavoitteena on antaa käsitteellinen pohja, jonka varaan
manuaaleista löytyvä yksityiskohtainen tieto rakentuu — ei korvata manuaaleja.*

---

## Miksi potilasta valvotaan?

Potilasvalvonnan perusongelma on yksinkertainen: ihmiskeho lähettää jatkuvasti
mitattavia signaaleja, joiden muutokset voivat ennakoida henkeä uhkaavaa tilannetta —
mutta muutos voi tapahtua nopeasti ja milloin tahansa. Hoitohenkilökunta ei pysty
seuraamaan kaikkia parametreja yhtäaikaisesti silmämääräisesti. Potilasvalvontamonitori
ratkaisee tämän: se mittaa, tallentaa ja hälyttää automaattisesti, kun jokin arvo poikkeaa
asetetuista rajoista.

Seurattavat parametrit vaihtelevat kliinisen ympäristön mukaan. Tehohoidossa seurataan
kaikkea jatkuvasti ja tarvittaessa kajoavasti; vuodeosastolla riittää väljempi, ajoittainen
mittaus. Tämä vaatimus ohjaa suoraan laitteen suunnittelua.

---

## Modulaarinen rakenne

CARESCAPE B650 on **modulaarinen** potilasvalvontamonitori. Se koostuu kahdesta
pääosasta: **rungosta** (*frame*) ja siihen liitettävistä **mittausmoduuleista**.

Runko sisältää näytön, prosessointiyksikön, tallennuksen ja verkkoyhteyden — se on
laitteen "aivot ja kasvot". Moduulit ovat erikoistuneita mittausyksiköitä, jotka kytketään
runkoon tilanteen ja potilaan tarpeen mukaan. Analogia arkielämästä: runko on kuin
älypuhelin ja moduulit kuin siihen liitettävät lisälaitteet — kamera, sykemittari,
verenpainemittari. Puhelin toimii ilman kaikkia lisälaitteita, mutta vain liitettynä se
hyödyntää täyden kapasiteettinsa.

Modulaarisuus on käytännöllinen ratkaisu: sama runkolaite voidaan konfiguroida eri
erikoisaloille vaihtamalla moduulit. Tämä vähentää hankintakustannuksia ja
yksinkertaistaa huoltoa.

Tällä kurssilla keskeinen moduuli on **PSMP** (*Patient Side Module Pro*). Siihen
kytketään suurin osa potilassignaaleista.

---

## Mitattavat parametrit

PSMP-moduli mahdollistaa seuraavien parametrien mittauksen. Jokaisen parametrin
kohdalla on tärkeää ymmärtää sekä mitä mitataan että millä fysiologisella ilmiöllä
mittaus perustuu.

**EKG (elektrokardiografia)** mittaa sydänlihaksen sähköistä toimintaa ihon pinnalle
kiinnitettyjen elektrodien kautta. Monitori analysoi signaalia reaaliaikaisesti ja voi
tunnistaa rytmihäiriöitä automaattisesti. EKG on kurssin kannalta keskeinen parametri:
se on sekä kliinisesti tärkein yksittäinen signaali että monimutkaisin analysoida.

**Impedanssihengitys** hyödyntää samoja elektrodeja kuin EKG. Keuhkojen täyttyessä
ilmalla rintakehän tilavuus — ja sen mukana sähköinen vastus eli impedanssi — muuttuu
rytmisesti. Laite havaitsee tämän muutoksen ja laskee sen perusteella hengitystaajuuden.
Menetelmä on yksinkertainen mutta riittävä apnean valvontaan.

**SpO2 (pulssioksimetria)** mittaa valtimoveren happikyllästeisyyttä optisesti.
Hapettunut ja hapeton hemoglobiini absorboivat eri aallonpituuksia valoa eri tavoin;
anturi lähettää kaksi eri aallonpituutta sormen läpi ja laskee suhteen. Sama periaate
toimii kuin värisuodatin: hapettunut veri näyttää punaiselta, hapeton tummemmalta.

**Ei-invasiivinen verenpaine (NIBP)** mitataan olkavarrelle laitettavan painehihnalla,
samoin kuin perinteisessä verenpainemittauksessa. B650 suorittaa mittauksen
automaattisesti asetetuin väliajoin ja tallentaa systolisen, diastolisen ja
keskiverenpaineen.

**Invasiiviset paineet (IBP)** mitataan suoraan verisuoneen viedyn katetrin ja
nestetäytteisen letkuston kautta painemuuntimelle. Menetelmä on tarkempi ja jatkuva,
mutta vaatii kajoavan toimenpiteen. IBP:tä käytetään tyypillisesti tehohoidossa ja
leikkaussaleissa.

**Lämpötila** mitataan ihoanturilla tai kehon onteloon viedyllä anturilla. B650 tukee
useita mittauspisteitä samanaikaisesti.

---

## Testausympäristö: B650, ESA615 ja Prosim 8

Laboratoriossa käytetään kolmea laitetta yhdessä. Niiden roolit ovat erilaiset ja
täydentävät toisiaan.

**GE CARESCAPE B650** on testauksen kohde — laite, jonka toiminta ja turvallisuus
halutaan varmistaa.

**Fluke ESA615** (*Electrical Safety Analyzer*) on sähköturvallisuusanalysaattori.
Sillä varmistetaan, että B650 täyttää lääkinnällisille laitteille asetetut
sähköturvallisuusvaatimukset: suojamaadoitusresistanssi on riittävän pieni, eristys
riittävän hyvä ja vuotovirrat riittävän pienet, etteivät ne vaaranna potilasta.
ESA615 on laite, jolla *testataan* B650:tä — se ei ole osa potilasvalvontaa.

**Fluke Prosim 8** on potilassimulaattori. Se tuottaa sähköisiä signaaleja, jotka
jäljittelevät oikeaa potilasta: EKG-signaali, verenpainepulssi, SpO2-signaali,
lämpötila-arvo ja niin edelleen. Prosim 8 kytketään B650:n moduuliin aivan kuten
oikea potilas kytkettäisiin — ja antaa mahdollisuuden testata monitorin toiminta
hallitusti ja turvallisesti ilman oikeaa potilasta.

Analogia lentoturvallisuudesta: lentokonesimulaattori mahdollistaa kaikkein
harvinaisimpienkin vikatilanteiden harjoittelun turvallisesti. Samasta syystä
lääkintälaite testataan potilassimulaattorilla — myös ääritilanteet voidaan simuloida
ilman riskiä.

---

## Teknisten manuaalien lukeminen

Lääkintälaitteiden tekninen dokumentaatio on ensisijainen tietolähde laitteen kanssa
työskenteleville ammattilaisille. Yksi kurssin keskeisistä taidoista on oppia lukemaan
teknisiä manuaaleja tehokkaasti. **Tätä taitoa ei voi oppia muuten kuin harjoittelemalla
— ja labrat ovat harjoitteluympäristö.**

Tekninen manuaali ei ole luettavaksi kannesta kanteen. Se on hakuteos, joka noudattaa
vakiintunutta rakennetta:

| Osio | Sisältö |
|------|---------|
| Safety / Turvallisuus | Luetaan aina ensin |
| Installation / Asennus | Kytkennät, tilavaatimukset, liitännät |
| Operation / Käyttö | Normaalikäytön ohjeet |
| Maintenance / Huolto | Säännöllinen testaus ja ylläpito |
| Service / Korjaus | Vianmääritys, varaosatiedot |
| Appendices / Liitteet | Testauslomakkeet, spesifikaatiot, hyväksymisrajat |

Labraohjeistuksissa viitataan aina tiettyihin lukuihin ja sivuihin. Ennen labraan menoa
avaa manuaali kyseiseen lukuun, lue se läpi ja muodosta kuva siitä, mitä tullaan
tekemään — vasta labrassa seurataan ohjeita askel kerrallaan.

B650:lle on kolme keskeistä manuaalia:

- **CARESCAPE Monitor B650 User Manual** — käyttäjille tarkoitettu, kuvaa normaalikäytön
- **CARESCAPE Monitor B650 Technical Manual** — huollolle ja lääkintätekniikalle, kuvaa
  testauksen ja huollon
- **GE Healthcare Frames and Modules Technical Manual** — kattaa moduulikohtaisen
  testauksen; aliosio *Hemodynamic Modules* koskee PSMP-moduulia

Kurssin OMA-työtilasta löytyy lisäksi **Pokharel (2024): Potilasmonitorien
testausympäristö** — Metropolia-opiskelijan projektityö, joka kattaa laboratorion
laitteiden liitännät, sähköturvallisuustestauksen käytännön toteutuksen ja
Prosim 8:n ohjauksen. Siitä on hyötyä erityisesti ennen Lab 1-, Lab 2- ja
Lab 3 -sessioita sekä kytkentöjen tarkistamisessa labrassa.

---

## Valmistautuminen laboratoriotöihin

Alla olevassa taulukossa on ohje siihen, mitä B650-dokumentaatiosta kannattaa lukea
ennen kutakin labraa. Tavoitteena ei ole lukea kaikkea — tavoitteena on löytää oikea
kohta ja ymmärtää se ennen labraan saapumista.

| Labra | Luettava osio |
|-------|--------------|
| Lab 1: Tutustuminen laitteisiin | B650 User Manual luvut 1–2 (yleiskuvaus, moduulit); Pokharel (2024) luvut 2.1–2.2 (laitteiden osat, liitännät, valokuvat) |
| Lab 2: Sähköturvallisuusmittaukset | B650 Technical Manual luvut 5.1–5.2; SFS-EN 62353 luku 5; Pokharel (2024) luku 3.1 (mittausjärjestys ja toimenpiteet valokuvineen) |
| Lab 3: Parametrimodulin testaus | Frames and Modules Technical Manual — Hemodynamic Modules luvut 3.2–3.4; Pokharel (2024) luku 3.2.1 (EKG-, SpO2-, lämpötila-, NIBP-simulaatio vaiheistus) |

---

*Potilasvalvonnan laitteet — TX00EY15 | Metropolia Ammattikorkeakoulu*
