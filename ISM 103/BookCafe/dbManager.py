from sqlalchemy import create_engine, text
import os

class dbManager:
    def __init__(self):
        self.db_config = {
            "user": os.getenv("DB_USER"),
            "password": os.getenv("DB_PASSWORD"),
            "host": os.getenv("DB_HOST"),
            "port": os.getenv("DB_PORT"),
            "database": os.getenv("DB_NAME")
        }
        self.engine = self.connect_to_postgres(**self.db_config)


    def connect_to_postgres(self, user, password, host, port, database): 
        connection_string = f"postgresql+psycopg2://{user}:{password}@{host}:{port}/{database}"
        engine = create_engine(connection_string)
        return engine
    
    def execute_query(self, query):
        with self.engine.connect() as connection:
            ## this is silly a bit
            if query.strip().lower().startswith(("insert", "update", "delete", "create", "drop")):
                result = connection.execute(text(query))
                connection.commit()
                return result
            else:
                result = connection.execute(text(query))
                return result

# class dbManagerModelHeaven(dbManager):
#     def __init__(self):
#         super().__init__()

#     def add_a_thing_to_db(self, thing_description):
#         query = "INSERT INTO things (description) VALUES (:thing_description)"
#         params = {"thing_description": thing_description}

#         with self.engine.connect() as connection:
#             results = connection.execute(text(query), params)
#             connection.commit()
#             return results