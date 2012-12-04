DROP TABLE THESAURUS;
DROP TABLE DESCRIPTEUR;
DROP TABLE DOMAINE;
DROP TABLE CONCEPT;
DROP TABLE Concept_G;
DROP TABLE Concept_S;
DROP TABLE Concept_A;

drop type GroupeConcept_T;
drop type Concept_T;
drop type Descripteur_T;
drop type Domaine_T;
drop type Thesaurus_T;



CREATE OR REPLACE TYPE Thesaurus_T as object (
  ID_Thes number,
	Langue varchar2(20),
	Auteur varchar2(20),
	Date_Creation date,
	Description varchar2(20),
	Publie integer,
	Contributeur varchar2(20),
	Format varchar2(20),
	Type_Thes varchar2(20),
	Source_Thes varchar2(20)
);
/

CREATE OR REPLACE TYPE Descripteur_T AS object (
	ID_Desc NUMBER,
	date_Creation DATE,
	valeur_lexiq VARCHAR2(20),
	source_desc VARCHAR2(20),
	langue VARCHAR2(20)
);
/

CREATE OR REPLACE TYPE Domaine_T AS object (
	ID_Dom NUMBER,
  Titre VARCHAR2(20),
	Sujet VARCHAR2(20),
  Thesaurus Thesaurus_T
);
/

CREATE OR REPLACE TYPE Concept_T AS object (
	ID_Concept NUMBER,
	date_Creation DATE,
	domaine Domaine_T,
	Desc_vedette Descripteur_T
);
/

CREATE OR REPLACE TYPE GroupeConcept_T AS TABLE OF Concept_t;
/



CREATE TABLE THESAURUS(
  Thesaurus Thesaurus_T,
  CONSTRAINT pk_thes PRIMARY KEY(Thesaurus.ID_Thes)
);
/

CREATE TABLE DESCRIPTEUR(
  Descripteur Descripteur_T,
  CONSTRAINT pk_desc PRIMARY KEY(Descripteur.ID_Desc)
);
/

CREATE TABLE DOMAINE(
  Domaine Domaine_T,
  CONSTRAINT pk_dom PRIMARY KEY(Domaine.ID_Dom)
);
/

CREATE TABLE Concept_G(
  ID_Concept_G NUMBER,
  Concept_Gen GroupeConcept_T,
  CONSTRAINT pk_concg PRIMARY KEY(ID_Concept_G)
)NESTED TABLE Concept_Gen STORE AS Concept_Gen_tab;
/

CREATE TABLE Concept_S(
  ID_Concept_S NUMBER,
  Concept_Spec GroupeConcept_T,
  CONSTRAINT pk_concs PRIMARY KEY(ID_Concept_S)
)NESTED TABLE Concept_Spec STORE AS Concept_Spec_tab;
/

CREATE TABLE Concept_A(
  ID_Concept_A NUMBER,
  Concept_Ass GroupeConcept_T,
  CONSTRAINT pk_conca PRIMARY KEY(ID_Concept_A)
)NESTED TABLE Concept_Ass STORE AS Concept_Ass_tab;
/


CREATE TABLE CONCEPT(
  Concept Concept_T,
  Concept_Gen NUMBER,
  Concept_Spec NUMBER,
  Concept_Ass NUMBER,
  CONSTRAINT pk_cons PRIMARY KEY(Concept.ID_Concept),
  CONSTRAINT fk_conc_gen FOREIGN KEY (Concept_Gen) REFERENCES Concept_G (ID_Concept_G) ENABLE,
  CONSTRAINT fk_conc_spec FOREIGN KEY (Concept_Spec) REFERENCES Concept_S (ID_Concept_S) ENABLE,
  CONSTRAINT fk_conc_ass FOREIGN KEY (Concept_Ass) REFERENCES Concept_A (ID_Concept_A) ENABLE
);
/

