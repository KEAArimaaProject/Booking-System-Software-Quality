1. setup .env 
2. cd .\database\
3. docker compose -f docker-compose.psql.yml up -d
4. mvn spring-boot:run or .\mvnw.cmd spring-boot:run

- Run all tests in the terminal root:
`scripts/run-all-tests.ps1`

[Jacoco Documentation](READMEfiles/Jacoco.md)
[SonarCloud Integration Guide](READMEfiles/SonarCloud.md)


## connect to database:

### start the database locally 
from Booking-System-Software-Quality\database in the terminal:

  docker compose -f docker-compose.psql.yml up -d

  docker compose -f docker-compose.psql.yml down -v

### Connect in datagrip

o connect to your database in DataGrip, use the following information based on your project's configuration:
🗄️ Database Connection Details (PostgreSQL)
•
Host: 127.0.0.1 (or localhost)
•
Port: 5434
•
User: booking_user
•
Password: booking_pass
•
Database: booking_system
•
URL (Reference): jdbc:postgresql://127.0.0.1:5434/booking_system
🛠️ DataGrip Setup Steps
1.
Click the + icon in the Database tool window and select Data Source > PostgreSQL.
2.
Enter the details above into the General tab.
3.
If DataGrip prompts for missing drivers, click the Download missing driver files link at the bottom of the dialog.
4.
Click Test Connection to ensure everything is working.
⚠️ Troubleshooting
•
Is the database running? Ensure you have started the Docker container by running docker compose -f database/docker-compose.psql.yml up -d in your terminal.
•
Port Conflict: Note that this project uses port 5434 to avoid conflicts with any local PostgreSQL instance you might already have running on the default port (5432).
•
Visibility: If you connect but don't see any tables, make sure you have "All Namespaces" or the specific public schema selected in the DataGrip "Schemas" tab.




