/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DAO.BookDAO;
import DTO.BookDTO;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
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
@WebServlet(name = "EditController", urlPatterns = {"/EditController"})
public class EditController extends HttpServlet {

    private static final String ERROR = "Edit.jsp";
    private static final String SUCCESS = "ManagerBook.jsp";

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
        Float price = Float.parseFloat(request.getParameter("price"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        boolean tmp = Boolean.parseBoolean(request.getParameter("status"));
        String url = SUCCESS;
        try {
            HttpSession session = request.getSession();

            if (price < 0 || quantity < 0) {
                request.setAttribute("OK", "Update fail! Price or Quantity not negative and > 0");

            } else {
                if (quantity == 0) {
                    tmp = false;
                }
                if (quantity > 0){
                    tmp = true;
                }
                BookDTO b = new BookDTO(Integer.parseInt(request.getParameter("id")),// khợi tạo biến b vàn nhận request từ phía client
                        request.getParameter("name"),
                        request.getParameter("image"),
                        price,
                        quantity,
                        request.getParameter("author"),
                        tmp,
                        Integer.parseInt(request.getParameter("category")));
                BookDAO dao = new BookDAO();
                if (dao.updateBook(b) > 0) {
                    session.removeAttribute("detailB");
                    request.setAttribute("OK", "Update Success!");

                    url = SUCCESS;
                }
            }
        } catch (Exception e) {
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
