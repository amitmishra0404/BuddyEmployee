import mysql.connector

def get_db_cursor():
    # Open database connection
    db = mysql.connector.connect(
        host="localhost",
        user="root",
        password="Password@123",
        database="atliq_college_db"
    )

    # Create a new cursor instance
    cursor = db.cursor()

    return db, cursor


def close_db_connection(db, cursor):
    # disconnect from server
    cursor.close()
    db.close()

def get_policies(params):
    db, cursor = get_db_cursor()
    cursor.callproc('get_policies', [params.get('policies', '')])
    result = None
    for res in cursor.stored_results():
        result = res.fetchone()[0]  # Fetch the first column of the first row
    close_db_connection(db, cursor)
    return result

def get_leavetypes(params):
    db, cursor = get_db_cursor()
    cursor.callproc('GetLeaveTypes', [params.get('policies', '')])
    result = None
    for res in cursor.stored_results():
        result = res.fetchone()[0]  # Fetch the first column of the first row
    close_db_connection(db, cursor)
    return result

if __name__ == "__main__":
    print(get_policies({
        'policies': 'What is the company\'s policy regarding remote work or telecommuting?'
    }))
    print(get_leavetypes({
        'policies': 'Vacation'
    }))

