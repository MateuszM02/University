using System.Data.SqlClient;
using System.Text; // install

namespace net10
{
    public enum TableType
    {
        Student,
        Address,
        Town,
    }

    public interface IOperations
    {
        public void DownloadData(TableType tableType);
        public void AddData(
            string firstname, string lastname, DateTime dateOfBirth,
            string street, int houseNumber, int apartmentNumber, 
            string postalCode, int townID, string townName);
        public void UpdateData(
            TableType tableType, string propertyName, string propertyValue,
            string? predicateName=null, string? predicateValue=null);
        public void DeleteData(
            TableType tableType, string? predicateName=null, string? predicateValue=null);
    }

    public class Zad3 : IOperations
    {
        private SqlConnection connection_;

        public static void Main()
        {
            Zad3 zad3 = new();
            zad3.DownloadData(TableType.Student);
        }

        public Zad3()
        {
            string connectionString =
                "Server=DESKTOP-ULTB4MK\\SQLEXPRESS;Database=master;Integrated Security=True;\r\n";
            this.connection_ = new(connectionString);
            this.connection_.Open();
        }

        public void DownloadData(TableType tableType)
        {
            string sqlQuery = $"SELECT * FROM {tableType}";
            Console.WriteLine(sqlQuery);
            
            using SqlCommand sqlCommand = new(sqlQuery, this.connection_);
            using SqlDataReader reader = sqlCommand.ExecuteReader();
            
            while (reader.Read())
            {
                Console.WriteLine($"{reader["ID"]}, {reader["Imie"]}, {reader["Nazwisko"]}, {reader["DataUrodzenia"]}");
            }
        }

        private bool AddStudent(
            string firstname, string lastname, DateTime dateOfBirth)
        {
            // Sprawdzenie, czy student już istnieje
            string checkQuery = "SELECT COUNT(1) FROM Student WHERE " +
                "Imie = @Imie AND Nazwisko = @Nazwisko AND DataUrodzenia = @DataUrodzenia";
            using SqlCommand checkCommand = new(checkQuery, this.connection_);
            checkCommand.Parameters.AddWithValue("@Imie", firstname);
            checkCommand.Parameters.AddWithValue("@Nazwisko", lastname);
            checkCommand.Parameters.AddWithValue("@DataUrodzenia", dateOfBirth);

            int exists = (int)checkCommand.ExecuteScalar();
            if (exists > 0)
            {
                // Student już istnieje, nie dodawaj go ponownie
                return false;
            }

            string sqlQuery =
                "INSERT INTO Student (Imie, Nazwisko, DataUrodzenia) " +
                "VALUES (@Imie, @Nazwisko, @DataUrodzenia)";

            using SqlCommand sqlCommand = new(sqlQuery, this.connection_);

            sqlCommand.Parameters.AddWithValue($"@Imie", firstname);
            sqlCommand.Parameters.AddWithValue($"@Nazwisko", lastname);
            sqlCommand.Parameters.AddWithValue($"@DataUrodzenia", dateOfBirth);
            sqlCommand.ExecuteNonQuery();
            return true;
        }

        private bool AddAddress(
            string street, int houseNumber, int apartmentNumber,
            string postalCode, int townID)
        {
            string sqlQuery =
                "INSERT INTO Adres (Ulica, NrDomu, NrMieszkania, KodPocztowy, ID_MIEJSCOWOSC) " +
                "VALUES (@Ulica, @NrDomu, @NrMieszkania, @KodPocztowy, @ID_MIEJSCOWOSC)";

            using SqlCommand sqlCommand = new(sqlQuery, this.connection_);

            sqlCommand.Parameters.AddWithValue($"@Ulica", street);
            sqlCommand.Parameters.AddWithValue($"@NrDomu", houseNumber);
            sqlCommand.Parameters.AddWithValue($"@NrMieszkania", apartmentNumber);
            sqlCommand.Parameters.AddWithValue($"@KodPocztowy", postalCode);
            sqlCommand.Parameters.AddWithValue($"@ID_MIEJSCOWOSC", townID);
            sqlCommand.ExecuteNonQuery();
            return true;
        }

        private bool AddTown(string townName)
        {
            string sqlQuery =
                "INSERT INTO Miejscowosc (Nazwa) VALUES (@Nazwa)";

            using SqlCommand sqlCommand = new(sqlQuery, this.connection_);

            sqlCommand.Parameters.AddWithValue($"@Nazwa", townName);
            sqlCommand.ExecuteNonQuery();
            return true;
        }

        public void AddData(
            string firstname, string lastname, DateTime dateOfBirth, 
            string street, int houseNumber, int apartmentNumber, 
            string postalCode, int townID, string townName)
        {
            bool succededInsert =  
                AddStudent(firstname, lastname, dateOfBirth);
            succededInsert = succededInsert &&
                AddAddress(street, houseNumber, apartmentNumber, postalCode, townID);
            succededInsert = succededInsert &&
                AddTown(townName);
        }

        public void UpdateData(
            TableType tableType, string propertyName, string propertyValue, 
            string? predicateName=null, string? predicateValue=null)
        {
            // UPDATE Tablename SET name=@NAME [WHERE id=@ID]
            StringBuilder sqlQuery = new("UPDATE ");
            sqlQuery.Append(tableType);
            sqlQuery.Append(" SET ");
            sqlQuery.Append(propertyName);
            sqlQuery.Append(" = @");
            sqlQuery.Append(propertyName);
            if (predicateName != null)
            {
                sqlQuery.Append(" WHERE ");
                sqlQuery.Append(predicateName);
                sqlQuery.Append(" = @");
                sqlQuery.Append(predicateName);
            }

            using SqlCommand sqlCommand = 
                new(sqlQuery.ToString(), this.connection_);

            sqlCommand.Parameters.AddWithValue($"@{propertyName}", propertyValue);
            if (predicateName != null)
            {
                sqlCommand.Parameters.AddWithValue($"@{predicateName}", predicateValue);
            }
            sqlCommand.ExecuteNonQuery();
        }

        public void DeleteData(
            TableType tableType, string? predicateName = null, string? predicateValue = null)
        {
            // DELETE FROM Tablename [WHERE id=@ID]
            StringBuilder sqlQuery = new("DELETE FROM ");
            sqlQuery.Append(tableType);
            if (predicateName != null) 
            {
                sqlQuery.Append(" WHERE ");
                sqlQuery.Append(predicateName);
                sqlQuery.Append(" = @");
                sqlQuery.Append(predicateName);
            }

            using SqlCommand sqlCommand =
                new(sqlQuery.ToString(), this.connection_);
            
            if (predicateName != null)
            {
                sqlCommand.Parameters.AddWithValue($"@{predicateName}", predicateValue);
            }
            sqlCommand.ExecuteNonQuery();
        }
    }
}
