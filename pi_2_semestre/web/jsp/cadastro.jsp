<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="JavaBeans.Usuario" %>
<%
    Usuario user = new Usuario();
    if (user.statusSQL != null) 
        out.println(user.statusSQL);

    user.nome = request.getParameter("nome");
    user.idade = request.getParameter("idade");
    user.email = request.getParameter("email");
    user.senha = request.getParameter("senha");

    user.incluir();

    if (user.statusSQL != null) {
        out.println("<script>alert('Algo deu errado, tente novamente!')</script>");
    } else {
        out.println("<script>alert('Usuario criado com sucesso!')</script>");
        response.sendRedirect(request.getContextPath() + "/indexlogado.html");
    }
%>
