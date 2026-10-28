<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%!
    // Declaración: método de la clase servlet generada (se crea una sola vez)
    private String esc(String s) {
        if (s == null) return "";
        return s.replace("&", "&amp;").replace("<", "&lt;")
                .replace(">", "&gt;").replace("\"", "&quot;").replace("'", "&#39;");
    }
%>
<%
    request.setCharacterEncoding("UTF-8");

    // 1) Solo aceptar POST; si no, 405
    if (!"POST".equals(request.getMethod())) {
        response.setHeader("Allow", "POST");
        response.sendError(405, "Método no permitido");
        return;
    }

    // 2) Leer parámetros con request.getParameter()
    String nombre = request.getParameter("nombre");
    String correo = request.getParameter("correo");
    String curso  = request.getParameter("curso");

    java.util.List<String> cursos = java.util.List.of(
        "Desarrollo Web", "Base de Datos", "Inteligencia de Negocios");

    boolean valido = nombre != null && !nombre.isBlank() && nombre.length() <= 60
        && correo != null && correo.matches("^[^@\\s]+@[^@\\s]+\\.[^@\\s]+$")
        && cursos.contains(curso);

    // 3) Si hay errores: 302 Redirect
    if (!valido) {
        response.sendRedirect("index.jsp?error=1");
        return;
    }

    // 4) Sesión con session.setAttribute()
    Integer visitas = (Integer) session.getAttribute("visitas");
    visitas = (visitas == null) ? 1 : visitas + 1;
    session.setAttribute("visitas", visitas);

    // Pasar datos ya escapados a la vista (EL)
    request.setAttribute("nombre", esc(nombre));
    request.setAttribute("correo", esc(correo));
    request.setAttribute("curso", esc(curso));
%>
<!DOCTYPE html>
<html lang="es">
<head><meta charset="UTF-8"><title>Resultado JSP</title></head>
<body>
  <h1>Datos recibidos en JSP ✔</h1>
  <p>Nombre: ${nombre}</p>