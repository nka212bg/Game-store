package model;

import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;

public class EmailSend {

    String host = "smtp.gmail.com";
    String user = "xxxxxxxxx";
    String pass = "xxxxxxxxx";
    String from = "xxxxxxxxx";

    public void _keySend(String email, String key) {

        try {

            String to = email;
            String subject = "Game store / Reset password key";
            String messageText = "<div style=\"background-color: #f2f2f2; padding: 50px;margin: 30px; max-width: 500px; border: solid 1px #e6e6e6 ; \n"
                    + "         border-radius: 5px; background: url(http://192.222.244.73:8080/game_app_assigment/img/cv4.png) no-repeat center center; \n"
                    + "         -webkit-background-size: cover;\n"
                    + "         -moz-background-size: cover;\n"
                    + "         -o-background-size: cover;\n"
                    + "         background-size: cover;\">\n"
                    + "        <h2><b>gtastore / Reset password key</b></h2><br>\n"
                    + "        <p>This is your new security key from Nikolay Atanasov Game store website</p><br>\n"
                    + "        " + key + "\n"
                    + "        <br><br><h2><b>WARNING! this key is valid only 5 minutes</b></h2>\n"
                    + "    </div>";

            boolean sessionDebug = false;
            Properties props = System.getProperties();
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", host);
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.port", "465");
            props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
            props.put("mail.smtp.socketFactory.port", "465");
            props.put("mail.smtp.socketFactory.fallback", "false");

            java.security.Security.addProvider(new com.sun.net.ssl.internal.ssl.Provider());
            Session mailSession = Session.getDefaultInstance(props, null);
            mailSession.setDebug(sessionDebug);
            Message msg = new MimeMessage(mailSession);
            msg.setFrom(new InternetAddress(from));
            InternetAddress[] address = {new InternetAddress(to)};
            msg.setRecipients(Message.RecipientType.TO, address);
            msg.setSubject(subject);
            msg.setSentDate(new Date());
            msg.setContent(messageText, "text/html");

            Transport transport = mailSession.getTransport("smtp");
            transport.connect(host, user, pass);
            transport.sendMessage(msg, msg.getAllRecipients());
            transport.close();
            System.out.println("message send successfully");

        } catch (Exception ex) {
            System.out.println(ex);
        }

    }

    public void _checkoutSend(String email, String tottalPrice, String firstname, String lastname, String userid, String orderid, String gameList) {

        try {

            String to = email;
            String subject = "Test buying from Game store!";
            String messageText = "<div style=\"background-color: #f2f2f2; padding: 50px;margin: 30px; max-width: 500px; border: solid 1px #e6e6e6 ; \n"
                    + "         border-radius: 5px; background: url(http://192.222.244.73:8080/game_app_assigment/img/cv4.png) no-repeat center center; \n"
                    + "         -webkit-background-size: cover;\n"
                    + "         -moz-background-size: cover;\n"
                    + "         -o-background-size: cover;\n"
                    + "         background-size: cover;\">\n"
                    + "        <h2><b>Hello " + firstname + " " + lastname + "</b></h2><br>\n"
                    + "        <p>Thank you for buying from Game store website</p><br><br>\n"
                    + "        <p>Game list: <br>" + gameList + "</p>\n"
                    + "        <h2><b>Order ID: " + orderid + "<br>Total price $" + tottalPrice + "</b></h2>\n"
                    + "    </div>";

            boolean sessionDebug = false;
            Properties props = System.getProperties();
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", host);
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.port", "465");
            props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
            props.put("mail.smtp.socketFactory.port", "465");
            props.put("mail.smtp.socketFactory.fallback", "false");

            java.security.Security.addProvider(new com.sun.net.ssl.internal.ssl.Provider());
            Session mailSession = Session.getDefaultInstance(props, null);
            mailSession.setDebug(sessionDebug);
            Message msg = new MimeMessage(mailSession);
            msg.setFrom(new InternetAddress(from));
            InternetAddress[] address = {new InternetAddress(to)};
            msg.setRecipients(Message.RecipientType.TO, address);
            msg.setSubject(subject);
            msg.setSentDate(new Date());
            msg.setContent(messageText, "text/html");

            Transport transport = mailSession.getTransport("smtp");
            transport.connect(host, user, pass);
            transport.sendMessage(msg, msg.getAllRecipients());
            transport.close();
            System.out.println("message send successfully");

        } catch (Exception ex) {
            System.out.println(ex);
        }

    }

}
