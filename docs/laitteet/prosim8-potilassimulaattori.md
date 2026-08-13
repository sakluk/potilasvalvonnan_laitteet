# Prosim 8 -potilassimulaattori ja toiminnallinen testaus

> **Lab 3 -ennakkoluettava.** Tämä dokumentti selittää, mikä potilassimulaattori
> on, mitä se simuloi ja miksi toiminnallinen testaus on osa huoltosykliä.
> Lab 3:n vaiheistus löytyy labraohjeistuksesta.

---

## Miksi toiminnallinen testaus tarvitaan?

Lab 2:ssa varmistettiin, että laite on *sähköisesti turvallinen* — siitä ei
vuoda vaarallisia virtoja. Turvallisuuden varmistaminen ei kuitenkaan kerro,
toimiiko laite *oikein*.

Toiminnallinen testaus (*functional check*) vastaa kysymykseen: **kun potilas
lähettää fysiologisen signaalin, näyttääkö monitori oikean arvon?** Esimerkki:
jos potilaan syke on 60 lyöntiä minuutissa, näyttääkö monitori lukemaa 60 —
vai 58, 63 tai ei mitään?

Toiminnallinen testaus kuuluu lääkintälaitteen huoltosykliin aina:
- käyttöönottovaiheessa (ennen ensimmäistä kliinistä käyttöä)
- säännöllisessä kunnossapidossa
- korjauksen jälkeen
- epäiltäessä mittausvirheitä

Lab 3:ssa testataan B650:n PSMP-moduuli käyttöönottotarkastuksen
periaatteella: visuaalinen tarkistus → sähköiset turvallisuustestit →
toiminnalliset testit → raportointi.

---

## Mikä on potilassimulaattori?

Toiminnallisessa testauksessa tarvitaan *tunnettu viitesignaali*: tiedettävä
tarkasti, mitä syötettiin laitteeseen, jotta voidaan arvioida, vastaako
mitattu tulos sitä.

Oikeaa potilasta ei voi käyttää tähän tarkoitukseen — potilaan fysiologia
vaihtelee, eikä syötettyä arvoa voi hallita. Sen sijaan käytetään
**potilassimulaattoria**: laitetta, joka generoi kalibroituja, toistettavia
sähköisiä signaaleja, jotka vastaavat eri fysiologisten parametrien
mittaussignaaleja.

Analogia: virityshankalin mittaaminen viritysmittarilla. Virityshankalo
tuottaa tunnetun 440 Hz:n sävelen; viritysmittari näyttää "A4". Jos mittari
näyttää 438 Hz tai ei mitään, siinä on vika. Prosim 8 on lääketieteellisen
elektroniikan virityshankalo — se tuottaa tunnetun fysiologisen signaalin ja
monitorin pitää näyttää oikea arvo.

**Fluke Prosim 8** (*Patient Simulator 8*) simuloi kaikki PSMP-moduulin
käyttämät parametrit:

- Sydänsähkökäyrä (EKG)
- Impedanssihengitys
- Pulssioksimetria (SpO2)
- Ei-invasiivinen verenpaine (NIBP)
- Invasiiviset paineet (IBP)
- Lämpötila

---

## PSMP-moduulin parametrit ja Prosim 8:n simulointi

### EKG (elektrokardiogrammi)

Sydän tuottaa solukalvopotentiaalien muutoksista johtuvan sähkökentän, joka
leviää koko kehoon. EKG-elektrodit mittaavat tätä potentiaalieroa kehon pinnalta.
Signaali on pieniamplitudinen (noin 1–5 mV) ja sen taajuussisältö on pääosin
0,05–150 Hz:n alueella (Webster, 2010).

Prosim 8 generoi tarkasti muotoiltuja EKG-aaltomuotoja elektrodiliitännöistä.
Testattavissa on normaali sinusrytmi eri syketaajuuksilla (esim. 30, 60, 120,
300 bpm), rytmihäiriöt (eteisvärinä, kammiovärinä, asystole) ja tahdistimen
piikit. Näiden avulla voidaan varmistaa, että monitorin EKG-kanal toistaa aaltomuodon
oikein ja laskettu syketaajuus vastaa simuloitua arvoa.

### Impedanssihengitys

Keuhkojen laajeneminen sisäänhengityksen aikana muuttaa rintakehän sähköistä
impedanssia. Monitori mittaa tätä muutosta käyttämällä samoja EKG-elektrodeja:
laite syöttää pienen korkeataajuisen virran elektrodien kautta ja mittaa
impedanssin vaihtelua hengitystahdin mukaan.

Prosim 8 simuloi impedanssimuutosta EKG-kanavassa. Testattavat arvot ovat
hengitysnopeuksia (esim. 15, 30, 60 hengitystä/min) ja apneaa (hengityspysähdys).

### SpO2 (pulssioksimetria)

Pulssioksimetri mittaa valtimoveren happikylläisyyttä (SpO2) optisesti.
Anturi lähettää punaista (660 nm) ja infrapunavaloa (940 nm) kudoksen läpi
ja mittaa absorptiota. Oksihemoglobiini ja deoksihemoglobiini absorboivat
valoa eri suhteissa — suhteen perusteella lasketaan SpO2 (Jubran, 2015).

Prosim 8 simuloi anturin optista signaaliparia sähköisesti (tai käyttäen
valmistajan simulaattorisormiholkkia). Testattavissa on eri SpO2-tasot
(esim. 70, 80, 90, 95, 98 %) ja erilaiset perfuusioindeksit.

### NIBP (ei-invasiivinen verenpaine)

Verenpainemansetti pumpataan yli systolisen paineen ja lasketaan hallitusti —
monitori analysoi mansetin painevaihteluita (oskillometria) tai kuuntelee
Korotkoff-ääniä ja laskee systolisen, diastolisen ja keskiarvopaineen.

Prosim 8 simuloi painevaihteluita mansetin liitäntäletkuun. Testattavissa on
eri verenpainearvoja (esim. 80/60, 120/80, 150/100 mmHg) ja epäsäännöllisiä
rytmejä, joilla arvioidaan monitorin algoritmin toimintaa.

### IBP (invasiiviset paineet)

Invasiivinen verenpaine mitataan suoraan valtimoon asetetulla katetrilla,
joka on liitetty nesteeseen täytettyä letkua pitkin painemuuntimeen
(*pressure transducer*). Muunnin muuttaa paineen sähköiseksi signaaliksi
(tyypillisesti μV/V-suhteena, 5 μV/V/mmHg).

Prosim 8 generoi vastaavan jännitesignaalin IBP-liitäntään. Testattavissa
on arteriapaine (tyypillinen muoto ja amplitudi), laskimopaine ja
kallonsisäinen paine eri arvoilla. Monitorin pitää näyttää oikeat systoliset,
diastoliset ja keskiarvopaineet.

### Lämpötila

Lääkintälaitteet käyttävät yleisimmin NTC-termistoreita tai
platinavastusantureita (Pt100) kehon lämpötilan mittaamiseen. Molemmat
muuttavat lämpötilan resistanssimuutokseksi.

Prosim 8 simuloi termistorin resistanssia tunnetuissa lämpötiloissa.
Testattavissa on eri lämpötila-arvoja (esim. 35,0, 37,0, 40,0 °C) sekä
Celsius- että Fahrenheit-skaalalla.

---

## Hyväksymiskriteerit: mitä "läpäisee testin" tarkoittaa?

Lähes kaikilla parametreilla monitorin näyttämä arvo saa poiketa simuloidusta
arvosta tietyn toleranssin verran — laite ei ole viallinen, vaikka näyttö
ei olisi täsmälleen sama kuin syötetty arvo.

Nämä toleranssirajat löytyvät **Hemodynamic Modules -manuaalista luvusta 3.4**.
Testauksen logiikka on:

```
Simuloitu arvo  →  Monitorin näyttämä arvo  →  Vertaa toleranssiin
                                                  ↓               ↓
                                               PASS            FAIL
                                          (normaali toiminta) (vaatii huoltoa)
```

Lab 3:n raportissa käytetään **Maintenance check form** -lomaketta
(Frames and Modules -manuaali, s. 93), johon kirjataan kunkin parametrin
simuloitu arvo, mitattu arvo ja tulos (PASS/FAIL).

---

## Prosim 8:n käyttö: etupaneeli lyhyesti

Prosim 8:n etupaneelin painikkeet ja liitännät parametreittain on kuvattu
valokuvineen **Pokharel (2024) luvussa 2.2**. Suoran simulaation
vaiheistus — miten kutakin parametria simuloidaan manuaalisesti napin painalluksilla
— löytyy **Pokharel (2024) luvusta 3.2.1**.

Labraohjeistuksessa (Lab 3) testaus tehdään Ch. 3.4.1 Setup -ohjeiden mukaan:
ensin tarkistetaan käytössä olevat kaapelit ja liitännät, sitten suoritetaan
testit parametri kerrallaan.

---

## Valmistautuminen Lab 3:een

| Materiaali | Luettava osio | Miksi |
|-----------|--------------|-------|
| **Hemodynamic Modules** | Ch. 3.2 (Visual inspections) | Visuaalisen tarkastuksen tarkistuslista |
| **Hemodynamic Modules** | Ch. 3.3 (Electrical safety tests) | PSMP:n sähköturvallisuustestit |
| **Hemodynamic Modules** | Ch. 3.4.1 (Setup) | Kytkentöjen tarkistus ennen funktionaalisia testejä |
| **Hemodynamic Modules** | Ch. 3.4 (Functional check) + toleranssitaulukot | Mitä arvoja odotetaan, milloin PASS/FAIL |
| **Hemodynamic Modules** | Ch. 3.4.8 (Test completion) | Miten testin lopuksi palautetaan laite alkutilaan |
| **Pokharel (2024)** | Luku 2.2 (Prosim 8:n liitännät) | Prosim 8:n etupaneelin liitännät tutuiksi |
| **Pokharel (2024)** | Luku 3.2.1 (suora simulaatio) | Miten parametreja simuloidaan käytännössä |
| **Prosim 8 User Manual** | Parametrikohtaiset ohjeet | Simulaattorin asetusten tarkistus |

---

## Viitekirjallisuus

Jubran, A. (2015). Pulse oximetry. *Critical Care*, 19(1), 272.
https://doi.org/10.1186/s13054-015-0984-8

Webster, J. G. (Ed.). (2010). *Medical instrumentation: Application and design*
(4th ed.). John Wiley & Sons.

---

*Potilasvalvonnan laitteet — TX00EY15 | Metropolia Ammattikorkeakoulu*
