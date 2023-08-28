CREATE DEFINER=`root`@`localhost` PROCEDURE `get_policies`(IN Policies VARCHAR(1000))
BEGIN
    DECLARE result_answer VARCHAR(1683);
    
SELECT 
    answer
INTO result_answer FROM
    faq_table
WHERE
    Policies IS NOT NULL
        AND (keywords LIKE CONCAT('%', LOWER(Policies), '%')
        OR question LIKE CONCAT('%', LOWER(Policies), '%'))
LIMIT 1;

    IF result_answer IS NOT NULL THEN
        SELECT result_answer AS Result;
    ELSE
        SELECT -1 AS Result;
    END IF;
END