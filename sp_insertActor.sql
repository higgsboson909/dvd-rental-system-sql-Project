-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

-- Create Insert Procedure
CREATE PROCEDURE sp_InsertActor
    @first_name varchar(100),
    @last_name varchar(100)
	


AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @actor_id int;
    SET @actor_id = (SELECT ISNULL(MAX(actor_id), 0) + 1 FROM Actor);
    INSERT INTO Actor (actor_id, first_name, last_name)
    VALUES (@actor_id, @first_name, @last_name);
END
GO
--drop procedure sp_InsertActor
--select * from actor