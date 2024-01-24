using MongoDB.Bson;
using MongoDB.Bson.IO;
using MongoDB.Bson.Serialization.Attributes;
using MongoDB.Driver;
using MongoDB.Driver.Linq;
using System.Text.RegularExpressions;

namespace DBC
{    
    class Program
    {
        static void Main()
        {
            // Task1.Main.Write();
            // Task2.Main.Write();
            // Task3.Main.Write();
            // Task4.Main.Write();
        }
    }
}

namespace Task1 
{
    public class Author(int id, string name)
    {
        [BsonElement("_id")]
        public object Id { get; set; } = id;

        [BsonElement("name")]
        public string Name { get; set; } = name;
    }

    public static class Main 
    {
        public static void Write()
        {
            var client = new MongoClient();
            var library = client.GetDatabase("library");
            var authors = library.GetCollection<Author>("authors");
            var items = from b in authors.AsQueryable()
                        select b;

            foreach (var e in items)
            {
                Console.WriteLine(e.Name);
            }
        }
    }
}

namespace Task2 
{
    public class Book(object id, string isbn, string title, string author, 
                        int year, double price, IEnumerable<Book.Copy> copies)
    {
        public class Copy(string signature)
        {
            [BsonElement("Signature")]
            public string Signature { get; set; } = signature;
        }

        [BsonElement("_id")]
        public object Id { get; set; } = id;
        [BsonElement("ISBN")]
        public string ISBN { get; set; } = isbn;
        [BsonElement("Title")]
        public string Title { get; set; } = title;
        [BsonElement("Author")]
        public string Author { get; set; } = author;
        [BsonElement("Year")]
        public int Year { get; set; } = year;
        [BsonElement("Price")]
        public double Price { get; set; } = price;
        [BsonElement("Copies")]
        public IEnumerable<Copy> Copies { get; set; } = copies;

        static readonly Book Book1 = new(1, "83-246-0279-8", "Microsoft Access. Podrecznik administratora", "Helen Feddema",
                                        2006, 69, [new Copy("S0003"), new Copy("S0004")]);
        static readonly Book Book2 = new(2, "83-246-0653-X", "SQL Server 2005. Programowanie. Od podstaw", "Robert Vieira",
                                        2007, 97, [new Copy("S0006")]);
        static readonly Book Book3 = new(3, "978-83-246-0549-1", "SQL Server 2005. Wycisnij wszystko", "Eric L. Brown", 
                                        2007, 57, [new Copy("S0007"), new Copy("S0008"), new Copy("S0009"), new Copy("S0010")]);
        static readonly Book Book4 = new(4, "978-83-246-1258-1", 
                                        "PHP, MySQL i MVC. Tworzenie witryn WWW opartych na bazie danych", 
                                        "Wlodzimierz Gajda", 2010, 79, 
                                        [new Copy("S0013"), new Copy("S0014"), new Copy("S0015")]);

        public static IEnumerable<Book> GetBooksTask2()
        {
            return [Book1, Book2];
        }

        public static IEnumerable<Book> GetBooksTask4()
        {
            return [Book1, Book2, Book3, Book4];
        }
    }

    public class Reader(int id, string pesel, string lastname, string city, 
                        DateTime dateOfBirth, DateTime? lastLoan, IEnumerable<Reader.Loan> loans)
    {
        public class Loan(string signature, DateTime date, int days)
        {
            [BsonElement("Signature")]
            public string Signature { get; set; } = signature;
            [BsonElement("Date")]
            public DateTime Date { get; set; } = date;
            [BsonElement("Days")]
            public int Days { get; set; } = days;
        }

        [BsonElement("_id")]
        public int ID { get; set; } = id;
        [BsonElement("PESEL")]
        public string PESEL { get; set; } = pesel;
        [BsonElement("Lastname")]
        public string Lastname { get; set; } = lastname;
        [BsonElement("City")]
        public string City { get; set; } = city;
        [BsonElement("DateOfBirth")]
        public DateTime DateOfBirth { get; set; } = dateOfBirth;
        [BsonElement("LastLoan")]
        public DateTime? LastLoan { get; set; } = lastLoan;
        [BsonElement("LoansList")]
        public IEnumerable<Loan> LoansList { get; set; } = loans;

        public static IEnumerable<Reader> GetReaders()
        {
            List<Reader> listOfReaders = [
                new Reader(1, "55101011111", "Kowalski", "Wroclaw",
                            JsonConvert.ToDateTime("1955-10-10"), JsonConvert.ToDateTime("2020-02-01"),
                            [new Loan("S0003", JsonConvert.ToDateTime("2020-02-02"), 12),
                             new Loan("S0006", JsonConvert.ToDateTime("2019-12-01"), 24)]),
                new Reader(2, "60101033333", "Maliniak", "Wroclaw",
                            JsonConvert.ToDateTime("1960-10-10"), JsonConvert.ToDateTime("2021-02-05"),
                            [new Loan("S0003", JsonConvert.ToDateTime("2021-02-05"), 14),
                             new Loan("S0004", JsonConvert.ToDateTime("2019-12-15"), 28)])
            ];
            return listOfReaders;
        }
    }

    public static class Main
    {
        public static void Write()
        {
            var client = new MongoClient();
            var database = client.GetDatabase("task2");
            // database.CreateCollection("books"); // run only 1 time
            var books = database.GetCollection<Book>("books");
            books.DeleteMany(book => true); // delete all books
            books.InsertMany(Book.GetBooksTask2()); // insert them back

            // database.CreateCollection("readers"); // run only 1 time
            var readers = database.GetCollection<Reader>("readers");
            readers.DeleteMany(readers => true); // delete all readers
            readers.InsertMany(Reader.GetReaders()); // insert them back

            // show all book titles
            foreach (Book book in books.AsQueryable())
            {
                Console.WriteLine(book.Title);
            }

            // show all reader lastnames
            foreach (Reader reader in readers.AsQueryable())
            {
                Console.WriteLine(reader.Lastname);
            }
        }
    }
}

namespace Task3 
{
    public static class Main
    {
        static void CreateValidatorBooks(IMongoDatabase database) 
        {
            // parts of validation schema
            BsonElement ISBN = new("ISBN", new BsonDocument(
                                    new List<BsonElement> {
                                        new("bsonType", "string"),
                                        new("description", "is required and must be string")
                                    }));
            BsonElement Title = new("Title", new BsonDocument(
                                    new List<BsonElement> {
                                        new("bsonType", "string"),
                                        new("description", "is required and must be string")
                                    }));
            BsonElement Author = new("Author", new BsonDocument(
                                    new List<BsonElement> {
                                        new("bsonType", "string"),
                                        new("description", "is required and must be string")
                                    }));
            BsonElement Year = new("Year", new BsonDocument(
                                    new List<BsonElement> {
                                        new("bsonType", "int"),
                                        new("minimum", 0),
                                        new("maximum", 2100),
                                        new("description", "is required and must be INT")
                                    }));
            BsonElement Copies = new("Copies", new BsonDocument(
                                    new List<BsonElement> {
                                        new("bsonType", new BsonArray { "array" }),
                                        new("minItems", 0),
                                        new("uniqueItems", true),
                                        new("items", new BsonDocument (
                                            new List<BsonElement> {
                                                new("bsonType", new BsonArray { "object" }),
                                                new("required", new BsonArray { "Signature" }),
                                                new("properties", new BsonDocument (
                                                    new List<BsonElement> {
                                                        new("Signature", new BsonDocument (
                                                            new List<BsonElement> {
                                                                new("bsonType", "string"),
                                                                new("pattern", "^S[0-9]{4,}$"),
                                                                new("description", "is required and must be string and match regular expression")
                                                            }
                                                        ))
                                                    }
                                                ))
                                            }
                                        ))
                                    }
                                ));

            // validation schema
            BsonDocument command = new BsonDocument(
                new List<BsonElement> {
                    new("collMod", "books"),
                    new("validator", new BsonDocument (
                        new List<BsonElement> {
                            new("$jsonSchema", new BsonDocument (
                                new List<BsonElement> {
                                    new("bsonType", "object"),
                                    new("required", new BsonArray { "ISBN", "Title", "Author", "Year" }),
                                    new("properties", new BsonDocument (
                                        new List<BsonElement> { ISBN, Title, Author, Year, Copies }))
                                }
                            ))
                        }
                    ))
                }
            );
            
            BsonDocument? result = database.RunCommand<BsonDocument>(command);
            Console.WriteLine(result.ToString());

            BsonDocument? isValid = new("validate", "books");
            BsonDocument? validResult = database.RunCommand<BsonDocument>(isValid);
            Console.WriteLine(validResult.ToString());
        }

        static void CreateValidatorReaders(IMongoDatabase database)
        {
            // parts of validation schema
            BsonElement PESEL = new("PESEL", new BsonDocument(
                                    new List<BsonElement> {
                                        new("bsonType", "string"),
                                        new("pattern", "^[0-9]{11}$"),
				                        new("description", "is required and must be string and match regular expression")
                                    }));
            BsonElement Lastname = new("Lastname", new BsonDocument(
                                    new List<BsonElement> {
                                        new("bsonType", "string"),
                                        new("description", "is required and must be string")
                                    }));
            BsonElement City = new("City", new BsonDocument(
                                    new List<BsonElement> {
                                        new("bsonType", "string"),
                                        new("description", "is required and must be string")
                                    }));
            BsonElement DateOfBirth = new("DateOfBirth", new BsonDocument(
                                    new List<BsonElement> {
                                        new("bsonType", "date"),
                                        new("minimum", 0),
                                        new("maximum", 2100),
                                        new("description", "is required and must be INT")
                                    }));
            BsonElement LastLoan = new("LastLoan", new BsonDocument(
                                    new List<BsonElement> {
                                        new("bsonType", "date"),
                                        new("minimum", 0),
                                        new("maximum", 2100),
                                        new("description", "is required and must be INT")
                                    }));
            BsonElement LoansList = new("LoansList", new BsonDocument(
                                    new List<BsonElement> {
                                        new("bsonType", new BsonArray { "array" }),
                                        new("minItems", 0),
                                        new("uniqueItems", true),
                                        new("items", new BsonDocument (
                                            new List<BsonElement> {
                                                new("bsonType", new BsonArray { "object" }),
                                                new("required", new BsonArray { "Signature", "Date", "Days" }),
                                                new("properties", new BsonDocument (
                                                    new List<BsonElement> {
                                                        new("Signature", new BsonDocument (
                                                            new List<BsonElement> {
                                                                new("bsonType", "string")
                                                            }
                                                        )),
                                                        new("Date", new BsonDocument (
                                                            new List<BsonElement> {
                                                                new("bsonType", "date")
                                                            }
                                                        )),
                                                        new("Days", new BsonDocument (
                                                            new List<BsonElement> {
                                                                new("bsonType", "int")
                                                            }
                                                        ))
                                                    }
                                                ))
                                            }
                                        ))
                                    }
                                ));

            // validation schema
            BsonDocument command = new BsonDocument(
                new List<BsonElement> {
                    new("collMod", "readers"),
                    new("validator", new BsonDocument (
                        new List<BsonElement> {
                            new("$jsonSchema", new BsonDocument (
                                new List<BsonElement> {
                                    new("bsonType", "object"),
                                    new("required", new BsonArray { "PESEL", "Lastname", "City", "DateOfBirth" }),
                                    new("properties", new BsonDocument (
                                        new List<BsonElement>(){ PESEL, Lastname, City, DateOfBirth, LastLoan, LoansList }))
                                }
                            ))
                        }
                    ))
                }
            );
            
            BsonDocument? result = database.RunCommand<BsonDocument>(command);
            Console.WriteLine(result.ToString());
            
            BsonDocument? isValid = new("validate", "readers");
            BsonDocument? validResult = database.RunCommand<BsonDocument>(isValid);
            Console.WriteLine(validResult.ToString());
        }

        public static void Write()
        {
            var client = new MongoClient();
            var db = client.GetDatabase("task2");

            CreateValidatorBooks(db);
            CreateValidatorReaders(db);

            var books = db.GetCollection<Task2.Book>("books");
            try
            {
                var badUpdate = Builders<Task2.Book>.Update.Set("Copies.0.Signature", "SKKK1"); // doesnt match pattern S[0-9]*4
                var badResult = books.UpdateOne(book => book.Id.Equals(1), badUpdate);
            }
            catch (Exception ex) 
            {
                Console.WriteLine(ex.Message);
            }
            var goodUpdate = Builders<Task2.Book>.Update.Set("Copies.0.Signature", "S0009"); // S0004 -> S0009
            var goodResult = books.UpdateOne(book => book.Id.Equals(1), goodUpdate);
        }
    }
}

namespace Task4 
{
    public static class Main
    {
        static readonly string regex = "^S000[6-7]$";
        static List<Task2.Book> Query1(IMongoCollection<Task2.Book> books)
        {
            int docCount = (int)books.CountDocuments(book => true);
            List<Task2.Book> booksWhere = books.Find(book => true)
                .SortBy(book => book.Title)
                .Skip(docCount / 2)
                .Limit(2)
                .ToList();
            return booksWhere;
        }

        static List<Task2.Book> Query2(IMongoCollection<Task2.Book> books)
        {
            int docCount = (int)books.CountDocuments(book => true);
            List<Task2.Book> booksWhere = books.Find(book => 
                book.Copies.Any(copy => Regex.IsMatch(copy.Signature, regex)))
                .ToList();
            return booksWhere;
        }

        public static void Write()
        {
            var client = new MongoClient();
            var database = client.GetDatabase("task2");
            var books = database.GetCollection<Task2.Book>("books");
            
            books.DeleteMany(book => true); // delete all books
            books.InsertMany(Task2.Book.GetBooksTask4()); // insert default books

            List<Task2.Book> allBooks = books.Find(x => true).ToList();
            List<Task2.Book> books1 = Query1(books);
            List<Task2.Book> books2 = Query2(books);

            Console.WriteLine($"All {allBooks.Count} documents (books):");
            foreach (Task2.Book book in allBooks)
            {
                Console.WriteLine(book.Title);
            }

            string text2 = $"\n{books1.Count} Documents (books) matching query 1:";
            Console.WriteLine(text2);
            foreach (Task2.Book book in books1)
            {
                Console.WriteLine(book.Title);
            }

            string text3 = $"\n{books2.Count} Documents (books) matching query 2 (must have at least one copy with signature {regex}):";
            Console.WriteLine(text3);
            foreach (Task2.Book book in books2)
            {
                Console.WriteLine(book.Title);
            }
        }
    }
}