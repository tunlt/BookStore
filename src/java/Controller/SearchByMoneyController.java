/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DAO.BookDAO;
import DTO.BookDTO;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Tu
 */
@WebServlet(name = "SearchByMoneyController", urlPatterns = {"/SearchByMoneyController"})
public class SearchByMoneyController extends HttpServlet {

    private static final String ERROR = "Home.jsp";
    private static final String SUCCESS = "Home.jsp";

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        /**/
        String url = ERROR;
        try {
            String num1 = request.getParameter("number1");           
            String num2 = request.getParameter("number2");

            if(Float.parseFloat(num1) >= Float.parseFloat(num2)){
                request.setAttribute("INVALIDMONEY","Please the first money not more than the second !");
            }else if(Float.parseFloat(num1) <0 || Float.parseFloat(num2) < 0){
                request.setAttribute("INVALIDMONEY","money not negative");
            }else if(num1 == null || num2 == null){
                request.setAttribute("INVALIDMONEY","1 in 2 amounts cannot be empty! ");
            }
            else{
            BookDAO dao = new BookDAO();
            ArrayList<BookDTO> list = dao.getListBookByPrice(num1, num2);
            if (list != null) {
                HttpSession session = request.getSession();
                session.setAttribute("listb", list);
                url = SUCCESS;
            }
            }
        } catch (Exception e) {
            System.out.println(e.toString());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
