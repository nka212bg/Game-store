package model;

import java.io.*;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Scanner;
import java.util.logging.Level;
import java.util.logging.Logger;

public class LogWriter {

    Date date = new Date();
    SimpleDateFormat ft = new SimpleDateFormat("dd.MM.yyyy '-' hh:mm:ss zzz");

    String logPath = "/opt/tomcat/webapps/relocatecity/userLogs";

    public void _logWriter(String userid, String action) {

        if (!new File(logPath).exists()) {
            try {
                Files.createDirectories(Paths.get(logPath));
            } catch (IOException ex) {
                Logger.getLogger(LogWriter.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        try (FileWriter fw = new FileWriter(logPath + userid, true);
                BufferedWriter bw = new BufferedWriter(fw);
                PrintWriter out = new PrintWriter(bw)) {
            out.println(">> " + ft.format(date) + " --- " + action);
            out.println();

        } catch (IOException e) {
            System.out.println(e);
        }

    }

    public String _logReader(String userid) {

        try {

            Scanner x = new Scanner(new File(logPath + userid));

            String b = "";

            while (x.hasNext()) {

                b += x.nextLine() + "<br>";
                System.out.println("");
            }
            return b;

        } catch (IOException e) {
            System.out.println(e);
        }
        return "Select an user";

    }

}
