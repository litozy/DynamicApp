<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Welcome Page</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            var userId = "<%= request.getParameter("userId") %>";
            $("#userId").text(userId);

            // Daftar objek mahasiswa
            var studentData = [
                { department: "Dep 1", studentID: "V001", mark: 70, studentName: "John Doe" },
                { department: "Dep 1", studentID: "V002", mark: 35, studentName: "Jane Smith" },
                { department: "Dep 2", studentID: "V003", mark: 85, studentName: "Bob Johnson" },
                // Tambahkan lebih banyak data mahasiswa sesuai kebutuhan
            ];

            // Function untuk membuat baris tabel dari objek mahasiswa
            function createTableRow(student) {
                var studentId = '<td><a href="javascript:void(0);" class="studentIdLink" data-student-id="' + student.studentID + '">' + student.studentID + '</a></td>';
                var department = '<td>' + student.department + '</td>';
                var mark = '<td>' + student.mark + '</td>';
                var studentName = '<td>' + student.studentName + '</td>';
                var passPercentage = '<td class="passPercentage"></td>';

                var tableRow = '<tr>' + department + studentId + mark + passPercentage + '</tr>';

                return tableRow;
            }

            // Populate the table
            var tableBody = $("#studentTableBody");
            for (var i = 0; i < studentData.length; i++) {
                var student = studentData[i];
                var row = createTableRow(student);
                tableBody.append(row);
            }

            // Calculate and populate Pass % for each department
            var departments = {};

            // Iterate through the studentData to calculate pass percentages
            for (var i = 0; i < studentData.length; i++) {
                var student = studentData[i];
                if (!(student.department in departments)) {
                    departments[student.department] = { pass: 0, total: 0 };
                }
                if (student.mark >= 40) {
                    departments[student.department].pass++;
                }
                departments[student.department].total++;
            }

            // Populate the Pass % column in the table
            $(".passPercentage").each(function() {
                var department = $(this).prev().prev().prev().text(); // Get department from previous column
                var passPercentage = (departments[department].pass / departments[department].total) * 100;
                console.log(department);
                console.log(passPercentage);
                $(this).text(passPercentage.toFixed(2) + "%");
            });

            // Show student name popup when clicking student ID
            $(".studentIdLink").click(function() {
                var studentIdToFind = $(this).data("student-id");
                var studentName = getStudentName(studentIdToFind, studentData);
                if (studentName !== "Not found") {
                    alert("Nama Mahasiswa: " + studentName);
                } else {
                    alert("Mahasiswa tidak ditemukan.");
                }
            });

            function getStudentName(studentID, studentData) {
                for (var i = 0; i < studentData.length; i++) {
                    if (studentData[i].studentID === studentID) {
                        return studentData[i].studentName;
                    }
                }
                return "Not found";
            }
        });
    </script>
</head>
<body>
    <h2>Welcome <span id="userId"></span></h2>
    <table border="1">
        <thead>
            <tr>
                <th>Department</th>
                <th>Student ID</th>
                <th>Marks</th>
                <th>Pass %</th>
            </tr>
        </thead>
        <!-- Baris-baris tabel akan diisi di sini oleh JavaScript -->
        <tbody id="studentTableBody">
        </tbody>
    </table>
</body>
</html>
