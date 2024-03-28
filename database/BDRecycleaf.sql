-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 14-10-2023 a las 06:36:07
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
  `direccion` varchar(45) NOT NULL,
  `telefono` varchar(45) NOT NULL,
  `horario_atencion` varchar(45) NOT NULL,
  `administrador_id` int(11) NOT NULL,
  `estado` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `encabezado_canje`
--

CREATE TABLE `encabezado_canje` (
  `id` int(11) NOT NULL,
  `fecha_canje` date NOT NULL,
  `nombre_centro_acopio` varchar(45) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `total_monedas` decimal(6,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
-- Estructura de tabla para la tabla `historial_material`
--

CREATE TABLE `historial_material` (
  `id` int(11) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `fecha_canje` date NOT NULL,
  `id_material` int(11) NOT NULL,
  `cantidad` decimal(10,2) NOT NULL
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
  `cantidad` int(11) NOT NULL,
  `precio` decimal(6,2) NOT NULL,
  `unidad_medida` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `material_centro_acopio`
--

CREATE TABLE `material_centro_acopio` (
  `idmaterial` int(11) NOT NULL,
  `idcentroacopio` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_usuario`
--

CREATE TABLE `tipo_usuario` (
  `id` int(11) NOT NULL,
  `descripcion` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id` int(11) NOT NULL,
  `correo` varchar(45) NOT NULL,
  `nombrecompleto` varchar(100) NOT NULL,
  `identificacion` int(11) NOT NULL,
  `direccion` varchar(45) NOT NULL,
  `telefono` int(11) NOT NULL,
  `contrasenna` varchar(45) NOT NULL,
  `tipo_usuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  ADD KEY `acopio_administrador_idx` (`administrador_id`);

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
  ADD KEY `Encabezado_detalle_canje_idx` (`IdEncabezado`);

--
-- Indices de la tabla `encabezado_canje`
--
ALTER TABLE `encabezado_canje`
  ADD PRIMARY KEY (`id`),
  ADD KEY `encabezado_cliente_idx` (`id_cliente`);

--
-- Indices de la tabla `historial_cupon`
--
ALTER TABLE `historial_cupon`
  ADD PRIMARY KEY (`id`),
  ADD KEY `historialcupon_cupon_idx` (`idcupon`),
  ADD KEY `historial_cupon_cliente_idx` (`id_cliente`);

--
-- Indices de la tabla `historial_material`
--
ALTER TABLE `historial_material`
  ADD PRIMARY KEY (`id`),
  ADD KEY `historialmaterial_cliente_idx` (`id_cliente`),
  ADD KEY `historialmaterial_material_idx` (`id_material`);

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
  ADD KEY `centroacopio_material_idx` (`idcentroacopio`);

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
  ADD CONSTRAINT `acopio_administrador` FOREIGN KEY (`administrador_id`) REFERENCES `usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `cupon`
--
ALTER TABLE `cupon`
  ADD CONSTRAINT `cupon_usuario` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `detalle_canje`
--
ALTER TABLE `detalle_canje`
  ADD CONSTRAINT `Encabezado_detalle_canje` FOREIGN KEY (`IdEncabezado`) REFERENCES `encabezado_canje` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `detalle_material` FOREIGN KEY (`id_material`) REFERENCES `material` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `encabezado_canje`
--
ALTER TABLE `encabezado_canje`
  ADD CONSTRAINT `encabezado_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `historial_cupon`
--
ALTER TABLE `historial_cupon`
  ADD CONSTRAINT `historial_cupon_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `historialcupon_cupon` FOREIGN KEY (`idcupon`) REFERENCES `cupon` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `historial_material`
--
ALTER TABLE `historial_material`
  ADD CONSTRAINT `historialmaterial_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `historialmaterial_material` FOREIGN KEY (`id_material`) REFERENCES `material` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `material_centro_acopio`
--
ALTER TABLE `material_centro_acopio`
  ADD CONSTRAINT `centroacopio_material` FOREIGN KEY (`idcentroacopio`) REFERENCES `centroacopio` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `material_centroacopio` FOREIGN KEY (`idmaterial`) REFERENCES `material` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `usuario_tipo_usuario` FOREIGN KEY (`tipo_usuario`) REFERENCES `tipo_usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
