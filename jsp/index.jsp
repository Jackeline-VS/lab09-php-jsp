<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Lab09 - Formulario JSP</title>
</head>
<body>
  <h1>Registro de estudiante (JSP)</h1>

  <%-- EL: muestra aviso solo si llega ?error=1 --%>
  <p style="color:red">${not empty param.error ? 'Datos inválidos, revisa el formulario.' : ''}</p>

  <form action="procesar.jsp" method="POST">
    <label>Nombre: <input type="text" name="nombre" required></label><br><br>
    <label>Correo: <input type="email" name="correo" required></label><br><br>
    <label>Curso:
      <select name="curso">
        <option>Desarrollo Web</option>
        <option>Base de Datos</option>
        <option>Inteligencia de Negocios</option>
      </select>
    </label><br><br>
    <button type="submit">Enviar</button>
  </form>
</body>
</html>