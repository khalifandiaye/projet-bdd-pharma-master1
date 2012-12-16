Antalgique - 

Doliprane - directeur
Pharmacie 

INSERT INTO THESAURUS VALUES 
(Thesaurus_T(1,'Fran?ais','Jean Genot','2012/12/06','Milieu Pharmaceutique',0,'Jean Genot','Informatis?','Dictionnaire','Jean Genot'));

INSERT INTO DOMAINE VALUES
(Domaine_T(1,'Pharmacie','Milieu Pharmaceutique',(select * from THESAURUS T where T.Thesaurus.ID_Thes = 1)));

INSERT INTO DESCRIPTEUR VALUES (Descripteur_T(1,'2012/12/06','Pharmacie','Jean Genot','Fran?ais'));

INSERT INTO Concept_G VALUES (1, GroupeConcept_T());
INSERT INTO Concept_S VALUES (1, GroupeConcept_T());
INSERT INTO Concept_A VALUES (1, GroupeConcept_T());

INSERT INTO CONCEPT VALUES
(Concept_T(1, '2012/12/06', (select * from DOMAINE D where D.Domaine.ID_Dom = 1), (select * from DESCRIPTEUR R where R.descripteur.ID_Desc = 1)), 1, 1, 1);

INSERT INTO DESCRIPTEUR VALUES (Descripteur_T(2,'2012/12/07','M?dicament','Jean Genot','Fran?ais'));

INSERT INTO Concept_G VALUES (2, GroupeConcept_T());
INSERT INTO Concept_S VALUES (2, GroupeConcept_T());
INSERT INTO Concept_A VALUES (2, GroupeConcept_T());

INSERT INTO CONCEPT VALUES
(Concept_T(2, '2012/12/07', (select * from DOMAINE D where D.Domaine.ID_Dom = 1), (select * from DESCRIPTEUR R where R.descripteur.ID_Desc = 2)), 2, 2, 2);

INSERT INTO
TABLE(SELECT G.Concept_Gen FROM Concept_G G WHERE G.ID_Concept_G = (select L.Concept_Gen from CONCEPT L where L.Concept.ID_Concept = 1))
VALUES(Concept_T(2, '2012/12/07', (select * from DOMAINE D where D.Domaine.ID_Dom = 1), (select * from DESCRIPTEUR R where R.descripteur.ID_Desc = 1)));



/*
example
*/

/*
SELECT
CURSOR(
SELECT p.ID_Concept, p.date_Creation 
FROM TABLE(G.Concept_Gen) p
)
FROM Concept_G G
WHERE G.ID_Concept_G = 1;
*/


/*DELETE FROM DESCRIPTEUR d WHERE d.descripteur.ID_Desc = 1;*/

