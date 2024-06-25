-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 25-06-2024 a las 03:16:09
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
-- Base de datos: `nautico`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `barcos`
--

CREATE TABLE `barcos` (
  `id_barco` int(11) NOT NULL,
  `id_socio` int(11) NOT NULL,
  `matricula` varchar(20) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `amarre` int(11) NOT NULL,
  `cuota` decimal(10,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuotas`
--

CREATE TABLE `cuotas` (
  `id_cuota` int(11) NOT NULL,
  `id_socio` int(11) NOT NULL,
  `id_metodo` int(11) NOT NULL,
  `fecha_pago` date NOT NULL,
  `monto` decimal(10,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalles_salidas`
--

CREATE TABLE `detalles_salidas` (
  `id_salida` int(11) NOT NULL,
  `fecha_salida` date NOT NULL,
  `hora_salida` time NOT NULL,
  `destino` varchar(20) NOT NULL,
  `patron_nombre` text NOT NULL,
  `patron_apellido` text NOT NULL,
  `patron_dni` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `metodo_pago`
--

CREATE TABLE `metodo_pago` (
  `id_metodo` int(11) NOT NULL,
  `id_socio` int(11) NOT NULL,
  `metodo` varchar(30) NOT NULL,
  `fecha_pago` date NOT NULL,
  `monto` decimal(10,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `no_socios`
--

CREATE TABLE `no_socios` (
  `id_no_socio` int(11) NOT NULL,
  `patron_nombre` text NOT NULL,
  `patron_apellido` text NOT NULL,
  `patron_dni` int(11) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `direccion` varchar(30) NOT NULL,
  `fecha_salida` date NOT NULL,
  `hora_salida` time NOT NULL,
  `destino` varchar(30) NOT NULL,
  `id_barco` int(11) NOT NULL,
  `id_salida` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `salidas`
--

CREATE TABLE `salidas` (
  `id_salida` int(11) NOT NULL,
  `id_barco` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `socios`
--

CREATE TABLE `socios` (
  `id_socio` int(11) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `apellido` varchar(30) NOT NULL,
  `dni` int(11) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `direccion` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `barcos`
--
ALTER TABLE `barcos`
  ADD PRIMARY KEY (`id_barco`),
  ADD KEY `barcos_id_socio_socios_id_socio` (`id_socio`);

--
-- Indices de la tabla `cuotas`
--
ALTER TABLE `cuotas`
  ADD PRIMARY KEY (`id_cuota`),
  ADD KEY `cuotas_id_socio_socios_id_socio` (`id_socio`),
  ADD KEY `cuotas_id_metodo_metodo_pago_id_metodo` (`id_metodo`);

--
-- Indices de la tabla `detalles_salidas`
--
ALTER TABLE `detalles_salidas`
  ADD PRIMARY KEY (`id_salida`);

--
-- Indices de la tabla `metodo_pago`
--
ALTER TABLE `metodo_pago`
  ADD PRIMARY KEY (`id_metodo`),
  ADD KEY `metodo_pago_id_socio_socios_id_socio` (`id_socio`);

--
-- Indices de la tabla `no_socios`
--
ALTER TABLE `no_socios`
  ADD PRIMARY KEY (`id_no_socio`),
  ADD KEY `no_socios_id_barco_barcos_id_barco` (`id_barco`),
  ADD KEY `no_socios_id_salida_detalles_salidas_id_salida` (`id_salida`);

--
-- Indices de la tabla `salidas`
--
ALTER TABLE `salidas`
  ADD KEY `salidas_id_salida_detalles_salidas_id_salida` (`id_salida`),
  ADD KEY `salidas_id_barco_barcos_id_barco` (`id_barco`);

--
-- Indices de la tabla `socios`
--
ALTER TABLE `socios`
  ADD PRIMARY KEY (`id_socio`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `barcos`
--
ALTER TABLE `barcos`
  ADD CONSTRAINT `barcos_id_socio_socios_id_socio` FOREIGN KEY (`id_socio`) REFERENCES `socios` (`id_socio`);

--
-- Filtros para la tabla `cuotas`
--
ALTER TABLE `cuotas`
  ADD CONSTRAINT `cuotas_id_metodo_metodo_pago_id_metodo` FOREIGN KEY (`id_metodo`) REFERENCES `metodo_pago` (`id_metodo`),
  ADD CONSTRAINT `cuotas_id_socio_socios_id_socio` FOREIGN KEY (`id_socio`) REFERENCES `socios` (`id_socio`);

--
-- Filtros para la tabla `metodo_pago`
--
ALTER TABLE `metodo_pago`
  ADD CONSTRAINT `metodo_pago_id_socio_socios_id_socio` FOREIGN KEY (`id_socio`) REFERENCES `socios` (`id_socio`);

--
-- Filtros para la tabla `no_socios`
--
ALTER TABLE `no_socios`
  ADD CONSTRAINT `no_socios_id_barco_barcos_id_barco` FOREIGN KEY (`id_barco`) REFERENCES `barcos` (`id_barco`),
  ADD CONSTRAINT `no_socios_id_salida_detalles_salidas_id_salida` FOREIGN KEY (`id_salida`) REFERENCES `detalles_salidas` (`id_salida`);

--
-- Filtros para la tabla `salidas`
--
ALTER TABLE `salidas`
  ADD CONSTRAINT `salidas_id_barco_barcos_id_barco` FOREIGN KEY (`id_barco`) REFERENCES `barcos` (`id_barco`),
  ADD CONSTRAINT `salidas_id_salida_detalles_salidas_id_salida` FOREIGN KEY (`id_salida`) REFERENCES `detalles_salidas` (`id_salida`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
