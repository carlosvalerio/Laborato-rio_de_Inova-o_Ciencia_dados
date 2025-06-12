drop database EX332ALUNOS;
CREATE DATABASE EX332ALUNOS;
USE EX332ALUNOS;

CREATE TABLE StatusAluno (
    idStatusAluno INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    DeStatusAluno VARCHAR(45) not null
);

insert into StatusAluno (DeStatusAluno) values
('Egresso'),('Transferido'),('Cursando');

CREATE TABLE Aluno (
idAluno INT AUTO_INCREMENT PRIMARY KEY NOT NULL, 
NomeAluno VARCHAR(75) not null,
idStatusAluno INT NULL,
foreign key (idStatusAluno) references StatusAluno(idStatusAluno)  
);

insert into aluno (NomeAluno,idStatusAluno)
values
('Paloma Oliveira',1),
('Marina Ruy Barbosa',2),
('Aline Riscado',2),
('Bruna Marquezine',3),
('Isabela Fontana',2),
('Eva Andressa',1),
('Camila Queiroz',3);

CREATE TABLE CURSO (
idCurso INT AUTO_INCREMENT NOT NULL,
DeCurso VARCHAR(45) not null,
PRIMARY KEY (idCurso)
);

INSERT INTO CURSO (DeCurso) VALUES
('ADS Analise Desenvolvimento de Sistemas'),
('GTI Gestão de Tecnologia da Informação'),
('Engenharia'),
('Medicina'),
('Direito'),
('Educação Física');

create table professor
(idProfessor INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
Nomeprofessor VARCHAR(45) not null);

INSERT INTO professor (NomeProfessor) values
('Eisntein'),
('Girafalis'),
('Patata'),
('Raimundo'),
('Pardal');

create table Disciplina (
idDisciplina INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
DeDisciplina VARCHAR(45) not null,
idCurso int, 
idProfessor int,
foreign key (idCurso) references Curso(idCurso),
foreign key (idProfessor) references Professor(idProfessor));

insert into Disciplina (DeDisciplina,idCurso, idProfessor) values
('Banco de Dados',1,1),
('Civil',4,1),
('Java',2,2),
('Anatomia',4,3),
('Fisiologia',4,1),
('Engenharia Software',2,2),
('Constitucional',5,3);

CREATE TABLE Curso_Aluno (
    idCurso INT NOT NULL,
    idAluno INT NOT NULL,
    Ativo BOOLEAN,
    DtMatricula DATE,
    FOREIGN KEY (idCurso)
        REFERENCES Curso (idCurso),
    FOREIGN KEY (idAluno)
        REFERENCES Aluno (idAluno),
    PRIMARY KEY (idCurso , idAluno)
);

insert into Curso_Aluno (idCurso, idAluno, Ativo, DtMatricula) values
(1,1,1,'2018-04-23'),
(1,2,1,'2018-04-17'),
(1,3,0,'2018-03-12'),
(3,6,0,'2018-01-23'),
(4,4,1,'2018-03-13'),
(5,5,1,'2018-02-27');























