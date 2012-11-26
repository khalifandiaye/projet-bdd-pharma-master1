/*
alter table THESAURUS drop constraint pk_thes;
alter table THESAURUS drop constraint fk_lang;
alter table LANGUE drop constraint pk_lang;
alter table DOMAINE drop constraint pk_dom;
alter table DOMAINE drop constraint fk_thes;
alter table CONCEPT drop constraint pk_cons;
alter table CONCEPT drop constraint fk_dom;

drop table CONCEPT
drop table DOMAINE
drop table THESAURUS
drop table LANGUE
*/

create table THESAURUS (
	ID_Thes number,
	Langue number,
	Auteur varchar2(20),
	Date_Creation date,
	Description varchar2(20),
	Publie boolean,
	Contributeur varchar2(20),
	Format varchar2(20),
	Type_Thes varchar2(20),
	Source_Thes varchar2(20),
  CONSTRAINT pk_thes PRIMARY KEY(ID_Thes),
  CONSTRAINT fk_lang FOREIGN KEY (Langue) REFERENCES LANGUE (ID_Lang) ENABLE
);
/

create table LANGUE(
  ID_Lang number,
  Nom_Langue varchar2(20),
  CONSTRAINT pk_lang PRIMARY KEY(ID_Lang)
);
/

create table DOMAINE (
  ID_Domaine number,
	Titre varchar2(20),
	Sujet varchar2(20),
  Thesaurus number,
  CONSTRAINT pk_dom PRIMARY KEY(ID_Domaine),
  CONSTRAINT fk_thes FOREIGN KEY (Thesaurus) REFERENCES THESAURUS (ID_Thes) ENABLE
);
/

create or replace type CONCEPT_T as object (
	ID_concept number,
  Date_creation date
);

CREATE OR REPLACE TYPE CONCEPT_GENERIQUE  AS TABLE OF CONCEPT_T
CREATE OR REPLACE TYPE CONCEPT_SPECIFIQUE  AS TABLE OF CONCEPT_T
CREATE OR REPLACE TYPE CONCEPT_ASSOCIATIF  AS TABLE OF CONCEPT_T

create or replace type DESCRIPTEUR_T as object (
	ID_discr number,
  Valeur_lexicale varchar2(20),
	Date_creation date,
	Source_desc varchar2(20),
	Langue number
);
/

CREATE OR REPLACE TYPE DESCRIPTEUR_EQUIVALENT AS TABLE OF DESCRIPTEUR_T;

create table CONCEPT(
  ID_CONS number,
  Concept CONCEPT_T,
  Discripteur_Ved DESCRIPTEUR_T,
  Domaine number,
  Concept_Gen CONCEPT_GENERIQUE,
  Concept_Spec CONCEPT_SPECIFIQUE,
  Concept_Ass CONCEPT_ASSOCIATIF,
  Discripteur_EQ DESCRIPTEUR_EQUIVALENT,
  CONSTRAINT pk_cons PRIMARY KEY(ID_CONS),
  CONSTRAINT fk_dom FOREIGN KEY (Domaine) REFERENCES DOMAINE (ID_Domaine) ENABLE
) NESTED TABLE Concept_Gen STORE AS Concept_Gen_tab,
  NESTED TABLE Concept_Spec STORE AS Concept_Spec_tab,
  NESTED TABLE Concept_Ass STORE AS Concept_Ass_tab,
  NESTED TABLE Discripteur_EQ STORE AS Discripteur_EQ_tab;
/


