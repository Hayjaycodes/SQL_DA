-- Loading data into dimension and fact tables from CSV files


\copy company_dim FROM 'C:\\Users\\ASUS TUF\\OneDrive\\Desktop\\DataAnalysis\\SQL_DA\\csv_files\\company_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy skills_dim FROM 'C:\\Users\\ASUS TUF\\OneDrive\\Desktop\\DataAnalysis\\SQL_DA\\csv_files\\skills_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy job_postings_fact FROM 'C:\\Users\\ASUS TUF\\OneDrive\\Desktop\\DataAnalysis\\SQL_DA\\csv_files\\job_postings_fact.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy skills_job_dim FROM 'C:\\Users\\ASUS TUF\\OneDrive\\Desktop\\DataAnalysis\\SQL_DA\\csv_files\\skills_job_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

