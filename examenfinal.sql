create DATABASE examenfinal
go
use examenfinal

go

CREATE TABLE Agentes (
    ID_Agente INT identity PRIMARY KEY,
    Nombre VARCHAR(50),
  
)
go

CREATE TABLE Clientes (
    ID_Cliente int primary key,
    Nombre VARCHAR(50),
    Email VARCHAR(100),
    Telefono VARCHAR(20)
)
go
CREATE TABLE Casas (
    ID_Casa INT  PRIMARY KEY,
    Direccion VARCHAR(100),
    Ciudad VARCHAR(50),
    Precio DECIMAL(10, 2)
)
go
CREATE TABLE Ventas (
    ID_Venta INT identity PRIMARY KEY,
    ID_Agente INT,
    ID_Cliente INT,
    ID_Casa INT,
    Fecha DATE,
    constraint fk_ID_Agente FOREIGN KEY (ID_Agente) REFERENCES Agentes(ID_Agente),
    constraint fk_ID_Cliente FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID_Cliente),
    constraint fkID_Casa FOREIGN KEY (ID_Casa) REFERENCES Casas(ID_Casa)
)
go

Create PROCEDURE InsertarAgentes


@Nombre VARCHAR(50),
@ID_Agente INT


as

begin

set identity_insert agentes on;

INSERT INTO Agentes (Nombre, ID_Agente) VALUES (@Nombre, @ID_Agente);

set identity_insert agentes off;

end;

exec InsertarAgentes @nombre = 'Juan Pérez', @ID_Agente=1; 

exec InsertarAgentes @nombre = 'María López', @ID_Agente=2; 

exec InsertarAgentes @nombre = 'Carlos González', @ID_Agente=3; 


Create PROCEDURE AgregarClientes

@Nombre VARCHAR(50),
@email VARCHAR(100),
@telefono VARCHAR(20)


as

begin

INSERT INTO Clientes(Nombre, Email, Telefono) VALUES
('Laura Martínez', 'laura@example.com', '111-222-3333'),
('Pedro Rodríguez', 'pedro@example.com', '444-555-6666'),
('Ana García', 'ana@example.com', '777-888-9999');

end;

exec AgregarClientes 'Laura Martínez', 'laura@example.com', '111-222-3333';

exec AgregarClientes 'Pedro Rodríguez', 'pedro@example.com', '444-555-6666';

exec AgregarClientes 'Ana García', 'ana@example.com', '777-888-9999';


Create PROCEDURE AgregarCasas

@Direccion VARCHAR(100),
@ciudad VARCHAR(50),
@precio decimal(10, 2)


as

begin

INSERT INTO Casas (Direccion, Ciudad, Precio) VALUES
('Calle 123', 'Madrid', 250000.00),
('Avenida 456', 'Barcelona', 300000.00),
('Calle 789', 'Valencia', 200000.00);

end;

exec AgregarCasas 'Calle 123', 'Madrid', 250000.00;

exec AgregarCasas 'Avenida 456', 'Barcelona', 300000.00;

exec AgregarCasas 'Calle 789', 'Valencia', 200000.00;

Create PROCEDURE AgregarVentas

@ID_Agente int,
@ID_Cliente int,
@ID_Casa int,
@Fecha date


as

begin

INSERT INTO Ventas (ID_Agente, ID_Cliente, ID_Casa, Fecha) VALUES
(1, 2, 1, '2024-04-01'),
(2, 3, 2, '2024-04-03'),
(3, 1, 3, '2024-04-05');

end;

exec AgregarVentas 1, 2, 1, '2024-04-01';

exec AgregarVentas 2, 3, 2, '2024-04-03';

exec AgregarVentas 3, 1, 3, '2024-04-05';

  

select * from agentes
select * from casas
select * from Clientes
select * from ventas

CREATE PROCEDURE GestionarAgentes
    @accion NVARCHAR(10),
    @ID_Agente INT = NULL,
    @Nombre NVARCHAR(50) = NULL
    
AS
BEGIN
    IF @accion = 'agregar'
    BEGIN
        INSERT INTO Agentes (Nombre, ID_Agente) VALUES (@Nombre, @ID_Agente);
    END
    ELSE IF @accion = 'borrar'
    BEGIN
        DELETE FROM Agentes WHERE @ID_Agente = @ID_Agente;
    END
    ELSE IF @accion = 'modificar'
    BEGIN
        UPDATE Agentes SET 
            Nombre = @Nombre
            
        WHERE @ID_Agente = @ID_Agente;
    END
    ELSE IF @accion = 'consultar'
    BEGIN
        SELECT * FROM Agentes;
    END
    ELSE
    BEGIN
        SELECT 'Acción no válida';
    END
END


EXEC GestionarAgentes 'agregar', NULL, 'Nuevo Agente';
EXEC GestionarAgentes 'borrar', 4;
EXEC GestionarAgentes 'modificar', 1, 'Juan Pérez Modificado';
EXEC GestionarAgentes 'consultar';