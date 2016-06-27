-- phpMyAdmin SQL Dump
-- version 4.2.12deb2+deb8u1build0.15.04.1
-- http://www.phpmyadmin.net
--
-- Client :  localhost
-- Généré le :  Dim 26 Juin 2016 à 14:49
-- Version du serveur :  5.6.28-0ubuntu0.15.04.1
-- Version de PHP :  5.6.4-4ubuntu6.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données :  `mineraux.db`
--

-- --------------------------------------------------------

--
-- Structure de la table `Granites`
--

CREATE TABLE IF NOT EXISTS `Granites` (
`id_granite` smallint(50) unsigned NOT NULL,
  `Nom_granite` varchar(255) NOT NULL,
  `Image_granite` varchar(255) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `Granites`
--

INSERT INTO `Granites` (`id_granite`, `Nom_granite`, `Image_granite`) VALUES
(1, 'Biotite', ''),
(2, 'Hornblande', ''),
(3, 'Muscovite', ''),
(4, 'Orthose', ''),
(5, 'Plagioclase', ''),
(6, 'Quartz', '');

-- --------------------------------------------------------

--
-- Structure de la table `Image`
--

CREATE TABLE IF NOT EXISTS `Image` (
`id_image` int(80) NOT NULL,
  `Lien` varchar(10000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `Magmatiques`
--

CREATE TABLE IF NOT EXISTS `Magmatiques` (
`id_magmatique` smallint(50) unsigned NOT NULL,
  `Nom_magmatique` varchar(255) NOT NULL,
  `Image_magmatique` varchar(255) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `Magmatiques`
--

INSERT INTO `Magmatiques` (`id_magmatique`, `Nom_magmatique`, `Image_magmatique`) VALUES
(1, 'Amphibiole', ''),
(2, 'Micas', ''),
(3, 'Orthose_Sanidine', ''),
(4, 'Plagioclase', ''),
(5, 'Pyroxene', ''),
(6, 'Quartz', '');

-- --------------------------------------------------------

--
-- Structure de la table `Metamorphiques`
--

CREATE TABLE IF NOT EXISTS `Metamorphiques` (
`id_metamorphique` smallint(50) unsigned NOT NULL,
  `Nom_metamorphique` varchar(255) NOT NULL,
  `Image_metamorphique` varchar(255) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `Metamorphiques`
--

INSERT INTO `Metamorphiques` (`id_metamorphique`, `Nom_metamorphique`, `Image_metamorphique`) VALUES
(1, 'Glaucophane', ''),
(2, 'Grenat', ''),
(3, 'Hornblende', ''),
(4, 'Jadeite', ''),
(5, 'Plagiocasle', ''),
(6, 'Pyroxene_rel', '');

-- --------------------------------------------------------

--
-- Structure de la table `Plutoniques`
--

CREATE TABLE IF NOT EXISTS `Plutoniques` (
`id_plutonique` smallint(50) unsigned NOT NULL,
  `Nom_plutonique` varchar(255) NOT NULL,
  `Image_plutonique` varchar(255) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `Plutoniques`
--

INSERT INTO `Plutoniques` (`id_plutonique`, `Nom_plutonique`, `Image_plutonique`) VALUES
(1, 'Amphibiole_pluto', ''),
(2, 'Micas_pluto', ''),
(3, 'Orthose_pluto', ''),
(4, 'Plagioclases_pluto', ''),
(5, 'Pyroxene_pluto', ''),
(6, 'Quartz_pluto', '');

--
-- Index pour les tables exportées
--

--
-- Index pour la table `Granites`
--
ALTER TABLE `Granites`
 ADD PRIMARY KEY (`id_granite`);

--
-- Index pour la table `Image`
--
ALTER TABLE `Image`
 ADD PRIMARY KEY (`id_image`);

--
-- Index pour la table `Magmatiques`
--
ALTER TABLE `Magmatiques`
 ADD PRIMARY KEY (`id_magmatique`);

--
-- Index pour la table `Metamorphiques`
--
ALTER TABLE `Metamorphiques`
 ADD PRIMARY KEY (`id_metamorphique`);

--
-- Index pour la table `Plutoniques`
--
ALTER TABLE `Plutoniques`
 ADD PRIMARY KEY (`id_plutonique`);

--
-- AUTO_INCREMENT pour les tables exportées
--

--
-- AUTO_INCREMENT pour la table `Granites`
--
ALTER TABLE `Granites`
MODIFY `id_granite` smallint(50) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT pour la table `Image`
--
ALTER TABLE `Image`
MODIFY `id_image` int(80) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `Magmatiques`
--
ALTER TABLE `Magmatiques`
MODIFY `id_magmatique` smallint(50) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT pour la table `Metamorphiques`
--
ALTER TABLE `Metamorphiques`
MODIFY `id_metamorphique` smallint(50) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT pour la table `Plutoniques`
--
ALTER TABLE `Plutoniques`
MODIFY `id_plutonique` smallint(50) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
