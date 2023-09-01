<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <title>Login Page</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            $("#loginForm").submit(function(event) {
                event.preventDefault();
                var userId = $("#userId").val();
                var password = $("#password").val();

                // Validate the userId and password (hardcoded values for simplicity)
                if (userId === "user123" && password === "password123") {
                    window.location.href = "welcome.jsp?userId=" + userId;
                } else {
                    alert("Invalid credentials");
                }
            });
        });
    </script>
</head>
<body>
    <form id="loginForm">
        User ID: <input type="text" id="userId" required><br>
        Password: <input type="password" id="password" required><br>
        <button type="submit">Login</button>
    </form>
</body>
</html>
