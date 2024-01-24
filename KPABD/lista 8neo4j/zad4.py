from neo4j import GraphDatabase

URI = "neo4j+s://50619dbb.databases.neo4j.io"
AUTH = ("neo4j", "gYzDKVQzH0lRlgxkX5ONuz8JrfBuYogHG8Js4Vb_Byg")

with GraphDatabase.driver(URI, auth=AUTH) as driver:
    try:
        driver.verify_connectivity()
        records, summary, keys = driver.execute_query(
            "MATCH (p:Person) RETURN p.name as name", database_="neo4j")
        counter = 0
        for j in records:
            for i in j.items():
                print(f'{counter}. {i[0]}:{i[1]};', sep='')
            counter+=1
        print()
    except Exception as e:
        print(e)