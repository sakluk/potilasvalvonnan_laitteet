# Viikko 4 — Testiautomaatio ja lääkinnällisten laitteiden testaus

*Tämä dokumentti on tarkoitettu itsenäisesti luettavaksi ennen kurssin neljättä
luentoa ja Lab 4:ää. Viikko 3 rakensi käsitteellisen pohjan toiminnalliselle
testaukselle ja automaatiolle. Tässä dokumentissa syvennytään siihen, mitä
laadukas testiautomaatio oikeastaan tarkoittaa — ja mihin suuntaan lääkinnällisten
laitteiden testaus on kehittymässä. Tekniset yksityiskohdat Robot Frameworkin
käytöstä ja Prosim 8:n sarjayhteydestä löytyvät erillisestä dokumentista
[`docs/laitteet/prosim8-robot-framework.md`](../laitteet/prosim8-robot-framework.md).*

*Lukuaika noin 15 minuuttia.*

---

## Mitä testiautomaatio oikeastaan tarkoittaa — ja mitä se ei tarkoita?

Testiautomaatio on helppo ymmärtää väärin: automaatio ei tee testauksesta
laadukasta, se tekee siitä nopeaa ja toistettavaa. Nopea, toistuva huono testi
on edelleen huono testi — se vain tuottaa väärän tuloksen useammin ja
johdonmukaisemmin.

Tämä ei ole akateeminen hiustenhalkomista. Ajattele, mitä tapahtuu, jos testiskriptissä on 
looginen virhe: laite saa PASS-merkinnän jokaisella testikerralla — nopeasti ja 
johdonmukaisesti. Manuaalisessa testauksessa kokenut testaaja saattaa huomata epäilyttävän 
tuloksen ja pysähtyä; automaattinen järjestelmä ei pysähdy, ellei sille ole ohjelmoitu 
toimintoa siihen. Tämä on automaatiotestauksen keskeinen paradoksi.

Laadukas testiautomaatio rakentuu neljän ulottuvuuden varaan. Ensimmäinen on
**kattavuus**: testataan oikeat asiat, ei vain helppoja tai nopeita mittauksia.
Toinen on **toistettavuus**: sama testi antaa saman tuloksen samalla laitteella
eri ajankohtina ja eri testaajien toimesta. Kolmas on **jäljitettävyys**: jokainen
testitulos voidaan yhdistää tiettyyn laitteeseen, tiettyyn testitapaukseen ja
tiettyyn ajankohtaan — tarvittaessa myös siihen, kuka testin suoritti. Neljäs on
**dokumentaatio**: testitapaus, hyväksymiskriteerit ja tulos ovat kirjattuna niin,
että ulkopuolinen pystyy arvioimaan, onko testaus tehty asianmukaisesti.

Automaatio on väline näiden ulottuvuuksien toteuttamiseen — ei niiden korvike.

---

## Mitä on hyvä testitapaus?

Testitapaus (*test case*) on formaalin testauksen perusyksikkö. Se ei ole vain
ohje siitä, mitä tehdään — se on dokumentti, joka kuvaa täsmällisesti, mitä
testataan, missä olosuhteissa, miten ja millä kriteereillä tulos arvioidaan.

Hyvä testitapaus koostuu viidestä osasta. **Kohde** kertoo, mitä toiminnallisuutta
tai parametria testataan — ei laitetta yleisesti, vaan täsmällisesti esimerkiksi
"EKG-kanavan syketaajuuden mittaustarkkuus arvolla 60 bpm". **Lähtötila** kuvaa,
missä tilassa laitteen ja testausjärjestelmän pitää olla ennen testin alkua.
**Vaiheistus** listaa toimenpiteet järjestyksessä: mitä simulaattoriin asetetaan,
mitä monitorissa konfiguroidaan, kuinka kauan odotetaan ennen lukeman lukemista.
**Odotettu tulos** kertoo, mitä laitteen pitäisi näyttää. **Hyväksymisehto**
määrittelee, millä toleranssilla tulos on hyväksyttävä — ei "oikein" tai "väärin",
vaan täsmällinen kriteeri kuten "±2 lyöntiä/min simuloidusta arvosta".

Tämä rakenne ei ole byrokraattinen muodollisuus. Se on edellytys sille, että testi
on toistettava: testaaja A ja testaaja B suorittavat saman testin samalla tavalla,
koska kaikki oleellinen on kirjattu ylös — ei jätetty testaajan oman tulkinnan
varaan. Säännellyissä ympäristöissä testitapaus on myös oikeudellinen dokumentti:
se osoittaa, että testaus on tehty tiettyjen vaatimusten mukaisesti. Tästä syystä
testitapaukseen on kirjattava riittävästi tietoa, jotta ulkopuolinen auditoija voi
arvioida, oliko testaus pätevä.

Jos katsot Lab 4:ssä kirjoittamaasi Robot Framework -testiskriptia, löydät siitä 
saman rakenteen: avainsanat kuvaavat vaiheistuksen, komennot asettavat lähtötilan,
`Log`-komennot kirjaavat odotetun tuloksen. Hyvä testiskripti on samalla hyvä
testitapaus.

---

## Miksi Robot Framework sopii lääkintälaitteiden testaukseen?

Robot Framework on ns. avainsanapohjainen (*keyword-driven*) testaustyökalu.
Käytännössä tämä tarkoittaa, että testitapaukset kirjoitetaan lähes luonnollisella
kielellä — ei Python-syntaksilla, vaan sanoilla kuten `Set Heart Rate`, `Wait` tai
`Verify Display Shows`. Konepellin alla Python-kirjastot toteuttavat nämä
avainsanat, mutta testitapauksen lukijan ei tarvitse ymmärtää Pythonia
ymmärtääkseen, mitä testi tekee.

Tämä ei ole triviaali valinta. Lääkintätekniikassa testitapauksilla on useita
lukijakuntia: insinööri, joka kirjoittaa testin; laadunhallintaosaston
asiantuntija, joka arvioi testauksen kattavuutta; viranomainen tai ulkopuolinen
auditoija, joka tarkistaa, että testaus vastaa standardin vaatimuksia. Näistä vain
ensimmäinen osaa lukea Python-koodia. Kaikki kolme pystyvät lukemaan
avainsanapohjaista testitapausta.

Toinen olennainen etu on testauksen logiikan ja teknisen toteutuksen erottaminen.
Testiskripti kuvaa *mitä* testataan ja *missä järjestyksessä*. Kirjasto kuvaa
*miten* tietokone kommunikoi laitteen kanssa. Jos laitteen sarjaporttiosoite
muuttuu tai kommunikaatioprotokolla päivittyy, kirjastoa muutetaan — testiskriptiin
ei tarvitse koskea. Tämä modulaarisuus on tärkeää pidemmällä aikavälillä tarkasteltuna: 
testiskriptit voivat elää vuosia, vaikka alustatekniikka ympärillä muuttuisi.

---

## Miksi vanhat tietoliikenneprotokollat elävät lääkintälaitteissa?

Prosim 8 kommunikoi tietokoneen kanssa RS-232-sarjaprotokollalla, joka on
standardoitu 1960-luvulla. Tämä herättää luontevasti kysymyksen: miksi
vuosikymmeniä vanha protokolla on edelleen käytössä nykyaikaisessa
lääkintälaitteessa?

Vastaus avaa tärkeän näkökulman terveysteknologia-alan laitesuunnitteluun.
Lääkinnällinen laite on tuote, jonka elinkaari on tyypillisesti 10–15 vuotta tai
enemmän. Koko tänä aikana laitteen pitää toimia samalla tavalla, koska sen
toimintaan perustuvat hoitopäätökset. Jokainen ohjelmisto- tai protokollamuutos
edellyttää validointia: on osoitettava, että muutos ei vaikuttanut laitteen
turvallisuuteen tai suorituskykyyn. Validointi vie aikaa ja rahaa. Tästä syystä
vakiintuneet, hyvin tunnetut protokollat ovat laitevalmistajalle huomattavasti
houkuttelevampia kuin uudet, joiden pitkäaikainen käyttäytyminen ei ole yhtä
hyvin dokumentoitu.

RS-232:n etuna on myös deterministisyys: se lähettää tavut siinä järjestyksessä
kuin ne lähetetään, tietyllä nopeudella, ilman TCP/IP-pinon tai langattoman
yhteyden tuomia viiveitä ja epävarmuuksia. Turvallisuuskriittisissä sovelluksissa
ennakoitavuus on arvo itsessään — monimutkaisempi järjestelmä voi olla nopeampi
tai kätevämpi, mutta se on myös vaikeampi varmentaa.

Sama ilmiö toistuu muuallakin terveysteknologiassa ja teollisuusautomaatiossa.
Sairaalan verkkojärjestelmät käyttävät HL7-sanomastandardia, joka on peräisin
1980-luvulta. Prosessiteollisuuden laitteet kommunikoivat HART-protokollalla,
joka standardoitiin 1980-luvulla. Lentoteollisuus käyttää ARINC 429
-väylää, joka esiteltiin 1977. Nämä eivät ole epäonnistumisia — ne ovat osoitus
siitä, miten turvallisuuskriittiset järjestelmät priorisoivat luotettavuuden ja
varmuuden uutuuden edelle. Terveysteknologiainsinöörille tämä tarkoittaa, että
vanhan protokollan kohtaaminen ei ole poikkeus vaan normaali osa työtä.

---

## Miten varmistetaan, että testijärjestelmä itse toimii oikein?

Testiautomaatiossa piilee paradoksi: jos testiskripti on viallinen, se voi
johdonmukaisesti ja nopeasti hyväksyä viallisia laitteita. Manuaalisessa
testauksessa kokenut testaaja saattaa huomata epäilyttävän tuloksen ja pysähtyä
arvioimaan — automaattinen järjestelmä ei pysähdy, ellei sille ole ohjelmoitu
toimintoa siihen. Siksi on kysyttävä: kuka tai mikä testaa testijärjestelmän?

Vastaus on testijärjestelmän **validointi**. Validointi tarkoittaa systemaattista
varmistamista siitä, että testausjärjestelmä — laitteisto, ohjelmisto ja
testiskriptit yhdessä — tekee sen, mitä sen on tarkoitus tehdä, oikeilla arvoilla,
oikeassa järjestyksessä. Lääketeollisuudessa tähän käytetään vakiintunutta
IQ/OQ/PQ-viitekehystä (*Installation Qualification / Operational Qualification /
Performance Qualification*): ensin varmistetaan, että järjestelmä on asennettu
oikein, sitten että se toimii spesifikaatioiden mukaisesti kontrolloiduissa
olosuhteissa, ja lopuksi että se toimii luotettavasti käytännön olosuhteissa.
Sama ajattelumalli soveltuu lääkintälaitteiden testausjärjestelmiin.

Käytännön tasolla validointi tarkoittaa esimerkiksi sitä, että testiskripti ajetaan
tunnetulla referenssilaitteella, jonka arvojen tiedetään olevan oikeat, ja
tarkistetaan, että skripti tuottaa odotetun PASS-tuloksen. Sen jälkeen testataan,
tunnistaako skripti tarkoituksellisesti syötetyn virheen — eli saako se FAIL-tuloksen
silloin, kun pitää. Vasta tämän jälkeen testiskriptiin voidaan luottaa kliinisessä
testausympäristössä.

Testausjärjestelmän validointi on sen käyttäjän vastuulla. Terveydenhuollon lääkintätekniikan kontekstissa tämä tarkoittaa käytännössä terveysteknologiainsinööriä tai laadunhallintaorganisaatiota: heidän tehtävänään on varmistaa, että juuri tässä ympäristössä käytetty testausjärjestelmä toimii luotettavasti — riippumatta siitä, kuka testiskriptit tai yksittäiset ohjelmistokomponentit on kirjoittanut. Tämä on yksi niistä kohdista, joissa tekninen osaaminen ja ammatillinen vastuu kohtaavat: insinööri ei vain aja testejä, vaan vastaa siitä, että testausjärjestelmä on luotettava käyttötarkoitukseensa.

---

## Mihin lääkinnällisten laitteiden testaus on menossa?

Testiautomaatio ei ole terveysteknologian marginaali-ilmiö — se on alan keskeinen
kehityssuunta, jonka vauhti on kiihtynyt viime vuosina useasta syystä.

Ensimmäinen ajuri on **laitekantakoko**. Suuret sairaanhoitopiirit hallinnoivat
kymmenien tuhansien laitteiden joukkoa. Manuaalinen, paperipohjainen
kunnossapitodokumentaatio ei skaalaudu tähän kokoluokkaan. Terveydenhuollon
organisaatiot siirtyvät CMMS-järjestelmiin (*Computerized Maintenance Management
System*), jotka integroivat testauksen, dokumentaation ja laitekannan hallinnan
yhteen ohjelmistoon. Testiautomaatio on luonteva osa tätä siirtymää: automaattinen
testiraportti voidaan tallentaa suoraan CMMS:ään ilman manuaalista kirjausta.

Toinen ajuri on **sääntelykehyksen kehitys**. EU:n lääkinnällisten laitteiden asetus
(MDR 2017/745) edellyttää valmistajilta ja käyttäjäorganisaatioilta yhä
yksityiskohtaisempaa dokumentaatiota laitteiden koko elinkaaren ajalta. FDA
Yhdysvalloissa on julkaissut ohjeistuksia tietokonepohjaisten järjestelmien
validoinnista terveydenhuollossa (21 CFR Part 11). Kumpikin suuntaus lisää painetta
kohti systemaattista, auditoitavaa ja automaattisesti dokumentoitua testausta.

Kolmas ajuri on **laitteen ja ohjelmiston rajan hämärtyminen**. Yhä useampi
lääkinnällinen laite on käytännössä tietokoneohjelma: tekoälypohjaiset diagnostiikka-
työkalut, pilvipalveluihin kytketyt monitorit, mobiilisovellukset, jotka keräävät
fysiologisia mittauksia. Näiden laitteiden ohjelmistoelinkaarta säätelee IEC 62304
-standardi (*Medical device software — Software life cycle processes*), joka
edellyttää systemaattista ohjelmistotestausta osana kehitysprosessia. Testiautomaatio
— Robot Frameworkin kaltaisilla työkaluilla toteutettuna — on IEC 62304:n mukaisen
testauksen luonteva toteutustapa.

Tässä kehityksessä terveysteknologiainsinööriltä edellytetään uudenlaista
osaamista. Kyky kirjoittaa ja ylläpitää testiskriptejä, ymmärtää testikattavuutta,
validoida testausjärjestelmiä ja liittää tulokset laadunhallintajärjestelmään on
muuttumassa yhtä keskeiseksi kuin perinteinen sähköturvallisuustestauksen
osaaminen. Alan yrityksissä — joissa osa teistä tulee
tekemään harjoittelun tai opinnäytetyön — testiautomaatio on arkipäiväinen
työkalu, ei erityisosaaminen.

---

## Viitteet

IEC 62304:2006+AMD1:2015. *Medical device software — Software life cycle
processes.* International Electrotechnical Commission.

IEC 62353:2014. *Medical electrical equipment — Recurrent test and test after
repair of medical electrical equipment.* International Electrotechnical Commission.

EU:n lääkinnällisten laitteiden asetus (MDR) 2017/745. *Euroopan unionin virallinen
lehti*, L 117, 5.5.2017.

U.S. Food and Drug Administration. (2003). *Guidance for industry: Part 11,
electronic records; electronic signatures — Scope and application.* FDA.
https://www.fda.gov/media/75414/download

ISPE. (2022). *GAMP 5: A risk-based approach to compliant GxP computerized
systems* (2nd ed.). International Society for Pharmaceutical Engineering.

Robot Framework Foundation. (2023). *Robot Framework user guide.*
https://robotframework.org/robotframework/

EIA-232. (1997). *Interface between data terminal equipment and data
circuit-terminating equipment employing serial binary data interchange.*
Electronic Industries Alliance.

---

*Potilasvalvonnan laitteet — TX00EY15 | Metropolia Ammattikorkeakoulu*
