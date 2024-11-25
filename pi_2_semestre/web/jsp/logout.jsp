<%@ page import="javax.servlet.http.HttpSession" %>

<%
    session = request.getSession(false);
    if (session != null) {
        session.invalidate();
    }
    response.sendRedirect(request.getContextPath() + "index.html");
%>