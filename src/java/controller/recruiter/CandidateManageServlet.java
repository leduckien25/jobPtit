/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.recruiter;

import dao.CandidateDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import model.ApplicationDetail;

@WebServlet("/recruiter/candidates")
public class CandidateManageServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int jobId = Integer.parseInt(request.getParameter("jobId"));
            CandidateDAO dao = new CandidateDAO();
            
            List<ApplicationDetail> list = dao.getApplicationsByJobId(jobId);
            System.out.println("Size của danh sách ứng viên: " + list.size()); // Kiểm tra log ở Console

            String jobTitle = dao.getJobTitleById(jobId);

            request.setAttribute("candidateList", list);
            request.setAttribute("jobTitle", jobTitle);
            request.setAttribute("jobId", jobId);

            request.getRequestDispatcher("/views/recruiter/job/candidateList.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace(); // In lỗi ra bảng Console (Output) của NetBeans
            throw new ServletException(e); // Quăng lỗi thẳng lên web để biết sai ở đâu
        }
    }
}
