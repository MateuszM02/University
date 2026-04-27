using System.Net.Mail;

namespace oop5
{
    class SmtpFacade
    {
        public static void Send(string From, string To,
            string Subject, string Body,
            Stream Attachment, string AttachmentMimeType)
        {
            SmtpClient client = new();
            MailMessage message = new(From, To, Subject, Body);
            Attachment attachment = new(Attachment, AttachmentMimeType);
            message.Attachments.Add(attachment);
            client.Send(message);
        }
    }
}
