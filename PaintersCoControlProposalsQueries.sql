
-- PaintersCoCtrlProposal

-- Control of Proposal of Painters Companies
-- By Patricia Zajia

-----------------------------------------------------------------------------------------------------------------------
--* Write a SELECT query that uses a WHERE clause
----------------------------------------------------------------------------------------------------------------------
SELECT SocialSecurity, [NAME], [ADDRESS], CITY, ZIP, EMAIL, PHONE
FROM [PaintersCoCtrlProposals].[dbo].[Customers]
WHERE State = 'KY'

----------------------------------------------------------------------------------------------------------------------
--* Write a SELECT query that uses an OR and an AND operator
----------------------------------------------------------------------------------------------------------------------
SELECT p.CustomerId, c.[Name], c.[Address], c.City, p.Description
FROM [PaintersCoCtrlProposals].[dbo].[Projects] p
JOIN [PaintersCoCtrlProposals].[dbo].[Customers] c
ON p.CustomerId = c.CustomerId
WHERE p.City = 'Louisville'
AND (p.CustomerId = 1 OR p.CustomerId = 5)

----------------------------------------------------------------------------------------------------------------------
--* Write a SELECT query that filters NULL rows using IS NOT NULL
----------------------------------------------------------------------------------------------------------------------
SELECT p.Description AS Product, p.Price, c.Description AS Category
FROM [PaintersCoCtrlProposals].[dbo].[Products] p   
JOIN [PaintersCoCtrlProposals].[dbo].[Categories] c
ON p.CategoryId = c.CategoryId
WHERE p.CategoryId IS NOT NULL

----------------------------------------------------------------------------------------------------------------------
--* Write a DML statement that UPDATEs a set of rows with a WHERE clause. 
--* The values used in the WHERE clause should be a variable
----------------------------------------------------------------------------------------------------------------------
Declare @Zip int = 40222;

UPDATE [PaintersCoCtrlProposals].[dbo].[Projects]
SET [State] = 'IN' 
WHERE Zip = @Zip

----------------------------------------------------------------------------------------------------------------------
--* Write a DML statement that DELETEs a set of rows with a WHERE clause. 
--* The values used in the WHERE clause should be a variable
----------------------------------------------------------------------------------------------------------------------
Declare @Customer_del int = 2;

DELETE FROM [PaintersCoCtrlProposals].[dbo].[Customers]  
WHERE CustomerId = @Customer_del 

----------------------------------------------------------------------------------------------------------------------
-- Write a DML statement that DELETEs rows from a table that another table
-- references. This script will have to also DELETE any records that reference 
-- these rows. Both of the DELETE statements need to be wrapped in a single
-- TRANSACTION.
----------------------------------------------------------------------------------------------------------------------
Declare @ProposalId_del int = 4;

DELETE FROM [PaintersCoCtrlProposals].[dbo].[ProposalProducts]
WHERE ProposalId = @ProposalId_del

DELETE FROM [PaintersCoCtrlProposals].[dbo].[Proposals]
WHERE ProposalId = @ProposalId_del

--
-- Dumping data for table Proposal
--
--INSERT INTO [PaintersCoCtrlProposals].[dbo].[Proposals] (ProposalId, ProjectId, ContractorsId, [Address], City, [State], Zip, [Date], [PStatus]) VALUES
--(4, 2, 3, '12163 Westport Rd. Apt.2', 'Louisville', 'KY', '40222','12/25/2020','Finished')

--
-- Dumping data for table ProposalProducts
--
--INSERT INTO [PaintersCoCtrlProposals].[dbo].[ProposalProducts] (ProposalId, ProductId, Amount, Discount, Price, [Description]) VALUES
--(4, 1, 1, 10.0, 8.60, 'No Removing dust'),
--(4, 2, 1,  9.50, 8.50, 'Paint in Purple'),
--(4, 3, 1,  9.50, 8.50, 'Paint in White'),
--(4, 4, 1, 11.50, 7.50, 'Moving Furniture'),
--(4, 5, 1, 10.0, 8.35, 'No Removing dust'),
--(4, 6, 1,  9.50, 10.00, 'Paint in Purple'),
--(4,  7, 1,  9.50, 3.40, 'Paint in White'),
--(4,  8, 1, 11.50, 5.60, 'Moving Furniture'),
--(4,  9, 1, 10.0, 8.80, 'No Removing dust'),
--(4, 10, 1,  9.50, 8.80, 'Paint in White'),
--(4, 11, 1,  9.50, 8.90, 'Paint in White')

----------------------------------------------------------------------------------------------------------------------
--* Write a SELECT query that utilizes a JOIN
----------------------------------------------------------------------------------------------------------------------
SELECT C.[Name], P.[Description]
FROM [PaintersCoCtrlProposals].[dbo].[Customers]  C
JOIN [PaintersCoCtrlProposals].[dbo].[Projects] P
On C.CustomerId= P.CustomerId

----------------------------------------------------------------------------------------------------------------------
--* Write a SELECT query that utilizes a JOIN with 3 or more tables
----------------------------------------------------------------------------------------------------------------------
SELECT C.[Name], P.[Description], PP.ProposalId
FROM [PaintersCoCtrlProposals].[dbo].[Customers] C
JOIN [PaintersCoCtrlProposals].[dbo].[Projects] P
On C.CustomerId= P.CustomerId
JOIN [PaintersCoCtrlProposals].[dbo].[Proposals] PP
On P.ProjectId= PP.ProjectId

----------------------------------------------------------------------------------------------------------------------
--* Write a SELECT query that utilizes a LEFT JOIN
----------------------------------------------------------------------------------------------------------------------
SELECT  P.[Description], PP.ProposalId, S.[Description]
FROM [PaintersCoCtrlProposals].[dbo].[Projects] P
LEFT JOIN [PaintersCoCtrlProposals].[dbo].[Proposals]  PP
On P.ProjectId= PP.ProjectId
LEFT JOIN [PaintersCoCtrlProposals].[dbo].[ProposalProducts] PP_S
ON PP.ProposalId= PP_S.ProposalId
LEFT JOIN [PaintersCoCtrlProposals].[dbo].[Products] S
ON PP_S.ProductId= S.ProductId

----------------------------------------------------------------------------------------------------------------------
--* Write a SELECT query that utilizes a variable in the WHERE clause
----------------------------------------------------------------------------------------------------------------------
DECLARE @ProposalState Varchar(10)  = 'Finished'

SELECT  *
FROM [PaintersCoCtrlProposals].[dbo].[Proposals] p
WHERE p.PStatus = @ProposalState

----------------------------------------------------------------------------------------------------------------------
--* Write a SELECT query that utilizes a ORDER BY clause
----------------------------------------------------------------------------------------------------------------------
SELECT  P.[Description], PP.ProposalId, S.[Description]
FROM [PaintersCoCtrlProposals].[dbo].[Projects] P
LEFT JOIN [PaintersCoCtrlProposals].[dbo].[Proposals]  PP
ON P.ProjectId = PP.ProjectId
LEFT JOIN [PaintersCoCtrlProposals].[dbo].[ProposalProducts] PP_S
ON PP.ProposalId= PP_S.ProposalId
LEFT JOIN [PaintersCoCtrlProposals].[dbo].[Products]  S
ON PP_S.ProductId= S.ProductId
ORDER BY P.[Description], PP.ProposalId, S.[Description]

----------------------------------------------------------------------------------------------------------------------
--* Write a SELECT query that utilizes a GROUP BY clause along with an
--* aggregate Function
----------------------------------------------------------------------------------------------------------------------
SELECT  P.[Description], PP.ProposalId, S.[Description], SUM(PP_S.Amount) as Total
FROM [PaintersCoCtrlProposals].[dbo].[Projects] P
LEFT JOIN [PaintersCoCtrlProposals].[dbo].[Proposals]  PP
On P.ProjectId= PP.ProjectId
LEFT JOIN [PaintersCoCtrlProposals].[dbo].[ProposalProducts] PP_S
ON PP.ProposalId= PP_S.ProposalId
LEFT JOIN [PaintersCoCtrlProposals].[dbo].[Products] S
ON PP_S.ProductId= S.ProductId
GROUP BY P.[Description], PP.ProposalId, S.[Description]

----------------------------------------------------------------------------------------------------------------------
--* Write a SELECT query that utilizes a CALCULATED FIELD
----------------------------------------------------------------------------------------------------------------------
SELECT  P.[Description], PP.ProposalId, S.[Description], 
                PP_S.Price - (PP_S.Price * PP_S.Discount/100) as Price_Reduced
FROM [PaintersCoCtrlProposals].[dbo].[Projects] P
LEFT JOIN [PaintersCoCtrlProposals].[dbo].[Proposals]  PP
On P.ProjectId= PP.ProjectId
LEFT JOIN [PaintersCoCtrlProposals].[dbo].[ProposalProducts] PP_S
ON PP.ProposalId = PP_S.ProposalId
LEFT JOIN [PaintersCoCtrlProposals].[dbo].[Products] S
ON PP_S.ProductId= S.ProductId

----------------------------------------------------------------------------------------------------------------------
--* Write a SELECT query that utilizes a SUBQUERY
----------------------------------------------------------------------------------------------------------------------
SELECT  P.[Description], PP.ProposalId, S.[Description]
FROM [PaintersCoCtrlProposals].[dbo].[Projects] P
LEFT JOIN [PaintersCoCtrlProposals].[dbo].[Proposals]  PP
On P.ProjectId= PP.ProjectId
LEFT JOIN [PaintersCoCtrlProposals].[dbo].[ProposalProducts] PP_S
ON PP.ProposalId= PP_S.ProposalId
LEFT JOIN [PaintersCoCtrlProposals].[dbo].[Products] S
ON PP_S.ProductId= S.ProductId
WHERE PP.ContractorsId IN (SELECT ContractorsId FROM [PaintersCoCtrlProposals].[dbo].[Contractors])

----------------------------------------------------------------------------------------------------------------------
--* Write a SELECT query that utilizes a JOIN, at least 2 OPERATORS 
--* (AND, OR, =, IN, BETWEEN, ETC) AND A GROUP BY clause 
--* with an aggregate function
----------------------------------------------------------------------------------------------------------------------
Declare @Inicio_Date Date = '2010-01-01',
        @Fin_Date Date = '2020-08-30',
        @Status Varchar(10) = 'KY'

SELECT  P.[Description], PP.ProposalId, S.[Description], 
                SUM(PP_S.Price * PP_S.Amount) as Total_Amount
FROM [PaintersCoCtrlProposals].[dbo].[Projects] P
LEFT JOIN [PaintersCoCtrlProposals].[dbo].[Proposals] PP
On P.ProjectId= PP.ProjectId
LEFT JOIN [PaintersCoCtrlProposals].[dbo].[ProposalProducts] PP_S
ON PP.ProposalId= PP_S.ProposalId
LEFT JOIN [PaintersCoCtrlProposals].[dbo].[Products] S
ON PP_S.ProductId= S.ProductId
WHERE PP.PStatus = @Status
AND PP.[Date] BETWEEN @Inicio_Date AND @Fin_Date 
GROUP BY P.[Description], PP.ProposalId, S.[Description]

----------------------------------------------------------------------------------------------------------------------
-- Write a SELECT query that utilizes a JOIN with 3 or more tables, 
-- at 2 OPERATORS (AND, OR, =, IN, BETWEEN, ETC), a GROUP BY clause
--  with an aggregate function, and a HAVING clause
----------------------------------------------------------------------------------------------------------------------
Declare @Inicio_Date Date = '2010-01-01',
        @Fin_Date Date = '2020-08-30',
        @State Varchar(10) = 'KY'

SELECT  P.[Description], PP.ProposalId, S.[Description], 
                SUM((PP_S.Price - (PP_S.Price * PP_S.Discount/100)) * PP_S.Amount) as Total_Amount
FROM [PaintersCoCtrlProposals].[dbo].[Projects] P
LEFT JOIN [PaintersCoCtrlProposals].[dbo].[Proposals]  PP
On P.ProjectId= PP.ProjectId
LEFT JOIN [PaintersCoCtrlProposals].[dbo].[ProposalProducts] PP_S
ON PP.ProposalId= PP_S.ProposalId
LEFT JOIN [PaintersCoCtrlProposals].[dbo].[Products] S
ON PP_S.ProductId= S.ProductId
WHERE P.[State] = @State
AND PP.[Date] BETWEEN @Inicio_Date AND @Fin_Date 
GROUP BY P.[Description], PP.ProposalId, S.[Description]
HAVING   SUM((PP_S.Price - (PP_S.Price * PP_S.Discount/100)) * PP_S.Amount)   >  10
