# Viikko 1 — Tutustuminen laitteisiin ja potilasvalvontaan

*Tämä dokumentti on tarkoitettu itsenäisesti luettavaksi ennen kurssin ensimmäistä
luentoa ja laboratoriotehtävää. Se korvaa perinteisen luennon: kun olet lukenut
tämän, sinulla on käsitteellinen pohja laboratoriotyöskentelyyn.*

*Lukuaika noin 20 minuuttia.*

---

## Mitä on potilasvalvonta?

Potilasvalvonta (*patient monitoring*) tarkoittaa potilaan fysiologisten suureiden
jatkuvaa tai toistuvaa mittaamista ja arviointia hoidon aikana. Käytännössä se
tarkoittaa sitä, että laite tai laitekokonaisuus seuraa potilaan kehon tilaa
automaattisesti ja ilmoittaa, jos jokin arvo poikkeaa turvalliseksi katsotulta
alueelta.

Potilasvalvonta ei ole yksittäinen toimenpide vaan kokonainen järjestelmä: anturit
kerää signaalin, mittalaite prosessoi sen, näyttö esittää tuloksen ja hälytysjärjestelmä
reagoi poikkeamaan. Tämän kurssin laboratoriotöissä opit tuntemaan tämän ketjun
jokaisen osan.

---

## Miksi potilasvalvontaa tehdään?

Potilasvalvonnan keskeinen perustelu on yksinkertainen: ihminen ei pysty
tarkkailemaan kaikkia fysiologisia muuttujia yhtäaikaisesti ja jatkuvasti. Teho-osaston
potilaalla voi olla samanaikaisesti kymmeniä mitattavia suureita, joista mikä tahansa
voi muuttua kriittisesti muutamassa minuutissa. Hoitohenkilökunta ei yksinkertaisesti
pysty tähän ilman teknistä apua.

Valvontalaitteiden hyödystä on vahvaa näyttöä erityisesti anestesian aikana ja
tehohoidon yhteydessä. Overdyk ym. (2016) osoittivat, että jatkuva hengityksen
valvonta vähensi merkittävästi hengitysvajauksesta johtuvia haittatapahtumia
kirurgisilla vuodeosastopotilailla. Casserly ym. (2009) puolestaan havaitsivat, että
jatkuvaan happisaturaation seurantaan perustuva hoitoprotokolla paransi verenmyrkytyksestä (sepsis)
selvitymistä teho-osastolla.

Lyhyesti: potilasvalvontaa tehdään siksi, että ihmiskeho voi pettää nopeasti ja
varoittamatta, ja tekninen valvonta reagoi muutoksiin ennen kuin hoitaja ehtii
havaita ne silmämääräisesti.

---

## Mitä vitaalielintoiminnot ovat?

Vitaalielintoiminnot (*vital signs*) ovat ne fysiologiset suureet, joiden normaali taso
on välttämätöntä elämän ylläpitämiseksi. Jos mikä tahansa vitaalielintoiminto
häiriintyy vakavasti, tästä voi seurata korjaamattomia vaurioita, jopa kuolema. Tästä syystä juuri nämä
suureet ovat ensimmäisiä asioita, joita potilasvalvontamonitori mittaa.

Klassisesti vitaalielintoiminnoiksi luetaan neljä perussuuretta: sydämen syketaajuus
(*heart rate*, HR), verenpaine (*blood pressure*, BP), hengitystaajuus (*respiratory
rate*, RR) ja kehon lämpötila (*temperature*, T). Nykyisessä kliinisessä käytännössä
nämä täydentyvät useimmiten happisaturaatiolla (*oxygen saturation*, SpO₂), joka
kuvaa punasoluihin sitoutuneen hapen osuutta. Joissain lähteissä ja
hoitoprotokollissa myös tajunnan taso (Glasgow Coma Scale, GCS) ja
kivun arvio lisätään listaan — erityisesti ABCDE-arviointimallissa, jota käytetään
laajasti akuuttihoidossa (Thim ym., 2012).

Vitaalielintoimintojen seuranta on terveydenhuollon perusta: ennen potilasvalvonnan
laitteita hoitaja mittasi ne käsin toistuvasti. Teknologia ei muuttanut mitä mitataan,
vaan miten — jatkuvasti, automaattisesti ja täsmällisemmin.

---

## Mikä on parametri?

Parametri on tässä yhteydessä yksittäinen mitattava suure, jota laite seuraa ja
näyttää. Potilasvalvontamonitori voi mitata samanaikaisesti useita parametreja —
esimerkiksi EKG:tä, happisaturaatiota, verenpainetta ja hengitystaajuutta — ja
jokainen näistä on oma parametrinsa.

Termiä käytetään paljon laitedokumentaatiossa ja tutkimuskirjallisuudessa siksi, että
se on neutraali: se ei ota kantaa siihen, onko kyse sähköisestä signaalista,
paineesta, lämpötilasta tai jostain muusta fysikaalisesta suureesta. Parametri on vain
"jokin asia, jota mitataan".

Käytännön esimerkki: kun luet B650-monitorin manuaalia, törmäät usein lauseisiin
kuten *"the monitor supports the following parameters"* tai *"parameter out of
range"*. Tämä tarkoittaa yksinkertaisesti sitä, mitä laitteen moduulit mittaavat ja
missä arvorajoissa mittaus on luotettava. Parametri-käsite yhdistää teknisen
mittauksen kliiniseen merkitykseen: sama laite mittaa sekä millivoltteja (sähköinen
signaali) että kertoo sydämen sykkeen (kliininen tieto).

---

## Mikä on potilasvalvontamonitori?

Potilasvalvontamonitori (*patient monitor*) on laite, joka kerää, prosessoi ja esittää
useamman fysiologisen parametrin reaaliaikaisesti yhdeltä näytöltä. Se on eräänlainen
yhdyspiste potilaan kehon ja hoitohenkilökunnan välillä: anturit kiinnitetään
potilaaseen, signaalit kulkevat johtoja pitkin monitoriin, ja laite muuttaa ne
numeraalisiksi arvoiksi ja käyriksi, joita hoitaja voi tulkita.

Potilasvalvontamonitori eroaa yksittäisestä mittauslaitteesta kahdessa olennaisessa
asiassa. Ensinnäkin se mittaa useita parametreja samanaikaisesti yhden laitteen kautta.
Toiseksi siihen on integroitu hälytysjärjestelmä, joka hälyttää automaattisesti, kun
arvo ylittää tai alittaa asetetun rajan — hoitajan ei tarvitse jatkuvasti katsoa näyttöä.

Tällä kurssilla käytettävä GE CARESCAPE B650 on modulaarinen potilasvalvontamonitori.
Modulaarisuus tarkoittaa, että laitteen runkoon voidaan kytkeä eri
mittausmoduuleja tarpeen mukaan. Kurssin laboratoriotöissä keskeinen moduuli on
PSMP (*Patient Side Module Pro*), johon kytketään suurin osa mitattavista signaaleista.

---

## Miksi potilasvalvontamonitori on lääkinnällinen laite?

Potilasvalvontamonitori on lääkinnällinen laite (*medical device*) — ei siksi, että se
on sairaaloissa käytettävä laite, vaan siksi, että sillä tehtävä mittaus vaikuttaa
suoraan hoitopäätöksiin. Jos monitori näyttää väärän arvon, lääkäri tai hoitaja voi
tehdä väärän päätöksen, ja seurauksena voi olla potilasvahinko.

Euroopan unionissa lääkinnällisten laitteiden markkinoille saattaminen ja käyttö
säädetään EU:n lääkinnällisten laitteiden asetuksella (MDR 2017/745). Asetus edellyttää
muun muassa, että laite on suunniteltu ja testattu niin, että sen turvallisuus ja
suorituskyky voidaan osoittaa ennen markkinoille tuloa. Valmistajan on myös
ylläpidettävä markkinoilla olevan laitteen suorituskykyä koko sen elinkaaren ajan.

Tämä on suoraan yhteydessä kurssin sisältöön: ESA615-sähköturvallisuusanalysaattori
ja Prosim 8 -potilassimulaattori ovat laitteita, joilla potilasmonitorin suorituskyky
ja turvallisuus *testataan*. Testaus on lain edellyttämää huoltotoimintaa — ei
valinnainen toimenpide, vaan osa lääkinnällisen laitteen laillista käyttöä. Terveysteknologiainsinöörin
työ alkaa siitä, mihin hoitohenkilökunnan vastuu päättyy.

---

## Millaisia laitteita kurssilla käytetään — ja miksi juuri ne?

Kurssilla käytetään kolmea laitetta, jotka muodostavat yhdessä tyypillisen
potilasmonitorin testausympäristön terveydenhuollon lääkintätekniikassa.

**GE CARESCAPE B650** on modulaarinen potilasvalvontamonitori — se on testattava
laite (DUT = Device Under Test). B650 valittiin kurssille, koska se edustaa nykyaikaista, kliinisessä käytössä
olevaa laitetyyppiä ja sen modulaarinen rakenne tekee näkyväksi, miten eri parametrien
mittaus on organisoitu yhteen laitteeseen.

**Fluke ESA615** on sähköturvallisuusanalysaattori. Sen tehtävä on mitata, täyttääkö
potilasmonitori lääkinnällisille laitteille asetetut sähköturvallisuusvaatimukset —
erityisesti IEC 62353 -standardin mukaiset vuotovirta-arvot. Sähköturvallisuustestaus
on pakollinen osa huolto-ohjelmaa, ja ESA615 on alan yleisesti käyttämä laite
tähän tarkoitukseen.

**Fluke Biomedical ProSim 8** on potilassimulaattori. Se jäljittelee potilaan
fysiologisia signaaleja — esimerkiksi EKG:tä, happisaturaatiota ja verenpainetta —
ilman oikeaa potilasta. Tämä on välttämätöntä: potilasmonitorin toiminnallista
testausta ei voida tehdä oikealla potilaalla, koska testaustilanne voi aiheuttaa
vääriä hälytyksiä tai muita häiriöitä potilaan hoitoon. Simulaattori ratkaisee tämän
ongelman tarjoamalla tunnetun, toistettavan ja turvallisen testitilanteen.

---

## Miten varoitukset ja hälytykset toimivat?

Potilasvalvontamonitorin hälytysjärjestelmä on yksi sen tärkeimmistä ominaisuuksista
— ja yksi yleisimmistä kliinisen turvallisuuden ongelmista. Periaate on yksinkertainen:
jokaiselle parametrille asetetaan ylä- ja alaraja, ja kun mitattu arvo ylittää nämä
rajat, monitori antaa hälytyksen — äänimerkin ja visuaalisen ilmoituksen.

Hälytykset on yleensä jaettu prioriteettitasoihin: kriittinen (välitön riski potilaalle),
vakava (vaatii pikaista huomiota) ja matala prioriteetti (tilanne vaatii seurantaa).
IEC 60601-1-8 -standardi määrittelee, miten lääkinnällisen laitteen hälytykset tulee
toteuttaa, muun muassa äänisignaalien rakenteen ja värikoodauksen osalta.

Hälytysuupumus (*alarm fatigue*) on tunnettu ongelma teho-osastoilla: jos hälytyksiä
tulee liikaa tai liian herkästi, hoitohenkilökunta alkaa sivuuttaa niitä — myös
todellisessa hätätilanteessa. Sendelbach ja Funk (2013) arvioivat, että jopa 72–99 %
kaikista kliinisistä hälytyksistä on kliinisesti merkityksettömiä. Tämä on johtanut
aktiiviseen tutkimukseen siitä, miten hälytysrajoja tulisi asettaa ja miten laitteet
voisivat tunnistaa merkittävät hälytykset paremmin.

Laboratoriotyöskentelyssä törmäät hälytyksiin käytännössä: kun potilassimulaattori
tuottaa poikkeavan arvon, monitori reagoi — ja sinun tehtäväsi on ymmärtää, miksi.

---

## Mikä on terveysteknologiainsinöörin rooli potilasvalvonnassa?

Hoitohenkilökunta käyttää potilasvalvontalaitteita — mutta joku muu vastaa siitä, että
ne toimivat oikein, ovat turvallisia ja täyttävät lainsäädännön vaatimukset.
Terveysteknologiainsinööri (*biomedical engineer* tai *clinical engineer*) on se
henkilö, jonka vastuulla tämä on.

Käytännön tehtäviä ovat muun muassa laitteiden huolto ja kalibrointi,
sähköturvallisuustestaus, toiminnallinen testaus potilassimulaattorilla,
hankintaprosessiin osallistuminen ja henkilökunnan laitekoulutus. Suurissa
sairaaloissa, kuten HUS:ssa, tähän on oma lääkintätekniikan organisaatio — jonka
toimintaan tutustutaan kurssin vierailulla.

Terveysteknologiainsinöörin rooli on silta laitevalmistajan ja kliinisen käytön
välillä: hän ymmärtää sekä laitteen tekniikan että ympäristön, jossa sitä käytetään.
Tämä kurssi antaa ensimmäisen kosketuksen siihen, mitä tämä työ tarkoittaa
käytännössä.

---

## Viitteet

Casserly, B., Read, R., & Levy, M. M. (2009). Hemodynamic monitoring in sepsis.
*Critical Care Clinics*, 25(4), 803–823. https://doi.org/10.1016/j.ccc.2009.08.006

Overdyk, F. J., Dasta, J. F., Bennett, S., & English, D. (2016). Opioid-induced
respiratory depression in the acute care setting: A compendium of case reports.
*Pain Management*, 6(4), 333–346. https://doi.org/10.2217/pmt-2016-0008

Sendelbach, S., & Funk, M. (2013). Alarm fatigue: A patient safety concern.
*AACN Advanced Critical Care*, 24(4), 378–386.
https://doi.org/10.1097/NCI.0b013e3182a903f9

Thim, T., Krarup, N. H. V., Grove, E. L., Rohde, C. V., & Løfgren, B. (2012).
Initial assessment and treatment with the Airway, Breathing, Circulation, Disability,
Exposure (ABCDE) approach. *International Journal of General Medicine*, 5, 117–121.
https://doi.org/10.2147/IJGM.S28478

EU:n lääkinnällisten laitteiden asetus (MDR) 2017/745. *Euroopan unionin virallinen
lehti*, L 117, 5.5.2017.

IEC 60601-1-8:2006+AMD1:2012+AMD2:2020. *Medical electrical equipment — Part 1-8:
General requirements for basic safety and essential performance — Collateral standard:
General requirements, tests and guidance for alarm systems in medical electrical
equipment and medical electrical systems.* International Electrotechnical Commission.

IEC 62353:2014. *Medical electrical equipment — Recurrent test and test after repair of
medical electrical equipment.* International Electrotechnical Commission.
