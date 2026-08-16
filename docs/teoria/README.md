# Teoria-materiaalit — lukuopas

*Tämä dokumentti ohjaa sinut kurssin itseopiskelumateriaalien äärelle.
Lue se ensin — se säästää aikaa ja auttaa ymmärtämään, miksi kukin
dokumentti on olemassa ja milloin se kannattaa lukea.*

*Lukuaika noin 5 minuuttia.*

---

## Mitä nämä dokumentit ovat?

Kurssin opetussessiot järjestetään torstaisin viikoilla 1–4. Jokaista opetussessiota varten
on laadittu itseopiskeludokumentti, jonka on tarkoitus korvata perinteiset diat:
kun olet lukenut viikon dokumentin ennen opetussessiota, sinulla on käsitteellinen pohja
valmiina ja yhteinen aika voidaan käyttää kysymyksiin, demonstraatioihin ja
laitteiden kanssa työskentelyyn.

Dokumentit eivät ole tiivistelmiä dioista. Ne vastaavat kysymykseen *miksi*
ennen kuin vastaavat kysymykseen *miten* — ja ne on kirjoitettu niin, että
teksti valmistaa sinua lukemaan laitteiden manuaaleja, ei korvaamaan niiden lukemista.

Analogia: nämä dokumentit ovat kuin kartta ennen vaellusta. Kartta ei korvaa
maastoa — se auttaa sinua ymmärtämään, mitä tulet kohtaamaan.

---

## Lukujärjestys viikoittain

| Viikko | Dokumentti | Teema lyhyesti | Lukuaika | Labra |
|--------|-----------|----------------|----------|-------|
| 1 | [`viikko1-potilasvalvonta-yleisesti.md`](viikko1-potilasvalvonta-yleisesti.md) | Mitä on potilasvalvonta, vitaalitoiminnot, hälytykset, terveysteknologiainsinöörin rooli | ~20 min | Lab 1 |
| 2 | [`viikko2-sahkoturvallisuus.md`](viikko2-sahkoturvallisuus.md) | Miksi sähköturvallisuus on erityinen haaste terveydenhuollossa, mikroshokki, IEC 60601-1 ja IEC 62353 | ~15 min | Lab 2 |
| 3 | [`viikko3-toiminnallinen-testaus-ja-automaatio.md`](viikko3-toiminnallinen-testaus-ja-automaatio.md) | Toiminnallinen testaus vs. sähköturvallisuustestaus, potilassimulaattorin rooli, BTV-automaatio | ~15 min | Lab 3 |
| 4 | [`viikko4-testiautomaatio-ja-testitapaussuunnittelu.md`](viikko4-testiautomaatio-ja-testitapaussuunnittelu.md) | Laadukas testiautomaatio, hyvä testitapaus, Robot Framework, lääkinnällisten laitteiden testauksen kehitys | ~15 min | Lab 4 |

**Suositus:** lue viikon dokumentti päivää ennen opetussessiota. Kymmenen minuutin lukeminen
illalla antaa enemmän kuin sama aika opetussessiolla ilman kontekstia.

---

## Mistä kukin dokumentti kertoo — ja miksi siinä järjestyksessä?

Dokumentit muodostavat yhtenäisen ketjun. Jokainen viikko rakentuu edellisen päälle.

**Viikko 1** alkaa peruskysymyksestä: mitä potilasvalvonta on ja miksi sitä
tehdään? Dokumentti esittelee vitaalielintoiminnot (*vital signs*), potilasvalvontamonitorin
(*patient monitor*) käsitteen ja sen, minkä takia potilasvalvontamonitori on
lääkinnällinen laite (*medical device*) — ei tavallinen sähkölaite. Tuntitehtävän
ja Lab 1:n kannalta keskeistä on B650-monitorin ja sen PSMP-moduulin
(*Patient Side Module Pro*) hahmottaminen ennen kuin koskee laitteeseen.

**Viikko 2** siirtyy kysymykseen: onko laite *turvallinen*? Dokumentti selittää,
miksi sähköturvallisuus on terveydenhuollossa oma erityinen alansa — ei
yleisen sähköturvallisuuden sovellus, vaan oma vaatimustasonsa. Mikroshokki
(*microshock*) on viikon käsitteellinen ydin: se havainnollistaa, miten pienikin
virta voi olla hengenvaara, kun ihon suojaus häviää kajoavassa toimenpiteessä.
Lab 2 tekee tämän teorian käsin kosketeltavaksi ESA615-analysaattorilla.

**Viikko 3** esittää seuraavan kysymyksen: entä jos laite on turvallinen
mutta mittaa *väärin*? Tässä siirrytään toiminnalliseen testaukseen (*functional
testing*). Sähköturvallisuustestaus ja toiminnallinen testaus ovat kaksi erillistä,
toisiaan täydentävää ulottuvuutta — kumpikaan ei korvaa toista.
Viikko selittää myös, miksi toiminnallisessa testauksessa tarvitaan potilassimulaattori
(*patient simulator*) oikean potilaan sijaan, ja miten BTV-ohjelmisto automatisoi
testisekvenssin. Lab 3 yhdistää molemmat: ensin sähköturvallisuus, sitten
toiminnalliset testit PSMP-moduulille parametri kerrallaan.

**Viikko 4** tarkastelee, mitä laadukas testiautomaatio oikeastaan vaatii.
Yksittäinen manuaalinen tai automaattinen testi ei riitä — tarvitaan rakenteinen
testitapaus (*test case*), jäljitettävä dokumentaatio ja validoitu testausjärjestelmä.
Robot Framework (*keyword-driven testing framework*) osoittautuu hyväksi valinnaksi
juuri siksi, että sen avainsanapohjainen syntaksi on luettavissa myös ilman
ohjelmointitaustaa — laadunhallintaosaston asiantuntijalle ja auditoijalle.
Lab 4 toteuttaa tämän käytännössä: kirjoitetaan testiskripti, joka ohjaa
ProSim 8 -simulaattoria (*patient simulator*) sarjayhteydellä.

---

## Laite-dokumentit teoria-dokumenttien rinnalla

Teoria-dokumentit kattavat *miksi*-tason. Laitekohtaiset dokumentit
(`docs/laitteet/`) kattavat *miten*-tason: tekniset yksityiskohdat,
mittaussuureet, kytkentäjärjestykset ja käyttöliittymän loogiikan.

| Teoria-dokumentti | Laite-dokumentti |
|-------------------|-----------------|
| Viikko 1 | [`b650-potilasvalvontamonitori.md`](../laitteet/b650-potilasvalvontamonitori.md) |
| Viikko 2 | [`esa615-sahkoturvallisuus.md`](../laitteet/esa615-sahkoturvallisuus.md) |
| Viikko 3 | [`prosim8-potilassimulaattori.md`](../laitteet/prosim8-potilassimulaattori.md) |
| Viikko 4 | [`prosim8-robot-framework.md`](../laitteet/prosim8-robot-framework.md) — ja syventävästi [`b650-psmp-moduuli.md`](../laitteet/b650-psmp-moduuli.md) |

Suositeltu lukujärjestys kullekin viikolle: teoria-dokumentti ensin,
laite-dokumentti ennen labraan menoa tai sen aikana.

---

## Usein kysyttyjä kysymyksiä

**Pitääkö teoria-dokumentti lukea ennen opetussessiota vai sen jälkeen?**
Ennen. Dokumentti on suunniteltu pohjustamaan opetussessiota, ei kokoamaan sitä
jälkikäteen.

**Voiko teoria-dokumenttien tilalla lukea pelkät diat?**
Dioja ei jaeta erikseen — ne ovat tukiväline opetussessiolle, ei itsenäinen
opiskelumateriaali. Teoria-dokumentit ovat se kirjallinen materiaali, johon
kurssilla nojataan.

**Mistä löydän tuntitehtävät ja labraohjeistukset?**
Tuntitehtävät ja Lab 1–4 -ohjeistukset löytyvät OMAn työtilasta.

**Mistä tiedän, onko jokin asia riittävän syvällisesti ymmärretty?**
Hyvä mittari: pystytkö selittämään viikon keskeisen käsitteen ääneen
yhden lauseen analogialla ennen labraan menoa? Jos pystyt, teoria-pohja
on riittävä. Jos et, dokumentin uudelleenlukeminen auttaa enemmän kuin
labraohjeistuksen lukeminen etukäteen.

---

*Potilasvalvonnan laitteet — TX00EY15 | Metropolia Ammattikorkeakoulu*
