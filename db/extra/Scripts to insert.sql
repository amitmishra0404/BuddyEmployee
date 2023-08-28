USE `atliq_college_db`;

show tables;
CREATE TABLE faq_table (
    id INT AUTO_INCREMENT PRIMARY KEY,
    question VARCHAR(255) NOT NULL,
    answer TEXT NOT NULL
);

CREATE TABLE interactions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_question TEXT NOT NULL,
    assistant_response TEXT NOT NULL,
    source VARCHAR(50),
    interaction_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

truncate table faq_table;

INSERT INTO faq_table (question, answer,keywords)
VALUES
    ('What is the company policy on remote work?', 'The company policy on remote work allows employees to work from home up to three days a week.','WFM'),
    ('How do I request time off?', 'You can request time off through the HR portal or by submitting a paper request to your supervisor.','PTO'),
    ('What are the company holidays?', 'The company observes the following holidays: New Year\'s Day, Independence Day, Thanksgiving, and Christmas Day.','HOLIDAYS');
-- Insert script for HR policy: Requesting Time Off
INSERT INTO faq_table (question, answer, keywords)
VALUES (
    "Explain the company's policy for requesting time off and the procedure to follow.",
    "Employees are required to submit a time-off request through our HR portal at least two weeks in advance. The request should include the dates of leave, reason, and any relevant documents. The HR team reviews requests and notifies employees of approval or denial. For emergencies, contact your manager directly.",
    "time off policy, procedure, HR portal, request, approval"
);

-- Insert script for HR policy: Reporting Harassment or Discrimination
INSERT INTO faq_table (question, answer, keywords)
VALUES (
    "Describe the process employees should follow for reporting workplace harassment or discrimination.",
    "Employees who experience or witness harassment or discrimination should immediately report it to their supervisor or HR representative. Reports can be made verbally or in writing. The company takes all reports seriously and conducts thorough investigations to address the issue appropriately.",
    "harassment, discrimination, report, process, investigation"
);

-- Insert script for HR policy: Remote Work
INSERT INTO faq_table (question, answer, keywords)
VALUES (
    "What is the company's policy regarding remote work or telecommuting?",
    "Our company offers flexible remote work options for eligible employees. Remote work requests are subject to manager approval and should be submitted through our remote work request form. Employees are expected to maintain regular communication and meet performance expectations.",
    "remote work policy, telecommuting, eligibility, approval, communication"
);

-- Continue inserting scripts for other HR policies with actual answers and keywords...


ALTER TABLE faq_table
ADD Keywords varchar(255);
commit;
