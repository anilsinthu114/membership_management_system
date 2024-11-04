<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="test.Membership" %>
<%@page import ="test.MembershipDAO" %>

<html>
<head>
    <title>View Memberships</title>
    <!-- Bootstrap CSS link -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <style>
        /* Add your custom CSS styles here */
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        h1 {
            color: #007bff;
            margin-top: 20px;
            margin-bottom: 30px;
        }
        .navbar {
            background-color: #343a40; /* Dark gray background */
        }
        .navbar-brand {
            color: #ffffff; /* White text color */
        }
        .navbar-brand img {
            width: 30px; /* Adjust the width of the user avatar */
            height: auto;
            margin-right: 10px;
            border-radius: 50%; /* Make the avatar rounded */
        }
        .navbar-nav .nav-link {
            color: #ffffff; /* White text color */
            margin-right: 10px; /* Adjust spacing between menu items */
        }
        .navbar-nav .nav-link:hover {
            color: #f8f9fa; /* Light text color on hover */
        }
        .container {
            margin-top: 20px; /* Adjust spacing from the top */
        }
        /* Membership table styles */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        th, td {
            border: 1px solid #dee2e6;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #007bff; /* Blue header background */
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2; /* Alternate row background color */
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="#">
                <img src="images/user-avatar.jpg" alt="User Avatar">
                <%= session.getAttribute("username") %>
            </a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="addMembershipForm.html">Add Membership</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/Membership_mgmt/ViewMembershipServlet">View Memberships</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="updateMembershipForm.html">Update Membership</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="deleteMembership.jsp">Delete Membership</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container">
        <h1>Membership List</h1>
        <!-- Membership Table -->
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger" role="alert">
                ${errorMessage}
            </div>
        </c:if>
        <table class="table">
            <thead class="thead-dark">
                <tr>
                    <th>Membership ID</th>
                    <th>Customer ID</th>
                    <th>Start Date</th>
                    <th>End Date</th>
                    <th>Type</th>
                </tr>
            </thead>
            <tbody>
    <c:forEach var="member" items="${membership}">
        <tr>
            <td>${member.membershipId}</td>
            <td>${member.customerId}</td>
            <td>${member.startDate}</td>
            <td>${member.endDate}</td>
            <td>${member.type}</td>
            <td>
                <!-- Edit button -->
               <form action="UpdateMembershipServlet" method="post" style="display: inline;">
  <input type="hidden" name="membershipId" value="${member.membershipId}">
  <button type="submit" class="btn btn-primary btn-sm">Edit</button>
</form>
               <form action="DeleteMembershipServlet" method="post" style="display: inline;">
                    <input type="hidden" name="membershipId" value="${member.membershipId}">
                    <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this membership?')">Delete</button>
                </form>
            </td>
        </tr>
    </c:forEach>
</tbody>
</table>
        <c:if test="${empty membership and empty errorMessage}">
            <p>No membership records found.</p>
        </c:if>
    </div>

    <!-- Bootstrap JS script -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
