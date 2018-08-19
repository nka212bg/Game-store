<%@page import="model.LogWriter"%>
<%

    /*
     WRITE IN TO THE LOG
     */
    String userid = (String) session.getAttribute("userid");
    LogWriter logWriter = new LogWriter();
    String action = "LogOut";
    logWriter._logWriter(userid, action);

    /*
    CLOSES THE SESSION
     */
    session.invalidate();

    /*
    SENDS BACK TO HOME
     */
    response.sendRedirect("../controller?search");
    return;


%>