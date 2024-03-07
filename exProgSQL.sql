CREATE DATABASE ProgSQLEx
GO 
USE ProgSQLEx


--Fazer um algoritmo que leia 1 número e mostre se são múltiplos de 2,3,5 ou nenhum deles
DECLARE @num INT
SET @num = 23
IF (@num % 2 = 0)
BEGIN
	PRINT 'Multiplo de 2'
END
IF(@num % 3 = 0)
BEGIN 
    PRINT 'Multiplo de 3'
END
IF (@num % 5 = 0)
BEGIN
    PRINT 'Multiplo de 5'
END
ELSE
BEGIN
	PRINT 'Não é multiplo de 2,3 e 5'
END

--Fazer um algoritmo que leia 3 números e mostre o maior e o menor
DECLARE @num1 INT
DECLARE @num2 INT
DECLARE @num3 INT 
SET @num1 = 60
SET @num2 = 15
SET @num3 = 2

--Fazer um algoritmo que leia 3 números e mostre o maior e o menor
DECLARE @numero1 INT, @numero2 INT, @numero3 INT;
SET @numero1 = 60;
SET @numero2 = 17;
SET @numero3 = 2;
SELECT
    GREATEST(@numero1, @numero2, @numero3) AS MaiorNumero,
    LEAST(@numero1, @numero2, @numero3) AS MenorNumero;

--Fazer um algoritmo que calcule os 15 primeiros termos da série
--1,1,2,3,5,8,13,21,...
--E calcule a soma dos 15 termos

DECLARE @n INT
DECLARE @n2 INT
SET @n = 1
SET @n2 = 1
DECLARE @proximo INT;
SET  @proximo = 0;
DECLARE @soma INT = 2
DECLARE @contador INT = 3
PRINT @n
PRINT @n2
WHILE (@contador <= 15)
BEGIN
SET @proximo = @n + @n2;
SET @soma = @soma + @proximo;
PRINT @proximo;
SET @n = @n2;
SET @n2 = @proximo;
SET @contador = @contador + 1;
END
PRINT 'A soma é: ' + CAST(@soma AS VARCHAR(MAX));

--Fazer um algoritmo que separa uma frase, colocando todas as letras em maiúsculo e em
--minúsculo (Usar funções UPPER e LOWER)
DECLARE @frase VARCHAR(100) = 'Alguma frase aqui';
DECLARE @maiusculo VARCHAR(100);
DECLARE @minusculo VARCHAR(100);
SET @maiusculo = UPPER(@frase);
SET @minusculo = LOWER(@frase);
PRINT @maiusculo;
PRINT @minusculo;


--e) Fazer um algoritmo que inverta uma palavra (Usar a função SUBSTRING)
DECLARE @p VARCHAR(100) = 'exemplo';
DECLARE @pi  VARCHAR(100) = '';
DECLARE @numcaracter INT = LEN(@p);
DECLARE @conta INT = @numcaracter;
WHILE @conta > 0
BEGIN
    SET @pi = @pi + SUBSTRING(@p, @conta, 1);
    SET @conta = @conta - 1;
END
   PRINT @pi;

CREATE TABLE computador (
id INT NOT NULL,
marca VARCHAR(40) NOT NULL,
qtdram INT NOT NULL,
tipohd VARCHAR(10) NOT NULL,
qtdhd INT NOT NULL,
freqcpu DECIMAL (7,2) NOT NULL
PRIMARY KEY(id)
)

DECLARE @Numeros TABLE (Number INT)
INSERT INTO @Numeros VALUES (500), (1000), (2000)

DECLARE @Numeros1 TABLE (Number1 INT)
INSERT INTO @Numeros1 VALUES (128), (256), (512)

DECLARE @IDInicial INT = 10001
DECLARE @IDAtual INT = @IDInicial
DECLARE @QuantidadeRegistros INT = 100

WHILE @IDAtual < @IDInicial + @QuantidadeRegistros
BEGIN
    DECLARE @tipohd VARCHAR(100)
    SET @tipohd = CASE WHEN @IDAtual % 3 = 0 THEN 'HDD'
                      WHEN @IDAtual % 3 = 1 THEN 'SSD'
                      WHEN @IDAtual % 3 = 2 THEN 'M2 NVME'
                 END
    DECLARE @NumeroAleatorio INT

    IF @tipohd = 'HDD'
        SELECT TOP 1 @NumeroAleatorio = Number FROM @Numeros ORDER BY NEWID()
    ELSE IF @tipohd = 'SSD'
        SELECT TOP 1 @NumeroAleatorio = Number1 FROM @Numeros1 ORDER BY NEWID()
    ELSE
        SET @NumeroAleatorio = 100

    INSERT INTO Computador (ID, Marca, QtdRAM, TipoHD, QtdHD, FreqCPU)
    VALUES (
        @IDAtual,
        'Marca ' + CAST(@IDAtual - @IDInicial + 1 AS VARCHAR),
        POWER(2, ABS(CHECKSUM(NEWID()) % 4) + 1),
        @tipohd,
        @NumeroAleatorio,
        RAND() * (3.20 - 1.70) + 1.70  
    )
    SET @IDAtual = @IDAtual + 1
END


SELECT * FROM computador

DROP TABLE computador

