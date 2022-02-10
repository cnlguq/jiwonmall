package com.jiwonmall.jiwon.mail;

import javax.mail.*;
import javax.mail.internet.*;
import java.util.*;

public class Mail {
	final String senderEmailID = "kkomaya009@gmail.com";
	final String senderPassword = "qkqh77dl2@";
	final String emailSMTPserver = "smtp.gmail.com";
	final String emailServerPort = "587";
	String receiverEmailID = "";
	static String emailSubject = "Test Mail";
	static String emailBody = ":)";

	public Mail(String receiverEmailID, String emailSubject, String emailBody) {
		this.receiverEmailID = receiverEmailID;
		this.emailSubject = emailSubject;
		this.emailBody = emailBody;
		Properties props = new Properties();
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", emailSMTPserver);
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.port", 587);
		props.put("mail.smtp.ssl.trust", "smtp.gmail.com");
		props.put("mail.smtp.user", senderEmailID);
		props.put("mail.smtp.socketFactory.fallback", "false");
		props.put("mail.smtp.ssl.protocols", "TLSv1.2");
//		props.put("mail.smtp.socketFactory.port", 587);
//		props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		SecurityManager security = System.getSecurityManager();
		try {
			Authenticator auth = new SMTPAuthenticator();
			Session session = Session.getInstance(props, auth);
			MimeMessage msg = new MimeMessage(session);
			msg.setText(emailBody);
			msg.setSubject(emailSubject);
			msg.setFrom(new InternetAddress(senderEmailID));
			msg.addRecipient(Message.RecipientType.TO, new InternetAddress(receiverEmailID));
			Transport.send(msg);
			System.out.println("Message send Successfully:)");
		} catch (Exception mex) {
			mex.printStackTrace();
		}
	}

	public class SMTPAuthenticator extends javax.mail.Authenticator {
		public PasswordAuthentication getPasswordAuthentication() {
			return new PasswordAuthentication(senderEmailID, senderPassword);
		}
	}

//	public static void main(String[] args) {
//		Mail mailSender;
//		mailSender = new Mail("cnlguq@naver.com", "jiwonmall 가입을 환영합니다 ", "http://192.168.4.203:9090/jm/member/useyn.jiwonmall?email=cnlguq@naver.com");
//	}
}
