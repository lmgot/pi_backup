<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="JavaBeans.Usuario" %>
<%
    Usuario user = new Usuario();
    if (user.statusSQL != null) 
        out.println(user.statusSQL);
    
    user.pkuser = (int) Math.random()*1000 + 1;
    user.nome = request.getParameter("nome");
    user.idade = request.getParameter("idade");
    user.email = request.getParameter("email");
    user.senha = request.getParameter("senha");
    user.incluir();

    if (user.statusSQL != null) {
        out.println("<script>alert('Algo deu errado, tente novamente!'); window.location.href='../cadastrar.html';</script>");
    } else {
        session.setAttribute("nome", user.nome);
        session.setAttribute("email", user.email);
        session.setAttribute("pkuser", user.pkuser);
        out.println("<script>alert('Usuario criado com sucesso!'); window.location.href='../indexlogado.html';</script>");
    }
%>
