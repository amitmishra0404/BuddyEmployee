Use atliq_college_db;
DROP procedure get_policies;
DELIMITER //
CREATE PROCEDURE get_policies(IN Policies VARCHAR(1000))
BEGIN
    DECLARE result_answer VARCHAR(1683);
    
    SELECT answer INTO result_answer
    FROM faq_table
    WHERE Policies IS NOT NULL AND (keywords LIKE CONCAT('%', Policies, '%') OR question LIKE CONCAT('%', Policies, '%'))
    LIMIT 1;

    IF result_answer IS NOT NULL THEN
        SELECT result_answer AS Result;
    ELSE
        SELECT -1 AS Result;
    END IF;
END //
DELIMITER ;

DELIMITER //

CREATE PROCEDURE GetLeaveTypes(IN requested_leave_type VARCHAR(50))
BEGIN
    DECLARE leave_types_result TEXT;
    
    SET leave_types_result = '';

    IF requested_leave_type IS NULL OR TRIM(requested_leave_type) = '' THEN
        -- No leave type specified or blank value passed
        SET leave_types_result = '-1';
    ELSE
        -- Specific leave type specified, fetch that leave type
        SELECT GROUP_CONCAT(CONCAT(leave_type_id, '. ', leave_type_name, '\n', leave_type_description, '\n\n') SEPARATOR '')
        INTO leave_types_result
        FROM leave_types
        WHERE leave_type_name = requested_leave_type;
    END IF;

    SELECT leave_types_result AS result;
    
END;
//

DELIMITER ;
