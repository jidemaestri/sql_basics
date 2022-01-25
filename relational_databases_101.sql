-- Creating Database
CREATE DATABASE Academia; 

-- Using Database
USE Academia;


-- Creating TABLE Países

CREATE TABLE Paises
(
	Cod_Pais char(2) PRIMARY KEY CHECK (LEN(Cod_Pais)=2),
	Nombre varchar(50) NOT NULL,
	Cod_ISO3 char(3) NOT NULL UNIQUE CHECK (LEN(Cod_ISO3)=2),
	Cod_Telefonico smallint
);

-- Creating TABLE Estados

CREATE TABLE Estados
(
  	Cod_Estado char(2) PRIMARY KEY,
  	CONSTRAINT Len_Estado CHECK (LEN(Cod_Estado)=2), 
  	Cod_Pais char(2) FOREIGN KEY REFERENCES Paises (Cod_Pais)
              	     	ON UPDATE CASCADE
                   	ON DELETE CASCADE,
  	Nombre varchar(50) NOT NULL,
  	Cod_Telefonico smallint
);



-- Creating TABLE Academias

CREATE TABLE Academias
(
	  Cod_Acad tinyint IDENTITY (1,1) PRIMARY KEY,
  	Nombre varchar(50) NOT NULL,
 	 Fec_Fundacion Date NOT NULL,
 	 Numero varchar(10) NOT NULL,
 	 Calle varchar(30) NOT NULL,
	  Ciudad varchar(30) NOT NULL,
 	 Estado char(2) NULL 
  --Si deseamos Agregar un Nombre 
	CONSTRAINT FK_Academias_Estados FOREIGN KEY  
									REFERENCES Estados (Cod_Estado)
										ON UPDATE CASCADE
										ON DELETE SET NULL,
 	 Cod_Postal varchar(10)
); 
 

CREATE TABLE Profesores
(
	  Cod_Prof smallint IDENTITY (1,1) PRIMARY KEY,
 	 SSN varchar(11) UNIQUE CHECK (LEN(SSN)=11),
	  Nombre varchar(30) NOT NULL,
  Apellido varchar(30) NOT NULL,
  Numero varchar(10) NOT NULL,
  	Calle varchar(30) NOT NULL,
  Ciudad varchar(30) NOT NULL,
	  Estado char(2) FOREIGN KEY REFERENCES Estados (Cod_Estado)
        	           ON UPDATE CASCADE
          	         ON DELETE SET NULL,
  	Cod_Postal varchar(10) NOT NULL,
  	Telefono varchar(15),
  	Sueldo money DEFAULT (0)
);


CREATE TABLE Departamentos
(
  	Cod_Dpto Smallint IDENTITY (1,1) PRIMARY KEY,
	  Academia tinyint NOT NULL 
				FOREIGN KEY REFERENCES Academias (Cod_Acad)
					ON UPDATE CASCADE
					ON DELETE CASCADE,
	  Nombre varchar(30) NOT NULL,
 	 Director smallint  NOT NULL DEFAULT (-1)
				FOREIGN KEY REFERENCES Profesores (Cod_Prof) 
					ON UPDATE NO ACTION
					ON DELETE NO ACTION,
  	Fec_Inicio Date NOT NULL
);


CREATE TABLE Dptos_Profesores
(
 	 Cod_Dpto Smallint NOT NULL
		FOREIGN KEY REFERENCES Departamentos (Cod_Dpto)
  	Cod_Prof smallint NOT NULL
		FOREIGN KEY REFERENCES Profesores (Cod_Prof)
	    		ON UPDATE CASCADE
			ON DELETE CASCADE
);