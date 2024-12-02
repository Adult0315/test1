<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>공지사항</title>
</head>
<body>
    <h2>공지사항</h2>

    <form method="post" action="boardList.jsp">
        <input type="text" name="search" placeholder="검색어 입력">
        <button type="submit">검색</button>
    </form>

    <table border="1">
        <thead>
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>작성일</th>
                <th>상태</th>
                <th>삭제</th>
            </tr>
        </thead>
        <tbody>
            <%
                String url  = "jdbc:oracle:thin:@//localhost:1522/orcl";
                String username = "c##java";
                String userpass = "1234";
                
                Class.forName("oracle.jdbc.OracleDriver");
                Connection con = DriverManager.getConnection(url, username, userpass);
                Statement stmt = con.createStatement();

                String search = request.getParameter("search");
                String query = "SELECT g_id, title, sdate, status FROM g WHERE status = '공개'";

                if (search != null && !search.isEmpty()) {
                    query += " AND title LIKE '%" + search + "%'";
                }

                ResultSet rs = stmt.executeQuery(query);

                while (rs.next()) {
                    int g_id = rs.getInt("g_id");
                    String title = rs.getString("title");
                    Date sdate = rs.getDate("sdate");
                    String status = rs.getString("status");
            %>
            <tr>
                <td><%= g_id %></td>
                <td><a href="boardDetail.jsp?g_id=<%= g_id %>"><%= title %></a></td>
                <td><%= sdate %></td>
                <td><%= status %></td>
                <td><a href="boardDelete.jsp?g_id=<%= g_id %>" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a></td>
            </tr>
            <% 
                }
                rs.close();
                stmt.close();
                con.close();
            %>
        </tbody>
    </table>

    <button onclick="location.href='boardWrite.jsp'">글쓰기</button>
</body>
</html>
