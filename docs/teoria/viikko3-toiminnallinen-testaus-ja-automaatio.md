# Viikko 3 — Toiminnallinen testaus, simulointi ja automaatiotestaus

*Tämä dokumentti on tarkoitettu itsenäisesti luettavaksi ennen kurssin kolmatta
luentoa ja Lab 3:a. Viikko 1 alusti potilasvalvonnan peruskäsitteet ja viikko 2
sähköturvallisuuden vaatimukset. Tässä dokumentissa siirrytään seuraavaan
kysymykseen: miten varmistetaan, että laite mittaa oikein — ja miten tämä testaus
tehdään systemaattisesti? Laitekohtainen kuvaus Prosim 8 -potilassimulaattorista
löytyy erillisestä dokumentista
[`docs/laitteet/prosim8-potilassimulaattori.md`](../laitteet/prosim8-potilassimulaattori.md).*

*Lukuaika noin 15 minuuttia.*

---

## Miksi sähköturvallisuustestaus ei kerro, toimiiko laite oikein?

Lab 2:ssa varmistettiin, että B650-potilasvalvontamonitorin PSMP-moduulista ei
vuoda vaarallisia virtoja potilaaseen. Tämä on välttämätön edellytys laitteen
käytölle — mutta ei riittävä. Sähköturvallisuustestaus vastaa kysymykseen *onko
laite turvallinen*, ei kysymykseen *mittaako laite oikein*.

Periaate on helppo hahmottaa yksinkertaisen analogian avulla: mittanauha, jonka
metallihaka on irronnut, on täysin turvallinen käyttää — siitä ei tule sähköiskua
eikä se aiheuta palovammoja. Mutta se mittaa väärin, koska irronneen haan tyhjä
tila lisää muutaman millimetrin jokaisen mitan alkuun. Lääkinnällisessä laitteessa
vastaava tilanne voi olla vakava: jos potilasmonitori näyttää happisaturaationa
95 % mutta todellinen arvo on 88 %, hoitohenkilökunta tekee päätöksensä
virheellisen tiedon pohjalta.

Tätä ongelmaa varten on olemassa oma testauksen muotonsa: toiminnallinen testaus
(*functional check* tai *performance testing*). Sen tehtävä on varmistaa, että
laite antaa oikean vastauksen, kun sille syötetään tunnettu signaali. Sähköturvallisuus ja toiminnallisuus ovat siis kaksi erillistä, toisiaan täydentävää testauksen ulottuvuutta — kumpikaan ei korvaa toista. Terveysteknologiainsinööriltä edellytetään molempien hallintaa.

---

## Mitä on toiminnallinen testaus — ja milloin se tehdään?

Toiminnallinen testaus tarkoittaa, että laitteelle syötetään tunnettu testitilanne
ja varmistetaan, vastaako laitteen tulos odotettua. Potilasvalvontamonitorin
kohdalla tämä tarkoittaa käytännössä: simuloidaan potilaaseen kytketyt fysiologiset
signaalit kontrolloituina arvoina ja tarkastetaan, näyttääkö monitori oikeat
lukemat.

IEC 62353 -standardi (*Medical electrical equipment — Recurrent test and test after
repair*) määrittelee, milloin toiminnallinen testaus on tehtävä. Standardi
tunnistaa kolme pääasiallista tilannetta. Ensimmäinen on laitteen käyttöönotto:
ennen ensimmäistä kliinistä käyttöä on varmistettava, että laite toimii
spesifikaatioidensa mukaisesti. Toinen on säännöllinen kunnossapitotestaus, jonka
väli vaihtelee laitteen riskitason ja valmistajan ohjeiden mukaan. Kolmas on
korjauksen jälkeinen testaus: ennen kuin laite palautetaan kliiniseen käyttöön,
on varmistettava, ettei korjaus ole vaikuttanut laitteen suorituskykyyn haitallisesti.

Testauksen laajuus ei ole vakio — se riippuu laitteen kriittisyydestä, korjauksen
tai muutoksen laajuudesta ja paikallisista ohjeistuksista. Terveysteknologiainsinööri
arvioi kunkin tilanteen erikseen: tämä ei ole puhtaasti tekninen päätös vaan
yhdistelmä teknistä osaamista ja kliinistä ymmärrystä.

Lab 3:ssa tehtävä testaus noudattaa käyttöönottotarkastuksen rakennetta: ensin
visuaalinen tarkastus, sitten sähköturvallisuustestit (IEC 62353 mukaisesti) ja
lopuksi toiminnalliset testit PSMP-moduulin jokaiselle mitattavalle suureelle.

---

## Miksi toiminnallisessa testauksessa tarvitaan simulaattori?

Toiminnallisen testauksen ydin on tunnettu viitesignaali: testaajan täytyy tietää
täsmälleen, mikä signaali laitteeseen syötetään, jotta hän voi arvioida, vastaako
laitteen antama tulos sitä.

Ensimmäinen mieleen tuleva vaihtoehto — oikean potilaan käyttäminen — on sekä
eettisesti että teknisesti mahdoton. Eettinen ongelma on selvä: testitilanne ei
saa vaarantaa potilaan hoitoa eikä kuormittaa potilasta tarpeettomasti. Tekninen
ongelma on se, että potilaan fysiologia ei ole kontrollissa. Sydämen syke vaihtelee
hengityksen, liikkeen ja jännityksen mukaan; verenpaine muuttuu asennonvaihdosten
seurauksena. Todellista fysiologista signaalia ei voi "lukita" tunnettuun arvoon,
eikä sama tilanne toistu täsmälleen samanlaisena kahden testauskerran välillä.

Tästä syystä toiminnallisessa testauksessa käytetään potilassimulaattoria: laitetta,
joka generoi kalibroituja, toistettavia sähköisiä signaaleja, jotka jäljittelevät
potilaan fysiologisia mittaussignaaleja. Simulaattorin tuottama signaali on tarkasti
tunnettu — esimerkiksi syketaajuus tasan 60 lyöntiä minuutissa, systolinen paine
120 mmHg — ja se pysyy vakiona koko testauksen ajan.

Simulaattori on itse kalibroitu: sen tuottamien arvojen tarkkuus on todennettu
kalibrointilaboratoriossa ja kalibrointi on jäljitettävissä (*traceable*) kansallisiin tai kansainvälisiin mittanormaaleihin. Tämä jäljitettävyys on edellytys sille, että testitulos on pätevä. Vain kalibroitu referenssi voi toimia luotettavana vertailukohtana — jos simulaattorin oma tarkkuus on epävarma, koko testauksen tulos on epävarma. Tästä syystä myös simulaattorin kalibrointi on uusittava säännöllisesti.

---

## Mitä tarkoittaa hyväksymisraja — ja miten se päätetään?

Toiminnallisessa testauksessa mitattu tulos ei koskaan ole täsmälleen sama kuin
simuloitu viitearvo. Tämä ei tarkoita, että laite on viallinen: kaikissa mittauksissa
on epävarmuutta, ja molemmissa — sekä simulaattorissa että monitorissa — on omat
mittausvirheensä. Kysymys on, kuinka paljon poikkeamaa voidaan hyväksyä.

Hyväksymisraja (*acceptance limit* tai toleranssi) on valmistajan tai standardin
määrittelemä suurin sallittu poikkeama simuloidun ja mitatun arvon välillä.
Esimerkiksi EKG:n syketaajuudessa sallittu poikkeama voi olla ±2 lyöntiä minuutissa,
happisaturaatiossa ±2 prosenttiyksikköä. Nämä rajat eivät ole satunnaisia: ne
perustuvat laitteen teknisiin suorituskykyspesifikaatioihin sekä kliiniseen arvioon
siitä, minkä suuruinen poikkeama on hoitopäätösten kannalta merkityksellinen.
Pienet kalibrointivirheet, jotka eivät vaikuta hoitopäätöksiin, ovat hyväksyttäviä;
suuremmat, joilla voisi olla kliinistä merkitystä, eivät ole.

Testitulos on joko PASS tai FAIL: joko mitattu arvo on hyväksymisrajojen sisällä
tai se ei ole. FAIL ei tarkoita automaattisesti, että laite on poistettava käytöstä
— se tarkoittaa, että tilanne on arvioitava. Laite on mahdollisesti kalibroitava,
korjattava tai poistettava käytöstä riippuen poikkeaman suuruudesta ja laitteen
kriittisyydestä. Terveysteknologiainsinöörin tehtävä on tehdä tämä arvio
ammatillisesti, dokumentoida se ja toimia sen mukaisesti.

Lab 3:ssa käytetään Hemodynamic Modules -manuaalin toleranssitaulukoita kunkin
parametrin hyväksymisrajojen tarkistamiseen ja tulokset kirjataan Maintenance
check form -lomakkeelle.

---

## Mitä BTV tekee — ja miksi sähköturvallisuustestaus automatisoidaan?

Lab 2:ssa sähköturvallisuustestaus tehtiin manuaalisesti: testaaja valitsi
ESA615-analysaattorista mittauksen kerrallaan, odotti tuloksen ja siirtyi
seuraavaan. Tämä tapa on opetuskäytössä perusteltu — se pakottaa ymmärtämään,
mitä kukin mittaus tekee ja miksi se tehdään. Käytännön lääkintätekniikassa tilanne
on toinen.

Suuressa sairaalassa voi olla satoja tai tuhansia potilasvalvontalaitteita, joille
kaikille on tehtävä sähköturvallisuustestaus säännöllisesti. Jos jokainen mittaus
valitaan ja kirjataan käsin, prosessi on hidas, altis kirjausvirheille ja vaikea
yhtenäistää eri testaajien välillä. Inhimillisten virheiden riski kasvaa toistuvissa
rutiinimittauksissa juuri siksi, että rutiini tekee tehtävästä mekaanista — ja
mekaaninen työ on henkisesti kuormittavampaa kuin miltä se näyttää.

**BTV** (*Biomedical Test Viewer*) on ohjelmistotyökalu, joka automatisoi tämän
prosessin. BTV ohjaa ESA615-analysaattoria läpi ennalta määritellyn testisekvenssin
— sarjan mittauksia tietyssä järjestyksessä — ilman, että testaajan tarvitsee
valita jokaista mittausta erikseen. Ohjelma kerää tulokset automaattisesti, vertaa
niitä hyväksymisrajoihin ja tuottaa valmiin dokumentaation testistä.

Automaation keskeinen hyöty ei ole pelkästään nopeus — se on toistettavuus. Kun
sama testisekvenssi ajetaan samalla laitteistolla eri testaajien toimesta eri
ajankohtina, tulokset ovat vertailukelpoisia keskenään. Tämä on olennaista laitteen
elinkaaren seurannan kannalta: jos sähköturvallisuusarvoissa näkyy pitkällä
aikavälillä trendi kohti raja-arvoa, se voidaan havaita vain, jos testaukset on
tehty ja dokumentoitu systemaattisesti. Yksittäinen manuaalinen mittaus ei kerro
trendiä — vertailukelpoinen sarja kertoo.

---

## Miten automaatiotestaus kehittyy — ja mitä se vaatii insinööriltä?

BTV:n ja ESA615:n muodostama yhdistelmä edustaa yhtä automaatiotestauksen tasoa:
valmis työkalu ajaa standardoidun testisekvenssin ja tuottaa dokumentaation.
Terveysteknologiainsinöörin rooli tällä tasolla on konfiguroida testisekvenssit
oikein, ajaa ne asianmukaisesti, tulkita tulokset ja tehdä niiden pohjalta
ammatilliset päätökset.

Automaatiotestaus voi ulottua pidemmälle. Kun toiminnallinen testaus yhdistetään
ohjelmalliseen laitteenohjaukseen — esimerkiksi potilassimulaattorin etäohjaukseen
tietokoneelta — on mahdollista rakentaa testisekvenssejä, jotka suorittavat
kokonaisen testiohjelman automaattisesti: asettavat simulaattorin tiettyyn tilaan,
lukevat monitorin näyttämän arvon, vertaavat hyväksymisrajaan ja kirjaavat
tuloksen. Tähän palataan viikon 4 Robot Framework -osuudessa.

Molemmilla tasoilla pätee sama periaate: automaatio ei poista insinöörin vastuuta,
se siirtää vastuun eri kohtaan. Manuaalisessa testauksessa insinööri tekee päätöksiä
joka askeleella. Automaattisessa testauksessa insinööri tekee päätökset etukäteen —
testisekvenssin suunnittelussa, hyväksymisrajojen määrittelyssä, poikkeamien
hallintaprotokollassa — ja luottaa sitten siihen, että automaatio toteuttaa nämä
päätökset johdonmukaisesti. Suunnittelu on vaativampaa kuin manuaalinen toiminta;
toteutus on nopeampaa ja luotettavampaa.

Terveydenhuollon laadunhallintajärjestelmissä — esimerkiksi ISO 13485:n mukaisessa
ympäristössä — testauksen dokumentaatio on osa oikeudellista vaatimustenmukaisuutta.
BTV:n tuottama automaattinen testiraportti on pätevä osa tätä dokumentaatioketjua
edellyttäen, että työkalu itsessään on validoitu käyttötarkoitukseensa ja että
testisekvenssi vastaa sovellettavia standardeja. Validointi — varmistaminen siitä,
että automatisoitu testausjärjestelmä tekee sen, mitä sen on tarkoitus tehdä —
on insinöörityötä siinä missä itse testauskin.

---

## Viitteet

IEC 62353:2014. *Medical electrical equipment — Recurrent test and test after
repair of medical electrical equipment.* International Electrotechnical Commission.

ISO 13485:2016. *Medical devices — Quality management systems — Requirements
for regulatory purposes.* International Organization for Standardization.

Bronzino, J. D., & Peterson, D. R. (Eds.). (2019). *The biomedical engineering
handbook* (4th ed.). CRC Press.

Webster, J. G. (Ed.). (2010). *Medical instrumentation: Application and design*
(4th ed.). John Wiley & Sons.

Joint Committee for Guides in Metrology (JCGM). (2008). *Evaluation of measurement
data — Guide to the expression of uncertainty in measurement* (GUM). BIPM.
https://www.bipm.org/documents/20126/2071204/JCGM_100_2008_E.pdf

---

*Potilasvalvonnan laitteet — TX00EY15 | Metropolia Ammattikorkeakoulu*
