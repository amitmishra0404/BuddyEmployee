use atliq_college_db;
show tables 
select * from faq_table;

-- Create the table to store leave types
CREATE TABLE leave_types (
    leave_type_id INT AUTO_INCREMENT PRIMARY KEY,
    leave_type_name VARCHAR(50) NOT NULL,
    leave_type_description TEXT
);

-- Insert sample data into the leave_types table
INSERT INTO leave_types (leave_type_name, leave_type_description) VALUES
    ('Vacation', 'Paid time off for relaxation and travel.'),
    ('Sick Leave', 'Paid time off for illness and medical reasons.'),
    ('Maternity/Paternity Leave', 'Paid time off for new parents to care for their newborn.'),
    ('Personal Leave', 'Unpaid time off for personal reasons.'),
    ('Public Holiday', 'Days off to observe public holidays.'),
    ('Bereavement Leave', 'Paid time off for coping with the loss of a loved one.');

-- Display the inserted data
SELECT * FROM leave_types;

SELECT 
    answer
 FROM
    faq_table
WHERE
     (keywords LIKE CONCAT('%', LOWER('ethic'), '%')
        OR question LIKE CONCAT('%', LOWER('ethic'), '%'))

