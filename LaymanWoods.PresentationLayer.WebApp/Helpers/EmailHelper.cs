﻿using AutoMapper;
using LaymanWoods.CommonLayer.Aspects;
using LaymanWoods.CommonLayer.Aspects.DTO;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Text;
using System.Web;

namespace LaymanWoods.PresentationLayer.WebApp.Helpers
{
    public class EmailHelper
    {

        public int PrepareAndSendContactEmail(ContactEnquiryDTO model)
        {

            string body = string.Empty;
            using (StreamReader reader = new StreamReader(System.Web.HttpContext.Current.Server.MapPath("~/Helpers/EmailTemplates/ContactEnquiry.html")))
            {
                body = reader.ReadToEnd();
            }
            body = body.Replace("{Name}", model.Name);
            body = body.Replace("{Date}", DateTime.Now.ToShortDateString());
            body = body.Replace("{Email}", model.Email);
            body = body.Replace("{Mobile}", model.Mobile);
            body = body.Replace("{Address}", model.Address);
            body = body.Replace("{PinCode}", model.Pincode);

            EmailServiceDTO email = new EmailServiceDTO();
            email.ToEmail = model.Email;
            email.Status = (int)AspectEnums.EmailStatus.Pending;
            email.Body = body;
            email.ToName = model.Name;
            email.Priority = 2;
            email.IsAttachment = false;
            return SendEmail(email, Convert.ToInt32(model.CompanyID));
        }

        public int PrepareAndSendEntrepreneurEmail(EntrepreneurEnquiryDTO model)
        {

            string body = string.Empty;
            using (StreamReader reader = new StreamReader(System.Web.HttpContext.Current.Server.MapPath("~/Helpers/EmailTemplates/BusinessEnquiry.html")))
            {
                body = reader.ReadToEnd();
            }
            body = body.Replace("{Name}", model.Name);
            body = body.Replace("{Date}", DateTime.Now.ToShortDateString());
            body = body.Replace("{Email}", model.Email);
            body = body.Replace("{Mobile}", model.Mobile);
            body = body.Replace("{Address}", model.Address);
            body = body.Replace("{PinCode}", model.Pincode);
            body = body.Replace("{Location}", model.Location);
            body = body.Replace("{Profession}", model.Profession);
            body = body.Replace("{Investment}", model.Investment.ToString());

            EmailServiceDTO email = new EmailServiceDTO();
            email.ToEmail = model.Email;
            email.Status = (int)AspectEnums.EmailStatus.Pending;
            email.Body = body;
            email.ToName = model.Name;
            email.Priority = 2;
            email.IsAttachment = false;
            return SendEmail(email, Convert.ToInt32(model.CompanyID));
        }


        public int SendEmail(EmailServiceDTO email, int companyId)
        {
            string fromPass = string.Empty;

            MailMessage message = new MailMessage();
            SmtpClient smtpClient = new SmtpClient();
            bool isDebugMode = ConfigurationManager.AppSettings["IsDebugMode"] == "Y" ? true : false;
            message.Subject = string.IsNullOrEmpty(email.Subject) ? ConfigurationManager.AppSettings["Subject"].ToString() : email.Subject;
            email.BccEmail = ConfigurationManager.AppSettings["BCCAddress"].ToString();
            email.CcEmail = ConfigurationManager.AppSettings["CCAddress"].ToString();

            try
            {
                if (isDebugMode)
                {
                    message.To.Add(ConfigurationManager.AppSettings["DbugToEmail"].ToString());
                    email.FromEmail = ConfigurationManager.AppSettings["DbugFromEmail"].ToString();
                    smtpClient.EnableSsl = ConfigurationManager.AppSettings["DbugIsSSL"].ToString() == "Y" ? true : false;
                    fromPass = ConfigurationManager.AppSettings["DbugFromPass"];
                    smtpClient.Host = ConfigurationManager.AppSettings["DbugSMTPHost"]; //"relay-hosting.secureserver.net";   //-- Donot change.
                    smtpClient.Port = Convert.ToInt32(ConfigurationManager.AppSettings["DbugSMTPPort"]); // 587; //--- Donot change    
                    message.Subject = "[Debug Mode ON] - " + message.Subject;
                }
                else
                {
                    smtpClient.EnableSsl = ConfigurationManager.AppSettings["IsSSL"].ToString() == "Y" ? true : false;
                    email.FromName = ConfigurationManager.AppSettings["FromName"].ToString();
                    email.FromEmail = ConfigurationManager.AppSettings["FromEmail"].ToString();
                    fromPass = ConfigurationManager.AppSettings["Password"].ToString();
                    smtpClient.Port = Convert.ToInt32(ConfigurationManager.AppSettings["SMTPPort"]);
                    smtpClient.Host = ConfigurationManager.AppSettings["SMTPHost"].ToString();
                    message.To.Add(email.ToEmail);
                }
                //log.Info("Sending Email to : " + message.To + " from account " + fromAddress + " having host and port: " + smtpClient.Host + " & " + smtpClient.Port );
                smtpClient.Credentials = new NetworkCredential(email.FromEmail, fromPass);
                message.BodyEncoding = Encoding.UTF8;
                message.From = new MailAddress(email.FromEmail, email.FromName);
                message.IsBodyHtml = true;
                message.Body = email.Body;
                message.Bcc.Add(email.BccEmail);
                message.CC.Add(email.CcEmail);
                smtpClient.Send(message);
                message.Dispose();
                return (int)AspectEnums.EmailStatus.Sent;

            }
            catch (Exception ex)
            {
                //log.Error("Error Sending Email " + ex.InnerException);
                return (int)AspectEnums.EmailStatus.Failed;
            }
            finally
            {
                message.Dispose();
                smtpClient.Dispose();
            }
        }


    }


}