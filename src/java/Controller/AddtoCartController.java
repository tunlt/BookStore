/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;


import DAO.BookDAO;
import DTO.BookDTO;
import DTO.DetailDTO;
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
@WebServlet(name = "AddtoCartController", urlPatterns = {"/AddtoCartController"})
public class AddtoCartController extends HttpServlet {

    private static final String ERROR = "ERROR.jsp";
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
        String url = ERROR;
        BookDAO dao = new BookDAO();// tạo dao tham chiếu Book dao
        int Bid = Integer.parseInt(request.getParameter("BID"));// tạo đối tượng Bookid khi nhận parameter tại client
        int quantity = 1;// khởi tạo số lương
        DetailDTO detailDTO = new DetailDTO();// khợi tạo detalil để tham chiếu DetailDTO
        ArrayList<DetailDTO> list = null; // tạo list chứa cacs DetailDTO
        boolean flag = true;//acction T/F
        try {
            BookDTO bookDTO = dao.getBookByBookID(Bid);//nhận book ID 
            detailDTO = new DetailDTO(0, bookDTO.getPrice(), quantity, 0, bookDTO);

            HttpSession session = request.getSession();//ghi váo sesion
            list = (ArrayList<DetailDTO>) session.getAttribute("CART");// list này bao gồ arraylist detaildto nằm trong sesion
            if (list != null) {//nếu đã có cart khác null
                for (int i = 0; i < list.size(); i++) {
                    if (list.get(i).getBook().getBookID() == detailDTO.getBook().getBookID()) {// khi nhận request bookID mới giống book ID cũ thì số lượng
                                                                                               // quantity sẽ tăng lên 1 khi nhận 1 request book id giống nhau.
                            
                        int CurQuantity = dao.getQuantityOfBook(Bid);//giá trị quantity
                        if (list.get(i).getQuantity() + 1 <= CurQuantity) {     // so sosnh số lượng trong quantity
                            detailDTO.setQuantity(list.get(i).getQuantity()+1);// số lương trong cart tăng lên 1
                            detailDTO.setPrice(detailDTO.getQuantity() * detailDTO.getBook().getPrice());// nhấn số lượng với giá niêm yết
                            list.set(i, detailDTO);//lưu
                        } else {
                            request.setAttribute("OUT", "Sorry! Out Of Quantity");//còn ko còn sản phẩm thì nó in ra câu thông báo
                        }
                        flag = false;
                    }
                }
            } else if (list == null) {// list ko có giá trị
                list = new ArrayList<>();
            } 
            if (flag) {
                list.add(detailDTO);
            }
            session.setAttribute("CART", list); //lưu vô sesion
            url = SUCCESS;

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
