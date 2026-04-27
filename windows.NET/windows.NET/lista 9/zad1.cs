using System.IO.Compression;
using System.Security.Cryptography;
using System.Text;

namespace net9
{
    public class Zad1
    {
        public static void Main()
        {
            string originalFile = "textfile.txt";
            string encryptedFile = "encrypted.gz";
            string decryptedFile = "decrypted.txt";

            // Klucz i wektor inicjalizujący dla algorytmu AES
            byte[] key = Encoding.UTF8.GetBytes("32-byte-size-key");
            byte[] iv = Encoding.UTF8.GetBytes("16-byte-iv");

            EncryptAndCompressFile(originalFile, encryptedFile, key, iv);
            DecompressAndDecryptFile(encryptedFile, decryptedFile, key, iv);
        }

        private static void EncryptAndCompressFile(string inputFile, string outputFile, byte[] key, byte[] iv)
        {
            using FileStream fileStream = new(inputFile, FileMode.Open, FileAccess.Read);
            using StreamReader reader = new(fileStream);
            using FileStream encryptedFileStream = new(outputFile, FileMode.Create, FileAccess.Write);
            using GZipStream compressionStream = new(encryptedFileStream, CompressionMode.Compress);
            using Aes aesAlg = Aes.Create();
            aesAlg.Key = key;
            aesAlg.IV = iv;
            ICryptoTransform encryptor = aesAlg.CreateEncryptor(aesAlg.Key, aesAlg.IV);
            using CryptoStream cryptoStream = new(compressionStream, encryptor, CryptoStreamMode.Write);
            using StreamWriter writer = new(cryptoStream);
            writer.Write(reader.ReadToEnd());
        }

        private static void DecompressAndDecryptFile(string inputFile, string outputFile, byte[] key, byte[] iv)
        {
            using FileStream encryptedFileStream = new(inputFile, FileMode.Open, FileAccess.Read);
            using GZipStream decompressionStream = new(encryptedFileStream, CompressionMode.Decompress);
            using Aes aesAlg = Aes.Create();
            aesAlg.Key = key;
            aesAlg.IV = iv;
            ICryptoTransform decryptor = aesAlg.CreateDecryptor(aesAlg.Key, aesAlg.IV);
            using CryptoStream cryptoStream = new(decompressionStream, decryptor, CryptoStreamMode.Read);
            using StreamReader reader = new(cryptoStream);
            using FileStream decryptedFileStream = new(outputFile, FileMode.Create, FileAccess.Write);
            using StreamWriter writer = new(decryptedFileStream);
            writer.Write(reader.ReadToEnd());
        }
    }
}