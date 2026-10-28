<?php
// Configuración central de la aplicación
declare(strict_types=1);

define('APP_NOMBRE', 'Lab09 - PHP');
define('CURSOS_VALIDOS', ['Desarrollo Web', 'Base de Datos', 'Inteligencia de Negocios']);

ini_set('display_errors', '1');   // Solo en desarrollo
error_reporting(E_ALL);

header('Content-Type: text/html; charset=UTF-8');
session_start();