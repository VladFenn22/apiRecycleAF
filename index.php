<?php
/* Mostrar errores */
ini_set('display_errors', 1);
ini_set('log_errors', 1);
ini_set('error_log', "C:/xampp/htdocs/recycleaf/php_error_log");
/*Encabezada de las solicitudes*/
/*CORS*/
header("Access-Control-Allow-Origin: * ");
header("Access-Control-Allow-Headers: *");
header("Access-Control-Allow-Methods: *");

/*--- Requerimientos Clases o librerías*/
require_once "models/MySqlConnect.php";

/***--- Agregar todos los modelos*/
require_once "models/CentroAcopioModel.php";
require_once "models/UsuarioModel.php";
require_once "models/HistorialCanjeMaterialModel.php";
require_once "models/MaterialModel.php";
require_once "models/HistorialCanjeMaterialClModel.php";
require_once "models/EncabezadoCanjeModel.php";
require_once "models/DetalleCanjeModel.php";

/***--- Agregar todos los controladores*/
require_once "controllers/CentroAcopioController.php";
require_once "controllers/UsuarioController.php";
require_once "controllers/HistorialCanjeMaterialController.php";
require_once "controllers/MaterialController.php";
require_once "controllers/HistorialMaterialClienteController.php";
require_once "controllers/EncabezadoCanjeController.php";
require_once "controllers/DetalleCanjeController.php";

//Enrutador
//RoutesController.php
require_once "controllers/RoutesController.php";
$index = new RoutesController();
$index->index();
