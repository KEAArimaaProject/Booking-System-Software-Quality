1. setup .env 
2. cd .\database\
3. docker compose -f docker-compose.psql.yml up -d
4. mvn spring-boot:run or .\mvnw.cmd spring-boot:run

take the database down and set it up again:
`
docker compose -f .\database\docker-compose.psql.yml down --volumes --remove-orphans
docker compose -f .\database\docker-compose.psql.yml up -d
`

- Run all tests in the terminal root:
`scripts/run-all-tests.ps1`

[Jacoco Documentation](READMEfiles/Jacoco.md)
[SonarCloud Integration Guide](READMEfiles/SonarCloud.md)

For checking postrgres-db:
1. docker exec -it booking-postgres psql -U booking_user -d booking_system
2. To see databases: \l
3. To use database the: \c booking_system
4. To see list of tables: \dt
5. To get all bookings: SELECT * FROM bookings;
6. To exit: \q


## Weather API:
1. Go to https://www.weatherapi.com/signup.aspx.
2. Sign up for a free account.
3. Once logged in, go to your Dashboard.
4. Copy your API Key
the add the API key to the .env file.



--- Tests ci -- to be deleted

