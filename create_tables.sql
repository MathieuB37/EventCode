#------------------------------------------------------------
#        Script MySQL.
#------------------------------------------------------------


#------------------------------------------------------------
# Table: client
#------------------------------------------------------------

CREATE TABLE client(
        id    Int  Auto_increment  NOT NULL ,
        email Varchar (50) NOT NULL ,
        mdp   Varchar (50) NOT NULL
	,CONSTRAINT client_PK PRIMARY KEY (id)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: commande
#------------------------------------------------------------

CREATE TABLE commande(
        id          Int  Auto_increment  NOT NULL ,
        date_panier Datetime NOT NULL ,
        id_client   Int NOT NULL
	,CONSTRAINT commande_PK PRIMARY KEY (id)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: compte_eventCode
#------------------------------------------------------------

CREATE TABLE compte_eventCode(
        id                  Int  Auto_increment  NOT NULL ,
        email               Varchar (50) NOT NULL ,
        mdp                 Varchar (255) NOT NULL ,
        type                Enum ("standard","premium","platinium") NOT NULL ,
        derniere_connexion  Datetime NOT NULL ,
        id_compte_eventCode Int NOT NULL
	,CONSTRAINT compte_eventCode_PK PRIMARY KEY (id)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: evenement
#------------------------------------------------------------

CREATE TABLE evenement(
        id                  Int  Auto_increment  NOT NULL ,
        nom                 Varchar (255) NOT NULL ,
        date_debut          Date NOT NULL ,
        date_fin            Date NOT NULL ,
        id_compte_eventCode Int NOT NULL
	,CONSTRAINT evenement_PK PRIMARY KEY (id)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: categorie_billet
#------------------------------------------------------------

CREATE TABLE categorie_billet(
        id           Int  Auto_increment  NOT NULL ,
        nom          Varchar (50) NOT NULL ,
        nb_max       Int NOT NULL ,
        tarif        Numeric NOT NULL ,
        id_evenement Int NOT NULL
	,CONSTRAINT categorie_billet_PK PRIMARY KEY (id)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: billet
#------------------------------------------------------------

CREATE TABLE billet(
        id                  Int  Auto_increment  NOT NULL ,
        date_achat          Datetime NOT NULL ,
        etat                Bool NOT NULL ,
        nb_tentative        Int NOT NULL ,
        qr_code             Blob NOT NULL ,
        nb_personne         Int NOT NULL ,
        id_categorie_billet Int NOT NULL ,
        id_commande         Int NOT NULL
	,CONSTRAINT billet_PK PRIMARY KEY (id)
)ENGINE=InnoDB;




ALTER TABLE commande
	ADD CONSTRAINT commande_client0_FK
	FOREIGN KEY (id_client)
	REFERENCES client(id);

ALTER TABLE compte_eventCode
	ADD CONSTRAINT compte_eventCode_compte_eventCode0_FK
	FOREIGN KEY (id_compte_eventCode)
	REFERENCES compte_eventCode(id);

ALTER TABLE evenement
	ADD CONSTRAINT evenement_compte_eventCode0_FK
	FOREIGN KEY (id_compte_eventCode)
	REFERENCES compte_eventCode(id);

ALTER TABLE categorie_billet
	ADD CONSTRAINT categorie_billet_evenement0_FK
	FOREIGN KEY (id_evenement)
	REFERENCES evenement(id);

ALTER TABLE billet
	ADD CONSTRAINT billet_categorie_billet0_FK
	FOREIGN KEY (id_categorie_billet)
	REFERENCES categorie_billet(id);

ALTER TABLE billet
	ADD CONSTRAINT billet_commande1_FK
	FOREIGN KEY (id_commande)
	REFERENCES commande(id);
