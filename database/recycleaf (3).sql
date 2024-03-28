-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 31-10-2023 a las 03:54:12
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `recycleaf`
--
CREATE DATABASE IF NOT EXISTS `recycleaf` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `recycleaf`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `billetera`
--

CREATE TABLE `billetera` (
  `id` int(11) NOT NULL,
  `idUsuario` int(11) NOT NULL,
  `disponibles` int(11) NOT NULL,
  `canjeados` int(11) NOT NULL,
  `recibidos` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `centroacopio`
--

CREATE TABLE `centroacopio` (
  `id` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `provincia` varchar(45) NOT NULL,
  `canton` varchar(45) NOT NULL,
  `direccion` varchar(300) NOT NULL,
  `telefono` varchar(45) NOT NULL,
  `horario_atencion` varchar(45) NOT NULL,
  `administrador_id` int(11) NOT NULL,
  `estado` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `centroacopio`
--

INSERT INTO `centroacopio` (`id`, `nombre`, `provincia`, `canton`, `direccion`, `telefono`, `horario_atencion`, `administrador_id`, `estado`) VALUES
(1, 'RenovaGreen', 'Alajuela', 'Alajuela', 'Villa Bonita de Alajuela, 300 mts suroeste de la Gasolinera Delta y 300 sur (carretera a Villa Bonita), contiguo a Pastas Roma.', '70852863', '8:00 am / 4:00 pm', 1, 1),
(2, 'ReciPlus', 'San José', 'San José', 'Ciudad Universitaria Rodrigo Facio Brenes, San José, San Pedro', '25115508', '8:00 am / 4:00 pm', 3, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cupon`
--

CREATE TABLE `cupon` (
  `id` int(11) NOT NULL,
  `idUsuario` int(11) NOT NULL,
  `descripcion` varchar(100) NOT NULL,
  `costo` int(11) NOT NULL,
  `fecha_expiracion` date NOT NULL,
  `estado` tinyint(1) NOT NULL,
  `categoria` varchar(45) NOT NULL,
  `fecha_emision` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_canje`
--

CREATE TABLE `detalle_canje` (
  `idDetalle` int(11) NOT NULL,
  `IdEncabezado` int(11) NOT NULL,
  `id_material` int(11) NOT NULL,
  `sub_total_monedas` decimal(6,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalle_canje`
--

INSERT INTO `detalle_canje` (`idDetalle`, `IdEncabezado`, `id_material`, `sub_total_monedas`) VALUES
(1, 1, 1, 2000.00),
(2, 2, 2, 2500.00),
(3, 3, 3, 1200.00),
(4, 4, 1, 1600.00),
(5, 5, 2, 2000.00),
(6, 6, 2, 3000.00),
(7, 1, 2, 3000.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `encabezado_canje`
--

CREATE TABLE `encabezado_canje` (
  `id` int(11) NOT NULL,
  `id_centro_acopio` int(11) NOT NULL,
  `id_administrador` int(11) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `fecha_canje` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `encabezado_canje`
--

INSERT INTO `encabezado_canje` (`id`, `id_centro_acopio`, `id_administrador`, `id_cliente`, `fecha_canje`) VALUES
(1, 1, 1, 2, '2023-10-24'),
(2, 2, 3, 4, '2023-10-25'),
(3, 1, 1, 5, '2023-10-25'),
(4, 1, 1, 6, '2023-10-25'),
(5, 2, 3, 7, '2023-10-25'),
(6, 1, 1, 2, '2023-10-28'),
(7, 1, 1, 2, '2023-10-24');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historialmaterial`
--

CREATE TABLE `historialmaterial` (
  `id` int(11) NOT NULL,
  `id_centro_acopio` int(11) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `fecha_canje` date NOT NULL,
  `id_material` int(11) NOT NULL,
  `cantidad` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `historialmaterial`
--

INSERT INTO `historialmaterial` (`id`, `id_centro_acopio`, `id_cliente`, `fecha_canje`, `id_material`, `cantidad`) VALUES
(1, 1, 2, '2023-10-24', 1, 100.00),
(2, 2, 4, '2023-10-25', 2, 50.00),
(3, 1, 5, '2023-10-25', 3, 40.00),
(4, 1, 6, '2023-10-25', 1, 80.00),
(5, 2, 7, '2023-10-25', 2, 40.00),
(6, 1, 2, '2023-10-28', 2, 60.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_cupon`
--

CREATE TABLE `historial_cupon` (
  `id` int(11) NOT NULL,
  `idcupon` int(11) NOT NULL,
  `fecha_canje` date NOT NULL,
  `cantidad` int(11) NOT NULL,
  `id_cliente` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `material`
--

CREATE TABLE `material` (
  `id` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `descripcion` varchar(45) NOT NULL,
  `color` varchar(45) NOT NULL,
  `linkImagen` varchar(200) NOT NULL,
  `precio` decimal(6,2) NOT NULL,
  `unidad_medida` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `material`
--

INSERT INTO `material` (`id`, `nombre`, `descripcion`, `color`, `linkImagen`, `precio`, `unidad_medida`) VALUES
(1, 'Plastico', 'Todo tipo de plastico', '#4686C2', '../../assets/imagen_plastico.jpg', 20.00, 'kg'),
(2, 'Vidrio', 'Vidrio roto y en buen estado', '#B94791', 'jjj', 50.00, 'kg'),
(3, 'Textiles', 'Ropa y telas', '#fff', 'hafdg', 30.00, 'kg'),
(4, 'Aluminio', 'Latas', '#DFDF8E', 'bgfs', 50.00, 'kg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `material_centro_acopio`
--

CREATE TABLE `material_centro_acopio` (
  `idmaterial` int(11) NOT NULL,
  `idcentroacopio` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `material_centro_acopio`
--

INSERT INTO `material_centro_acopio` (`idmaterial`, `idcentroacopio`) VALUES
(1, 1),
(1, 2),
(2, 2),
(3, 1),
(3, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_usuario`
--

CREATE TABLE `tipo_usuario` (
  `id` int(11) NOT NULL,
  `descripcion` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tipo_usuario`
--

INSERT INTO `tipo_usuario` (`id`, `descripcion`) VALUES
(1, 'administrador'),
(2, 'cliente');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id` int(11) NOT NULL,
  `correo` varchar(45) NOT NULL,
  `nombrecompleto` varchar(100) NOT NULL,
  `identificacion` int(11) NOT NULL,
  `direccion` varchar(300) NOT NULL,
  `telefono` int(11) NOT NULL,
  `contrasenna` varchar(45) NOT NULL,
  `tipo_usuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id`, `correo`, `nombrecompleto`, `identificacion`, `direccion`, `telefono`, `contrasenna`, `tipo_usuario`) VALUES
(1, 'mbeto56@gmail.com', 'Mario Alberto Arias Araya', 207240806, '25 mtsoeste 25 mts sur de la Escuela de Lider de Villa Bonita ', 70852863, 'admin123', 1),
(2, 'ariasluisangel262@gmail.com', 'Luis Angel Arias Segura', 204070505, '50 mts oeste 50 mts norte del Super el Buen Trato', 83711287, 'cliente123', 2),
(3, 'vlfennerzeest.utn.ac.cr', 'Vladimir Fenner Zelaya', 207270727, 'Ciudad Universitaria Rodrigo Facio Brenes, San José, San Pedro', 71276842, 'admin123', 1),
(4, 'arayaflora@gmail.com', 'Flora María del Carmen Araya Sánchez', 204210366, '50 mts oeste 50 mts norte del Super el Buen Trato', 84816331, 'cliente123', 2),
(5, 'prueba1@gmail.com', 'Prueba1', 101110111, 'prueba1prueba1', 11111111, 'cliente123', 2),
(6, 'prueba2@gmail.com', 'Prueba2', 202220222, 'prueba2prueba2', 22222222, 'cliente123', 2),
(7, 'prueba3@gmail.com', 'Prueba3', 303330333, 'prueba3prueba3', 33333333, 'cliente123', 2);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `billetera`
--
ALTER TABLE `billetera`
  ADD PRIMARY KEY (`id`),
  ADD KEY `billetera_usuario_idx` (`idUsuario`);

--
-- Indices de la tabla `centroacopio`
--
ALTER TABLE `centroacopio`
  ADD PRIMARY KEY (`id`),
  ADD KEY `centro_usuario_idx` (`administrador_id`);

--
-- Indices de la tabla `cupon`
--
ALTER TABLE `cupon`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cupon_usuario_idx` (`idUsuario`);

--
-- Indices de la tabla `detalle_canje`
--
ALTER TABLE `detalle_canje`
  ADD PRIMARY KEY (`idDetalle`,`IdEncabezado`),
  ADD KEY `detalle_material_idx` (`id_material`),
  ADD KEY `detalle_encabezado_idx` (`IdEncabezado`);

--
-- Indices de la tabla `encabezado_canje`
--
ALTER TABLE `encabezado_canje`
  ADD PRIMARY KEY (`id`),
  ADD KEY `encabezado_usuario_idx` (`id_cliente`),
  ADD KEY `encabezado_administrador_idx` (`id_administrador`),
  ADD KEY `enabezado_centroacopio_idx` (`id_centro_acopio`);

--
-- Indices de la tabla `historialmaterial`
--
ALTER TABLE `historialmaterial`
  ADD PRIMARY KEY (`id`),
  ADD KEY `historial_material_usuario_idx` (`id_cliente`),
  ADD KEY `hitorial_material_idx` (`id_material`),
  ADD KEY `Historial_centro_idx` (`id_centro_acopio`);

--
-- Indices de la tabla `historial_cupon`
--
ALTER TABLE `historial_cupon`
  ADD PRIMARY KEY (`id`),
  ADD KEY `historial_cupon_usuario_idx` (`id_cliente`),
  ADD KEY `historial_cupon_cupon_idx` (`idcupon`);

--
-- Indices de la tabla `material`
--
ALTER TABLE `material`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `material_centro_acopio`
--
ALTER TABLE `material_centro_acopio`
  ADD PRIMARY KEY (`idmaterial`,`idcentroacopio`),
  ADD KEY `material_centroacopio_idx` (`idcentroacopio`);

--
-- Indices de la tabla `tipo_usuario`
--
ALTER TABLE `tipo_usuario`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_tipo_usuario_idx` (`tipo_usuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `billetera`
--
ALTER TABLE `billetera`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `centroacopio`
--
ALTER TABLE `centroacopio`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `cupon`
--
ALTER TABLE `cupon`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `detalle_canje`
--
ALTER TABLE `detalle_canje`
  MODIFY `idDetalle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `encabezado_canje`
--
ALTER TABLE `encabezado_canje`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `historialmaterial`
--
ALTER TABLE `historialmaterial`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `historial_cupon`
--
ALTER TABLE `historial_cupon`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `material`
--
ALTER TABLE `material`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `tipo_usuario`
--
ALTER TABLE `tipo_usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `billetera`
--
ALTER TABLE `billetera`
  ADD CONSTRAINT `billetera_usuario` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `centroacopio`
--
ALTER TABLE `centroacopio`
  ADD CONSTRAINT `centro_usuario` FOREIGN KEY (`administrador_id`) REFERENCES `usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `cupon`
--
ALTER TABLE `cupon`
  ADD CONSTRAINT `cupon_usuario` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `detalle_canje`
--
ALTER TABLE `detalle_canje`
  ADD CONSTRAINT `detalle_encabezado` FOREIGN KEY (`IdEncabezado`) REFERENCES `encabezado_canje` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `detalle_material` FOREIGN KEY (`id_material`) REFERENCES `material` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `encabezado_canje`
--
ALTER TABLE `encabezado_canje`
  ADD CONSTRAINT `enabezado_centroacopio` FOREIGN KEY (`id_centro_acopio`) REFERENCES `centroacopio` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `encabezado_administrador` FOREIGN KEY (`id_administrador`) REFERENCES `usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `encabezado_usuario` FOREIGN KEY (`id_cliente`) REFERENCES `usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `historialmaterial`
--
ALTER TABLE `historialmaterial`
  ADD CONSTRAINT `historial_material_usuario` FOREIGN KEY (`id_cliente`) REFERENCES `usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `hitorial_material` FOREIGN KEY (`id_material`) REFERENCES `material` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `historial_cupon`
--
ALTER TABLE `historial_cupon`
  ADD CONSTRAINT `historial_cupon_cupon` FOREIGN KEY (`idcupon`) REFERENCES `cupon` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `historial_cupon_usuario` FOREIGN KEY (`id_cliente`) REFERENCES `usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `material_centro_acopio`
--
ALTER TABLE `material_centro_acopio`
  ADD CONSTRAINT `centroacopio_material` FOREIGN KEY (`idmaterial`) REFERENCES `material` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `material_centroacopio` FOREIGN KEY (`idcentroacopio`) REFERENCES `centroacopio` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `usuario_tipo_usuario` FOREIGN KEY (`tipo_usuario`) REFERENCES `tipo_usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
