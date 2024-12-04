<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../include/oracleCon.jsp" %>

<%
String SessionUserid = (String)session.getAttribute("sessionId");
if( SessionUserid == null ) {
%>
	<script>
	location = "/member/loginWrite.jsp";
	</script>
<%
	return;
}

String sessionCntSql = "select count(*) from member where id='"+SessionUserid+"'";
ResultSet sessionCntRs = stmt.executeQuery(sessionCntSql);
sessionCntRs.next();
if( sessionCntRs.getInt(1) == 0 ) {
	session.removeAttribute("sessionId");
%>
	<script>
	alert("세션 아이디 검증 실패!!");
	location = "/member/loginWrite.jsp";
	</script>
<%
	return;	
}
%>






