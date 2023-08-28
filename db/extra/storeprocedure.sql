CREATE TABLE `faq_table` (
  `id` int NOT NULL AUTO_INCREMENT,
  `question` varchar(255) NOT NULL,
  `answer` text NOT NULL,
  `Keywords` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  FULLTEXT KEY `question` (`question`),
  FULLTEXT KEY `answer` (`answer`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE TABLE `leave_types` (
  `leave_type_id` int NOT NULL AUTO_INCREMENT,
  `leave_type_name` varchar(50) NOT NULL,
  `leave_type_description` text,
  PRIMARY KEY (`leave_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
DELIMITER $$
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
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetLeaveTypes`(IN requested_leave_type VARCHAR(50))
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
    
END$$
DELIMITER ;
