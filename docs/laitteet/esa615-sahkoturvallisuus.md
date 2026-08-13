# Lääkintälaitteiden sähköturvallisuus ja ESA615-analysaattori

> **Lab 2 -ennakkoluettava.** Tämä dokumentti selittää Lab 2:n mittausten
> fysikaaliset ja standardiperusteet. Labraohjeistuksessa viitataan tiettyihin
> standardin lukuihin — tämä dokumentti selittää *miksi* ne ovat siellä.

---

## Miksi sähköturvallisuus on erityisen kriittistä terveydenhuollossa?

Kotitaloussähkölaitteille on omat sähköturvallisuusstandardit — esimerkiksi
IEC 60335 kodinkoneiden osalta — jotka asettavat vaatimuksia eristykselle,
suojamaadoitukselle ja ylivirtasuojaukselle. Nämä vaatimukset on kuitenkin
laadittu olettaen, että käyttäjä on terve, tajuissaan ja liikuntakykyinen.
Lääkintälaitteiden standardi IEC 60601-1 asettaa merkittävästi tiukemmat
vaatimukset, koska terveydenhuollon ympäristössä lähtöoletukset ovat toiset:

- **Potilas ei välttämättä pysty reagoimaan** — sedaatio, anestesia tai
  tiedottomuus poistaa suojaavan refleksin.
- **Ihon resistanssi on alentunut** — kostea iho, elektrodit, suonensisäiset
  katetrit tai suoraan sydämeen johtavat mittajohdot ohittavat ihon luontevan
  suojaavan resistanssin.
- **Sydän on erityisen herkkä** — kammiovärinän voi aiheuttaa jo muutaman
  kymmenen mikroampeerin (μA) suuruinen virta, jos se kulkee suoraan sydämen
  läpi. Tämä on mikroshokki-ilmiö, jota käsitellään tarkemmin alla.

Analogia: tavallisessa rakennuksessa sähkö virtaa putkissa, ja pienetkin vuodot
menevät huomaamatta maahan. Terveydenhuollossa "putket" päättyvät suoraan
potilaan vereen tai sydänlihakseen — vuoto, joka muualla olisi vaaraton, voi
täällä olla tappava.

> Mikroshokki-ilmiö: normaalin ihon kautta tarvitaan noin 50–100 mA sydämen
> kammiovärinän aiheuttamiseen. Suoraan sydämen kautta (esim. invasiivinen
> painerekisteröinti tai sydänkatetri) raja on vain 10–100 μA — tuhatkertainen
> ero (Webster, 2010, luku 14).

---

## Laiteluokittelu: B, BF ja CF

IEC 60601-1 -standardi luokittelee lääkintälaitteiden liityntäosat sen mukaan,
kuinka lähelle sydäntä ne voivat joutua. Luokka määrää sallitun vuotovirran
enimmäisarvon.

| Luokka | Merkitys | Esimerkit | Sallittu potilaan vuotovirta (AC, normaali) |
|--------|---------|-----------|---------------------------------------------|
| **B** (Body) | Liityntäosa kehon lähellä, ei suorassa sähköisessä yhteydessä | Ultraäänilaite potilaan päällä | 100 μA |
| **BF** (Body Floating) | Eristetty liityntäosa kosketuksessa potilaan pintaan | EKG-elektrodit, SpO2-sensori, NIBP-mansettijohdot | 100 μA |
| **CF** (Cardiac Floating) | Eristetty liityntäosa, joka voi olla suorassa sydämen lähellä | IBP-katetrijohdot, defibrillaattorin sisäiset johdot | **10 μA** |

PSMP-moduulissa B650:ssa on sekä BF- (EKG, SpO2, impedanssihengitys, NIBP)
että CF-luokan (IBP, invasiivinen verenpaine) liityntäosia. Tämä on syy, miksi
moduulia testataan erikseen.

---

## Mitattavat suureet ja niiden fyysiset perusteet

### Suojamaadoitusresistanssi

Laitteen metallinen kuori on kytketty suojamaadoitusjohtimeen. Jos laitteen
sisällä tapahtuu eristysvika — esimerkiksi ylikuumentunut johdin koskettaa
metallikuorta — vika-virta saa kaksi reittiä: kuoren kautta maahan tai käyttäjän
tai potilaan kautta maahan.

Suojamaadoituksen tehtävä on tarjota niin matala resistanssi, että lähes kaikki
vikavirtaenergia ohjautuu maahan — ei ihmisen läpi. Matala resistanssi myös
sulattaa sulakkeen nopeasti.

**Mittauksella** varmistetaan, että suojamaadoitusjohdin on ehjä ja liitokset
hyvässä kunnossa. SFS-EN 62353 antaa raja-arvon; löydät sen standardin
taulukosta 1.

### Eristysvastus

Sähkölaitteen jännitteisten osien ja metallisen kuoren välillä on eriste
(muovi, lasi, ilmaväli). Tämä eriste estää vuotovirran.

Eristysvastus mitataan syöttämällä laitteen kytkettyihin virtajohtimiin ja
kuoreen tasajännitettä (tyypillisesti 500 V DC) ja mittaamalla, kuinka paljon
virtaa kulkee eristeen läpi. Korkea eristysvastus (MΩ-luokka) tarkoittaa
hyvää eristettä.

**Huom:** Eristysvastusta ei aina voida mitata kaikille laitteille
— jotkut elektroniikkakomponentit eivät kestä testijännitettä. Lab 2:ssa
arvioidaan, soveltuuko mittaus B650:lle (ks. ESA615 manual s. 27).

### Vuotovirrat

Vuotovirta on sähkövirta, joka kulkee *tarkoituksettomia reittejä* — eristeiden
läpi, kapasitiivisesti tai induktiivisesti. Kahta tyyppiä mitataan Lab 2:ssa:

**Laitevuotovirta** (*earth leakage*): virta, joka virtaa laitteen verkkojännitteisistä
osista kuoren ja maadoituksen kautta. Tämä kertoo laitteen yleisestä
eristyslaadusta.

**Liityntäosan vuotovirta** (*patient leakage*): virta, joka voi kulkea
potilaaseen kytkettyjen elektrodien tai mittajohtimien kautta. Tämä on
kliinisesti tärkein mittaus — se kertoo suoraan, millaiselle virralle
potilas voisi altistua.

Tyypin CF-liityntäosille (IBP) raja on kymmenkertainen tiukempi kuin B/BF:lle,
koska suoraan sydämen lähelle johtavissa reiteissä pienikin virta voi olla
vaarallinen.

---

## SFS-EN 62353: toistuva testaus käytännössä

Lääkintälaite testataan kattavasti ensimmäistä markkinoillelaskua varten
IEC 60601-1 -standardin mukaan — tämä on valmistajan vastuulla. Käytössä olevat
laitteet testataan toistuvasti huollon ja korjausten yhteydessä, ja tähän
käytetään **SFS-EN 62353** -standardia.

SFS-EN 62353 on suunniteltu kentällä tehtäviksi, nopearytmisiksi tarkastuksiksi.
Sen rakenne:

| Luku | Sisältö |
|------|---------|
| 5.1 | Visuaalinen tarkistus |
| 5.2 | Suojamaadoitusvastus |
| 5.3.2 | Suojamaadoitusresistanssin mittaus (menetelmät) |
| 5.3.3 | Eristysvastuksen mittaus |
| 5.3.4 | Vuotovirtojen mittaus |
| 5.4 | Toiminnallinen testaus |
| 6 | Dokumentointi ja raportointi |
| Liite B | Suositeltava testausjärjestys |
| Liite G | Esimerkki testausasiakirjasta |

Lab 2:n testausjärjestys noudattaa suoraan standardin liitettä B.

---

## ESA615 -analysaattori testaustyökaluna

Fluke ESA615 on lääkintälaitteiden sähköturvallisuustestaukseen suunniteltu
mittalaite. Se yhdistää useita mittauksia yhteen laitteeseen:

- Verkkojännitteen mittaus (network voltage)
- Suojamaadoitusvastuksen mittaus
- Eristysvastuksen mittaus
- Vuotovirtojen mittaus (earth leakage, patient leakage eri liityntäosille)

ESA615:ssa on valmiita testisekvenssejä (*automated test sequences*), joissa
laite suorittaa mittaukset automaattisesti yksi kerrallaan ilman manuaalista
vaihtamista. Lab 2:ssa vertaillaan, onko valmiin sekvenssin käyttö mahdollista
ja riittävää B650:n testaamiseen.

**Paneelit ja liitännät:** ESA615:n etupaneelin liittimet, painikkeet ja
näyttö on kuvattu yksityiskohtaisesti valokuvineen Pokharel (2024) luvussa 2.1.2.
**Manuaalinen testausvaiheistus** valokuvineen löytyy Pokharel (2024) luvusta 3.1.

---

## Valmistautuminen Lab 2:een

Ennen labraan tuloa lue seuraavat osiot. Tavoite: tule labraan tiedostaen,
*mitä mitataan ja miksi* — vaiheistus selvitetään labraohjeistuksessa
askel kerrallaan.

| Materiaali | Luettava osio | Miksi |
|-----------|--------------|-------|
| **SFS-EN 62353** | Luku 5 (testausmenetelmät) ja liite B (testausjärjestys) | Ymmärrät mittausjärjestyksen logiikan |
| **SFS-EN 62353** | Taulukko 1 (raja-arvot) | Tiedät, mihin tuloksia verrataan |
| **B650 Technical Manual** | Luku 5.1 (Visual Inspection) | Visuaalisen tarkastuksen tarkistuslista |
| **B650 Technical Manual** | Luku 5.2 (Electrical safety tests) | Laitevalmistajan testausvaatimukset |
| **Pokharel (2024)** | Luku 2.1.2 (ESA615:n liitännät ja painikkeet) | ESA615:n paneelit tutuiksi ennen labraa |
| **Pokharel (2024)** | Luku 3.1 (sähköturvallisuustestauksen vaiheistus) | Käytännön kytkentäjärjestys valokuvineen |
| **ESA615 Users Manual** | s. 27 (Insulation resistance test) | Eristysvastustestin soveltuvuuden arviointi |

---

## Viitekirjallisuus

IEC 60601-1:2005+AMD1:2012+AMD2:2020. *Medical electrical equipment — Part 1:
General requirements for basic safety and essential performance*. International
Electrotechnical Commission.

SFS-EN 62353:2014. *Sähkökäyttöiset terveydenhuollon laitteet. Toistuva ja
korjauksen jälkeinen testaus*. Suomen Standardisoimisliitto SFS.

Webster, J. G. (Ed.). (2010). *Medical instrumentation: Application and design*
(4th ed.). John Wiley & Sons.

---

*Potilasvalvonnan laitteet — TX00EY15 | Metropolia Ammattikorkeakoulu*
