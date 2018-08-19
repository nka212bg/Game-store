package controller;

import java.io.IOException;
import java.sql.ResultSet;
import javax.sql.DataSource;
import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Games;

public class controller extends HttpServlet {

    @Resource(name = "jdbc/gameapp")
    private DataSource dataSource;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ------- Router -------------------------------  
        //IF PARAMETER IS EMPTY - REDIRECTS TO THE HOME PAGE
        if (request.getParameterMap().containsKey("") || request.getParameterMap().containsKey(null)) {
            home(request, response);
        }

        //IF THE PARAMETER OF THE REQUST IS page
        if (request.getParameterMap().containsKey("home")) {
            home(request, response);
        }

        //IF THE PARAMETER OF THE REQUST IS gameid
        if (request.getParameterMap().containsKey("gameid")) {
            gameid(request, response);
        }

        //IF THE PARAMETER OF THE REQUST IS special
        if (request.getParameterMap().containsKey("special")) {
            special(request, response);
        }

        //IF THE PARAMETER OF THE REQUST IS search
        if (request.getParameterMap().containsKey("search")) {
            search(request, response);
        }

        //IF THE PARAMETER OF THE REQUST IS login
        if (request.getParameterMap().containsKey("login")) {
            login(request, response);
        }

        //IF THE PARAMETER OF THE REQUST IS register
        if (request.getParameterMap().containsKey("register")) {
            register(request, response);
        }

        //IF THE PARAMETER OF THE REQUST IS uploadGames
        if (request.getParameterMap().containsKey("uploadGames")) {
            //uploadGames(request, response);
        }

        //IF THE PARAMETER OF THE REQUST IS passwordReset
        if (request.getParameterMap().containsKey("passwordReset")) {
            passwordReset(request, response);
        }

        //IF THE PARAMETER OF THE REQUST IS favorites
        if (request.getParameterMap().containsKey("favorites")) {
            favorites(request, response);
        }

        //IF THE PARAMETER OF THE REQUST IS cart
        if (request.getParameterMap().containsKey("cart")) {
            cart(request, response);
        }

    }

    private void home(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }

    private void login(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    private void register(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }

    private void search(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String gamename = request.getParameter("gamename");
        String console = request.getParameter("console");
        String num_players = request.getParameter("num_players");
        String genre = request.getParameter("genre");
        String publisher = request.getParameter("publisher");
        String priceFrom = request.getParameter("priceFrom");
        String priceTo = request.getParameter("priceTo");

        ResultSet rs = new Games().getSelectedGames(gamename, console, num_players, genre, publisher, priceFrom, priceTo);
        request.setAttribute("searchRequest", rs);
        request.getRequestDispatcher("/resultPage.jsp").forward(request, response);

    }

    private void gameid(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int gameid = Integer.parseInt(request.getParameter("gameid"));

        /*
        The result set is the return object of the getGameId function of the GameId class
         */
        ResultSet rs = new Games().getGameId(gameid);

        /*
        binds the object rsGameid with the name "searchRequest"
         */
        request.setAttribute("searchRequest", rs);

        /*
        the Request Dispatcher redirects to /resultPage.jsp and forwards the request and the result
         */
        request.getRequestDispatcher("/resultPage.jsp").forward(request, response);
    }

    private void special(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        /*
        The result set is the return object of the getSpecial function of the Special class
         */

        ResultSet rs = new Games().getSpecial();

        /*
        binds the object rsGameid with the name "searchRequest"
         */
        request.setAttribute("searchRequest", rs);

        /*
        the Request Dispatcher redirects to /resultPage.jsp and forwards the request and the result
         */
        request.getRequestDispatcher("/resultPage.jsp").forward(request, response);
    }

    private void passwordReset(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/passwordReset.jsp").forward(request, response);
    }

    private void favorites(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userid = (String) request.getSession().getAttribute("userid");

        ResultSet rs = new Games().getFavorites(userid);
        request.setAttribute("searchRequest", rs);
        request.getRequestDispatcher("/resultPage.jsp").forward(request, response);

    }

    private void cart(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userid = (String) request.getSession().getAttribute("userid");

        ResultSet rs = new Games().getCart(userid);
        request.setAttribute("searchRequest", rs);
        request.getRequestDispatcher("/resultPage.jsp").forward(request, response);

    }

}
