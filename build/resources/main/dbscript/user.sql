CREATE USER C##NAIN IDENTIFIED BY NAIN;
GRANT CONNECT, RESOURCE TO C##NAIN;
GRANT CREATE VIEW TO C##NAIN;
ALTER USER C##NAIN
QUOTA 1024M ON USERS;

