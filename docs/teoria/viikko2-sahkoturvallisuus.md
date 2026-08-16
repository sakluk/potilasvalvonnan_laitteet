# Viikko 2 — Sähköturvallisuus terveydenhuollossa

*Tämä dokumentti on tarkoitettu itsenäisesti luettavaksi ennen kurssin toista
luentoa ja laboratoriotehtävää (Lab 2). Laitekohtainen esittely — ESA615-
sähköturvallisuusanalysaattori, B/BF/CF-luokittelu ja mittaussuureet — löytyy
erillisestä dokumentista [`docs/laitteet/esa615-sahkoturvallisuus.md`](../laitteet/esa615-sahkoturvallisuus.md).
Tämä dokumentti kattaa käsitteellisen pohjan: miksi sähköturvallisuus on
erityinen kysymys terveydenhuollossa ja miten se on ratkaistu.*

*Lukuaika noin 15 minuuttia.*

---

## Miksi sähköturvallisuus on erityinen haaste terveydenhuollossa?

Kotitalous- ja teollisuusympäristöissä sähköturvallisuusstandardit on suunniteltu
terveelle, tajuissaan olevalle ja liikuntakykyiselle henkilölle. Keskeinen oletus on,
että henkilö pystyy reagoimaan sähköiskuun — vetämään kätensä pois, huutamaan
apua, poistumaan tilanteesta. Nämä oletukset eivät päde terveydenhuollon
potilaaseen.

Potilas voi olla tajuton tai sedatoitu, jolloin hän ei kykene reagoimaan sähköiskuun
millään tavalla. Anestesia tai sedaatio poistaa myös kivun tuntemisen — potilas ei
huuda apua, vaikka virran kulku kehossa olisi hengenvaarallista. Lisäksi monissa
toimenpiteissä potilaan ihon resistanssi alenee merkittävästi: kostea tai haavautunut
iho, elektrodipasta tai steriili geeli poistavat suurimman osan siitä sähköisestä
suojasta, jonka terve kuiva iho normaalisti tarjoaa.

Kaikkein vaativin erityistilanne on kajoava toimenpide: kun potilaan kehoon viedään
katetri tai elektrodi, joka ulottuu sydämeen asti, normaalin ihon tarjoama suojaus
häviää kokonaan. Tässä tilanteessa jo äärimmäisen pienet sähkövirrat voivat olla
hengenvaarallisia — tätä kutsutaan mikroshokiksi, johon palataan jäljempänä.

Terveydenhuollon sähköturvallisuusvaatimukset ovat tästä syystä huomattavasti
tiukempia kuin kotitalous- tai teollisuuslaitteilla. Vaatimukset eivät perustu
käyttäjän reaktiokykyyn, vaan siihen, että laite itsessään ei saa aiheuttaa vaaraa
edes pahimmassa mahdollisessa käyttötilanteessa.

---

## Mitä sähkövirta tekee ihmiskeholle?

Sähkövirran fysiologiset vaikutukset riippuvat ensisijaisesti virran suuruudesta,
taajuudesta, kulkureitistä kehossa ja altistuksen kestosta. Kansainvälinen standardi
IEC 60479-1 (*Effects of current on human beings and livestock*) määrittelee nämä
vaikutukset systemaattisesti virta–aika-käyrillä.

Vaihtovirtaan (50 Hz) liittyvät kynnysarvot ovat vakiintuneet seuraaviksi (Reilly, 1998;
IEC 60479-1:2016):

Noin **0,5–1 mA** on tuntoraja: henkilö alkaa tuntea virran kulun, mutta fysiologista
haittaa ei vielä tapahdu. Välillä **1–10 mA** virta aiheuttaa pistelyn ja polttavan
tuntemuksen. Noin **10–30 mA** tasoilla saavutetaan lihaskouristuskynnys — lihakset
supistuvat tahtomatta ja henkilö ei välttämättä pysty irrottamaan otettaan virrallisesta
esineestä (*let-go threshold*, tyypillisesti noin 16 mA). Tätä pidetään merkittävänä
käytännön rajana, koska se muuttaa tilanteen akuutiksi uhaksi.

Välillä **30–300 mA** vakava vaara kasvaa nopeasti: hengityslihakset voivat lamaantua
ja kammiovärinä (*ventricular fibrillation*, VF) tulee mahdolliseksi. Kammiovärinä on
yleisin sähkötapaturman kuolinsyy: sydänlihaksen sähköinen aktivaatio menee
kaoottiseksi eikä sydän enää pumppaa verta tehokkaasti. Kammiovärinä vaatii
defibrillaation korjaantuakseen — se ei spontaanisti palaudu normaaliksi.

Yli **300 mA** virrat aiheuttavat koko sydänlihaksen samanaikaisen supistuksen, mikä
paradoksaalisesti voi estää kammiovärinän syntymisen mutta johtaa laajaan kudostuhoon
ja palovammoihin. Tätä periaatetta hyödynnetään defibrillaatiossa.

Virran kulkureitti on ratkaiseva: rintakehän läpi kulkeva virta (kädestä käteen tai
kädestä jalkaan) on huomattavasti vaarallisempi kuin saman suuruinen virta, joka
kulkee esimerkiksi yhdestä sormesta toiseen.

---

## Mikä on mikroshokki?

Mikroshokki (*microshock*) on ilmiö, jossa erittäin pieni sähkövirta aiheuttaa
kammiovärinän kulkiessaan suoraan sydämeen — ohittaen ihon tarjoaman
suojauksen.

Normaalisti kuiva iho on erinomainen sähköinen eriste: sen resistanssi on tyypillisesti
1 000–100 000 Ω tilanteesta riippuen. Kun 230 V:n verkkojännite kohtaa tällaisen
resistanssin, kehon läpi kulkeva virta jää alle vaarallisen kynnyksen. Iho siis suojelee
meitä sähköiseltä vaaralta päivittäin ilman, että edes huomaamme sen.

Tilanne muuttuu täysin, kun kehoon viedään kajoava instrumentti — esimerkiksi
sydämeen asti ulottuva paineenmittauskatetri tai tilapäinen tahdistuskatetri. Katetrin
metalli on suoraan kosketuksessa sydänlihaksen kanssa, ja katetrin resistanssi on
vain muutamia satoja ohmeja. Watson ym. (1973) osoittivat kokeellisesti, että
kammiovärinä voi syntyä jo noin **10–50 µA** (mikroampeeria) virralla, kun se
johdetaan suoraan sydämeen. Tämä on noin **tuhat kertaa pienempi** kuin normaali
kammiovärinän kynnys ihon kautta.

Mikroshokki on konkreettinen uhka esimerkiksi sydänkatetroinnin aikana: potilas on
kytketty sekä diagnostisiin mittalaitteisiin että mahdollisesti infuusiolaitteisiin, ja
pienikin vuotovirta mistä tahansa laitteesta voi kulkea katetria pitkin suoraan
sydämeen. Tämä on se fysiologinen perustelu, jonka vuoksi sydämeen kytketyille
laitteille (CF-luokka, *Cardiac Floating*) asetetaan erityisen tiukat vuotovirran
raja-arvot — jopa 10 µA — verrattuna muiden potilaskontaktityyppien laitteisiin.

---

## Miten lääkinnälliset laitteet on luokiteltu sähköturvallisuuden perusteella?

Lääkinnällisten laitteiden sähköturvallisuusluokittelu perustuu kahteen erilliseen
ulottuvuuteen: **suojausluokkaan** ja **potilaskontaktityyppiin**. Nämä kuvaavat
eri asioita ja esiintyvät molemmat laitteiden teknisissä tiedoissa.

**Suojausluokka** kuvaa, miten laite on suojattu verkkovirralta. Luokka I tarkoittaa,
että laite on suojamaadoitettu: vikatilanteessa virta ohjautuu suojajohtimen kautta
maahan eikä käyttäjän tai potilaan läpi. Luokka II tarkoittaa kaksoiseristystä: laite
ei tarvitse suojamaadoitusta, koska virrallinen osa on eristetty kahdella erillisellä
eristeellä. Useimmat kotitalouslaitteet ovat Luokka I tai II; lääkinnällisissä laitteissa
Luokka I on yleisin, mutta Luokka II on yleistynyt kannettavissa laitteissa.

**Potilaskontaktityyppi** kuvaa, miten laite on eristetty potilaasta sähköisesti.
B-tyyppi (*Body*) on peruseristys, soveltuu yleiseen käyttöön mutta ei suoraan
sydänkontaktiin. BF-tyyppi (*Body Floating*) tarjoaa kelluvan eristyksen, joka
estää virran kulkemisen potilaan kautta verkkoon — soveltuu useimpiin
ihokontaktimittauksiin kuten EKG:hen. CF-tyyppi (*Cardiac Floating*) on tiukin
luokka: sen vuotovirran raja-arvot ovat kymmenkertaisesti tiukemmat kuin BF-tyypillä,
ja se on pakollinen kaikille laitteille, jotka kytkeytyvät suoraan sydämeen.

Luokittelun yksityiskohdat — raja-arvot, symbolit ja mittausmenetelmät — kuvataan
laitedokumentissa [`docs/laitteet/esa615-sahkoturvallisuus.md`](../laitteet/esa615-sahkoturvallisuus.md).

---

## Mitä sähköturvallisuusstandardit edellyttävät?

Lääkinnällisten laitteiden sähköturvallisuutta säätelevät käytännössä kaksi
standardia, joilla on eri roolit: toinen koskee laitteen suunnittelua, toinen sen
ylläpitoa.

**IEC 60601-1** (*Medical electrical equipment — General requirements for basic safety
and essential performance*) on suunnittelustandardi. Se määrittelee, mitä
valmistajan on otettava huomioon laitteen rakenteessa: eristysvaatimukset, suurimmat
sallitut vuotovirrat, mekaaniset vaatimukset, lämpöturvallisuus ja niin edelleen.
Laite, joka on saatettu EU:n markkinoille MDR 2017/745 -asetuksen nojalla, on
käytännössä aina suunniteltu IEC 60601-1 -standardin mukaisesti. Valmistaja
osoittaa vaatimustenmukaisuuden testauslaboratorion lausunnolla, joka on osa CE-merkinnän
perustaa.

**IEC 62353** (*Medical electrical equipment — Recurrent test and test after repair*)
on ylläpitostandardi. Se määrittelee, miten lääkinnällisen laitteen sähköturvallisuus
testataan käyttöönoton jälkeen — ja kuinka usein. Standardi on suunnattu sairaaloille,
lääkintätekniikan henkilökunnalle ja huoltoyrityksille. Sen testit ovat yksinkertaisempia
kuin IEC 60601-1:n täydet tyyppitestit, mutta riittäviä osoittamaan, että laite on
säilyttänyt turvallisuutensa käytön ja mahdollisten huoltotoimenpiteiden jälkeen.

Kahden standardin välinen suhde on analoginen auton tyyppihyväksynnän ja vuosikatsastuksen
välille: valmistaja osoittaa tuotteen turvallisuuden ennen markkinoille tuloa (IEC 60601-1),
ja käyttäjäorganisaatio varmistaa turvallisuuden säilymisen jatkuvassa käytössä
(IEC 62353). Kurssin Lab 2 -tehtävässä tehdään juuri IEC 62353 -mukainen
toistuva testaus ESA615-analysaattorilla.

---

## Kuka vastaa lääkinnällisen laitteen sähköturvallisuudesta?

Vastuu jakautuu selkeästi kolmelle tasolle, jotka täydentävät toisiaan.

**Valmistaja** vastaa siitä, että laite on suunniteltu ja testattu IEC 60601-1 -standardin
mukaisesti ennen markkinoille tuloa. Tämä velvoite perustuu EU:n MDR 2017/745
-asetukseen. Valmistajan vastuuseen kuuluu myös elinkaaren aikainen seuranta:
jos markkinoilla olevassa laitteessa havaitaan turvallisuuspuute, valmistajan on
reagoitava — tiedottamalla, korjaamalla tai tarvittaessa vetämällä laite pois
markkinoilta.

**Terveydenhuollon organisaatio** — käytännössä sairaala tai terveyskeskus — vastaa
siitä, että käytössä olevat laitteet ovat turvallisia ja toimintakuntoisissa. Tähän
kuuluu huolto-ohjelma, johon sisältyy sähköturvallisuustestaus IEC 62353 -standardin
mukaisesti. Suomessa Sosiaali- ja terveysalan lupa- ja valvontavirasto (Valvira) valvoo
lääkinnällisten laitteiden käyttöä terveydenhuollon toimintayksiköissä ja edellyttää
organisaatioilta dokumentoitua laitteiden hallintajärjestelmää.

**Lääkintätekniikan insinööri** on se henkilö, joka toteuttaa tämän velvoitteen
käytännössä. Hän suunnittelee ja toteuttaa huolto-ohjelmat, suorittaa sähköturvallisuustestaukset,
dokumentoi tulokset ja tekee päätöksen siitä, voidaanko laite pitää käytössä vai
tuleeko se poistaa käytöstä tai lähettää huoltoon. HUS:n lääkintätekniikan yksikkö
— jonka toimintaan tutustutaan kurssin vierailulla — vastaa tuhansien laitteiden
huolto-ohjelmasta yhdessä Suomen suurimmista sairaanhoitopiireistä.

---

## Viitteet

IEC 60479-1:2016. *Effects of current on human beings and livestock — Part 1:
General aspects.* International Electrotechnical Commission.

IEC 60601-1:2005+AMD1:2012+AMD2:2020. *Medical electrical equipment — Part 1:
General requirements for basic safety and essential performance.*
International Electrotechnical Commission.

IEC 62353:2014. *Medical electrical equipment — Recurrent test and test after repair
of medical electrical equipment.* International Electrotechnical Commission.

EU:n lääkinnällisten laitteiden asetus (MDR) 2017/745. *Euroopan unionin virallinen
lehti*, L 117, 5.5.2017.

Reilly, J. P. (1998). *Applied bioelectricity: From electrical stimulation to
electropathology.* Springer. https://doi.org/10.1007/978-1-4612-1664-3

Watson, A. B., Wright, J. S., & Loughman, J. (1973). Electrical thresholds for
ventricular fibrillation in man. *Medical Journal of Australia*, 1(24), 1179–1182.
https://doi.org/10.5694/j.1326-5377.1973.tb113838.x

---

*Potilasvalvonnan laitteet — TX00EY15 | Metropolia Ammattikorkeakoulu*

