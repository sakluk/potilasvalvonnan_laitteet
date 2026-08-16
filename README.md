# Potilasvalvonnan laitteet — TX00EY15

Tämä repositorio sisältää kurssimateriaalia **Metropolia Ammattikorkeakoulun**
kurssille *Potilasvalvonnan laitteet (TX00EY15-3003)*. Kurssi on suunnattu
3. vuoden tieto- ja viestintäteknologian hyvinvointi- ja terveysteknologiaan
suuntautuneille opiskelijoille.

Materiaalien tuottamisessa on käytetty Claude Sonnet 4.6 tekoälymallia. Materiaalit on tuotettu interaktiivisesti keskustellen ja tarvittaessa manuaalisesti korjaten havaittuja virheitä. 

---

## Kurssin tavoitteet

Opintojakson suoritettuaan opiskelija:

- tunnistaa, millaisia potilasvalvonnan menetelmiä ja laitteita terveydenhuollon
  erikoisaloilla käytetään
- ymmärtää vitaalielintoiminnot ja niiden mittausperiaatteet
- tietää valittujen laitteiden rakenteen ja toiminnan
- ymmärtää potilasvalvonnan ympäristöjen erityispiirteitä käytännön
  laboratorioharjoitusten avulla

---

## Kurssilla käytettävät laitteet

Kurssin laboratoriotyöt tehdään kolmella laitteella, jotka muodostavat tyypillisen
potilasmonitorin testausympäristön lääkintätekniikassa:

| Laite | Rooli |
|-------|-------|
| **GE CARESCAPE B650** | Testattava potilasvalvontamonitori (DUT) |
| **Fluke ESA615** | Sähköturvallisuusanalysaattori |
| **Fluke Biomedical ProSim 8** | Potilassimulaattori |

---

## Hakemistorakenne

```
potilasvalvonnan_laitteet/
│
├── docs/
│   ├── teoria/               # Viikoittaiset itseopiskeludokumentit
│   │   ├── README.md
│   │   ├── viikko1-potilasvalvonta-yleisesti.md
│   │   ├── viikko2-sahkoturvallisuus.md
│   │   ├── viikko3-toiminnallinen-testaus-ja-automaatio.md
│   │   └── viikko4-testiautomaatio-ja-testitapaussuunnittelu.md
│   │
│   └── laitteet/             # Laitekohtaiset käsitteelliset esittelyt
│       ├── b650-potilasvalvontamonitori.md
│       ├── b650-psmp-moduuli.md
│       ├── esa615-sahkoturvallisuus.md
│       ├── prosim8-potilassimulaattori.md
│       └── prosim8-robot-framework.md
│
├── private/                  # Kurssin sisäiset materiaalit (ei julkinen)
│   ├── Lab 1–4 -ohjeistukset (PDF)
│   ├── Laboratorion säännöt (PDF)
│   ├── Monitoritestaus mallipohja (DOCX)
│   └── Kurssisuunnitelma ja opintojaksokuvaus
│
├── .gitignore
├── LICENSE
└── README.md
```

---

## Opiskelijan lukupolku

Dokumentit on kirjoitettu korvaamaan perinteiset opetussession diat — ne on
tarkoitettu luettavaksi **ennen** vastaavaa opetussessiota ja laboratoriotehtävää.
Alla suositeltu järjestys:

### Viikko 1 — Tutustuminen potilasvalvontaan

1. [`docs/teoria/viikko1-potilasvalvonta-yleisesti.md`](docs/teoria/viikko1-potilasvalvonta-yleisesti.md)
   *Mikä on potilasvalvontamonitori, mitä vitaalielintoiminnot ovat ja miksi
   laitteita testataan. Noin 20 minuutin lukeminen.*

2. [`docs/laitteet/b650-potilasvalvontamonitori.md`](docs/laitteet/b650-potilasvalvontamonitori.md)
   *GE CARESCAPE B650:n modulaarinen rakenne, mitattavat parametrit ja
   laboratorioympäristö. Lue ennen Lab 1:tä.*

3. [`docs/laitteet/b650-psmp-moduuli.md`](docs/laitteet/b650-psmp-moduuli.md)
   *PSMP-moduulin yksityiskohtainen kuvaus: mittauskanavat, kytkennät ja
   parametrikohtainen syventyminen. Syventävä lukeminen Lab 1–3:n tueksi.*

### Viikko 2 — Sähköturvallisuus

4. [`docs/teoria/viikko2-sahkoturvallisuus.md`](docs/teoria/viikko2-sahkoturvallisuus.md)
   *Miksi lääkintälaitteiden sähköturvallisuus on erityisvaatimus ja miten se
   on ratkaistu standardeissa IEC 60601-1 ja IEC 62353.*

5. [`docs/laitteet/esa615-sahkoturvallisuus.md`](docs/laitteet/esa615-sahkoturvallisuus.md)
   *ESA615-analysaattorin mittaussuureet, B/BF/CF-luokittelu ja mittausjärjestys.
   Lue ennen Lab 2:ta.*

### Viikko 3 — Toiminnallinen testaus ja simulointi

6. [`docs/teoria/viikko3-toiminnallinen-testaus-ja-automaatio.md`](docs/teoria/viikko3-toiminnallinen-testaus-ja-automaatio.md)
   *Miksi sähköturvallisuustestaus ei yksin riitä ja mitä toiminnallinen testaus
   tarkoittaa käytännössä.*

7. [`docs/laitteet/prosim8-potilassimulaattori.md`](docs/laitteet/prosim8-potilassimulaattori.md)
   *ProSim 8:n simuloitavat parametrit ja toiminnallisen testauksen vaiheistus.
   Lue ennen Lab 3:a.*

### Viikko 4 — Testiautomaatio

8. [`docs/teoria/viikko4-testiautomaatio-ja-testitapaussuunnittelu.md`](docs/teoria/viikko4-testiautomaatio-ja-testitapaussuunnittelu.md)
   *Mitä laadukas testiautomaatio tarkoittaa lääkintälaitteiden yhteydessä ja
   mihin suuntaan ala kehittyy.*

9. [`docs/laitteet/prosim8-robot-framework.md`](docs/laitteet/prosim8-robot-framework.md)
   *ProSim 8:n ohjaus Robot Frameworkilla sarjayhteydellä. Sisältää
   asennusohjeet ja tarkistuslistat — **asenna ohjelmistot ennen labraan tuloa**.*

---

## Kurssin rakenne

| Osa | Kuvaus |
|-----|--------|
| **Opetussessiot (vk 1–4)** | Itseopiskelumateriaali korvaa perinteiset diat; luetaan ennen vastaavaa opetussessiota |
| **Vierailut** | GE Healthcare, HUS lääkintätekniikka, Myllypuron simulaatiotilat — pakollisia, yksilötehtävät |
| **Laboratoriot (Lab 1–4)** | Pienryhmätyöskentely, Karamalmi KMD790, opiskelija-assistentti paikalla |

Laboratorioille jaetaan ryhmäkohtaiset työskentelyajat kurssin aikana.

---

## Materiaalien kirjoitusperiaatteet

Tässä repositoriossa olevat dokumentit noudattavat yhteistä kirjoitusperiaatetta:

- **Käsitteellinen ennen teknistä.** Jokainen dokumentti selittää *miksi* ennen
  *miten*. Tekniset yksityiskohdat (standardien lukujen numerot, mittausrajat)
  löytyvät ensisijaisesti laitteen omista manuaaleista.
- **Manuaalit ovat ensisijainen lähde.** Nämä dokumentit eivät korvaa manuaaleja
  — ne valmistavat sinut lukemaan manuaaleja tehokkaasti. Labraohjeistuksissa
  viitataan aina tiettyihin manuaalin kohtiin.
- **Akateemiset viitteet.** Väitteet on tuettu vertaisarvioiduilla lähteillä ja
  kansainvälisillä standardeilla.

---

*Potilasvalvonnan laitteet — TX00EY15 | Metropolia Ammattikorkeakoulu*
