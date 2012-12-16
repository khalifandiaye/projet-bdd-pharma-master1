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
  ID_Thes integer,
	Langue varchar2(50),
	Auteur varchar2(50),
	Date_Creation varchar2(50),
	Description varchar2(50),
	Publie integer,
	Contributeur varchar2(50),
	Format varchar2(50),
	Type_Thes varchar2(50),
	Source_Thes varchar2(50)
);
/

CREATE OR REPLACE TYPE Descripteur_T AS object (
	ID_Desc integer,
	date_Creation VARCHAR2(50),
	valeur_lexiq VARCHAR2(50),
	source_desc VARCHAR2(50),
	langue VARCHAR2(50)
);
/

CREATE OR REPLACE TYPE Domaine_T AS object (
	ID_Dom integer,
  Titre VARCHAR2(50),
	Sujet VARCHAR2(50),
  Thesaurus Thesaurus_T
);
/

CREATE OR REPLACE TYPE Concept_T AS object (
	ID_Concept integer,
	date_Creation VARCHAR2(50),
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
  ID_Concept_G integer,
  Concept_Gen GroupeConcept_T,
  CONSTRAINT pk_concg PRIMARY KEY(ID_Concept_G)
)NESTED TABLE Concept_Gen STORE AS Concept_Gen_tab;
/

CREATE TABLE Concept_S(
  ID_Concept_S integer,
  Concept_Spec GroupeConcept_T,
  CONSTRAINT pk_concs PRIMARY KEY(ID_Concept_S)
)NESTED TABLE Concept_Spec STORE AS Concept_Spec_tab;
/

CREATE TABLE Concept_A(
  ID_Concept_A integer,
  Concept_Ass GroupeConcept_T,
  CONSTRAINT pk_conca PRIMARY KEY(ID_Concept_A)
)NESTED TABLE Concept_Ass STORE AS Concept_Ass_tab;
/


CREATE TABLE CONCEPT(
  Concept Concept_T,
  Concept_Gen integer,
  Concept_Spec integer,
  Concept_Ass integer,
  CONSTRAINT pk_cons PRIMARY KEY(Concept.ID_Concept),
  CONSTRAINT fk_conc_gen FOREIGN KEY (Concept_Gen) REFERENCES Concept_G (ID_Concept_G) ENABLE,
  CONSTRAINT fk_conc_spec FOREIGN KEY (Concept_Spec) REFERENCES Concept_S (ID_Concept_S) ENABLE,
  CONSTRAINT fk_conc_ass FOREIGN KEY (Concept_Ass) REFERENCES Concept_A (ID_Concept_A) ENABLE
);
/

