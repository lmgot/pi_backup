<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%
    session = request.getSession(false);
    if (session != null) {
        session.invalidate();
        out.println("<script>alert('Deslogado!');</script>");
    }
    response.sendRedirect("../index.html");
%>