CREATE OR ALTER PROCEDURE dbo.sp_GetCars
    @CarID INT = NULL,
    @Brand NVARCHAR(100) = NULL,
    @Color NVARCHAR(50) = NULL,
    @Status NVARCHAR(50) = NULL,
    @PageSize INT = 20,
    @PageNumber INT = 1,
    @SortColumn NVARCHAR(128) = 'car_id',
    @SortDirection BIT = 0 -- 0: ASC, 1: DESC
AS
BEGIN
    SET NOCOUNT ON;

    -- Validate PageSize and PageNumber
    IF @PageSize <= 0 SET @PageSize = 20;
    IF @PageNumber <= 0 SET @PageNumber = 1;

    -- Define valid sort columns
    IF @SortColumn NOT IN ('car_id', 'model', 'brand', 'year', 'price', 'color', 'status')
        SET @SortColumn = 'car_id';

    -- Build dynamic SQL for sorting
    DECLARE @OrderBy NVARCHAR(MAX);
    SET @OrderBy = CASE WHEN @SortDirection = 0 THEN @SortColumn + ' ASC' ELSE @SortColumn + ' DESC' END;

    -- Query with filtering, sorting, and pagination
    SELECT *
    FROM Car
    WHERE (@CarID IS NULL OR car_id = @CarID)
      AND (@Brand IS NULL OR brand LIKE '%' + @Brand + '%')
      AND (@Color IS NULL OR color = @Color)
      AND (@Status IS NULL OR status = @Status)
    ORDER BY CASE 
                 WHEN @SortColumn = 'car_id' THEN car_id
                 WHEN @SortColumn = 'model' THEN model
                 WHEN @SortColumn = 'brand' THEN brand
                 WHEN @SortColumn = 'year' THEN year
                 WHEN @SortColumn = 'price' THEN price
                 WHEN @SortColumn = 'color' THEN color
                 WHEN @SortColumn = 'status' THEN status
             END
             OFFSET (@PageNumber - 1) * @PageSize ROWS
             FETCH NEXT @PageSize ROWS ONLY;
END
