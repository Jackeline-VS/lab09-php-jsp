<?php
require_once __DIR__ . '/config.php';

// 1) Solo aceptar POST; si no, 405 Method Not Allowed
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    header('Allow: POST');
    exit('405 - Método no permitido');
}

// 2) Leer y validar con filter_input (no register_globals)
$nombre = trim(filter_input(INPUT_POST, 'nombre', FILTER_DEFAULT) ?? '');
$correo = filter_input(INPUT_POST, 'correo', FILTER_VALIDATE_EMAIL);
$curso  = filter_input(INPUT_POST, 'curso', FILTER_DEFAULT) ?? '';

$errores = [];
if ($nombre === '' || mb_strlen($nombre) > 60) $errores[] = 'Nombre inválido';
if ($correo === false || $correo === null)     $errores[] = 'Correo inválido';
if (!in_array($curso, CURSOS_VALIDOS, true))   $errores[] = 'Curso inválido';

// 3) Si hay errores: 302 Redirect al formulario
if ($errores) {
    $_SESSION['errores'] = $errores;
    header('Location: index.html?error=1', true, 302);
    exit;
}

// 4) Sesión: HTTP es stateless, la sesión guarda el estado entre peticiones
$_SESSION['visitas'] = ($_SESSION['visitas'] ?? 0) + 1;
?>
<!DOCTYPE html>
<html lang="es">
<head><meta charset="UTF-8"><title>Resultado</title></head>
<body>
  <h1>Datos recibidos ✔</h1>
  <p>Nombre: <?= htmlspecialchars($nombre, ENT_QUOTES, 'UTF-8') ?></p>
  <p>Correo: <?= htmlspecialchars($correo, ENT_QUOTES, 'UTF-8') ?></p>
  <p>Curso: <?= htmlspecialchars($curso, ENT_QUOTES, 'UTF-8') ?></p>
  <p>Envíos en esta sesión: <?= $_SESSION['visitas'] ?></p>
  <a href="index.html">Volver</a>
</body>
</html>