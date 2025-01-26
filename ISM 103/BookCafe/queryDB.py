from dbManager import dbManager

from dotenv import load_dotenv

load_dotenv()
dbManager = dbManager()



with open("queries/scheme.sql", "r") as file:
    query_to_execute = file.read()

## OR
# query_to_execute = """
# DROP SCHEMA public CASCADE;
# CREATE SCHEMA public;
# """


result = dbManager.execute_query(query_to_execute) 

# print(result)
# print(result.fetchall())