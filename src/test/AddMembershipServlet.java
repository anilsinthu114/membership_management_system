
package test;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

@WebServlet("/AddMembershipServlet")
public class AddMembershipServlet extends HttpServlet {
    @Resource(name = "jdbc/membershipdb")
    private DataSource dataSource;
    private static final long serialVersionUID = 1L;
    private static final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    private static final String INSERT_MEMBERSHIP_QUERY = "INSERT INTO Membership (customer_id, start_date, end_date, type) VALUES (?, ?, ?, ?)";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        out.print("Database Connected"); // Moved print statement outside the try block

        Connection connection = null;
        PreparedStatement insertStatement = null;

        try {
            connection = dataSource.getConnection();

            // Get form data and parse dates (with error handling)
            String customerIdStr = request.getParameter("customerId");
            String startDateStr = request.getParameter("startDate");
            String endDateStr = request.getParameter("endDate");
            String type = request.getParameter("type");

            if (customerIdStr == null || customerIdStr.isEmpty() || startDateStr == null || startDateStr.isEmpty()
                    || endDateStr == null || endDateStr.isEmpty() || type == null || type.isEmpty()) {
                out.println("<p>Error: One or more fields are empty.</p>");
                return;
            }

            int customerId = Integer.parseInt(customerIdStr);
            Date startDate = dateFormat.parse(startDateStr);
            Date endDate = dateFormat.parse(endDateStr);

            insertStatement = connection.prepareStatement(INSERT_MEMBERSHIP_QUERY);
            insertStatement.setInt(1, customerId);
            insertStatement.setDate(2, new java.sql.Date(startDate.getTime()));
            insertStatement.setDate(3, new java.sql.Date(endDate.getTime()));
            insertStatement.setString(4, type);

            int rowsInserted = insertStatement.executeUpdate();
            if (rowsInserted > 0) {
                out.println("<p>A new membership record was inserted successfully!</p>");
                // JavaScript code for delayed redirection after 3 seconds
                out.println("<script>");
                out.println("setTimeout(function() { window.location.href = 'addMembership.jsp'; }, 3000);");
                out.println("</script>");
            } else {
                out.println("<p>Error: Unable to insert membership record.</p>");
            }

        } catch (SQLException | ParseException e) {
            e.printStackTrace(out);
            out.println("<p>Error: Database operation failed.</p>");
        } finally {
            try {
                if (insertStatement != null) {
                    insertStatement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace(out);
            }
            out.close();
        }
    }
}
