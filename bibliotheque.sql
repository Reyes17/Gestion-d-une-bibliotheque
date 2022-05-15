-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : jeu. 12 mai 2022 à 20:15
-- Version du serveur :  5.7.31
-- Version de PHP : 7.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `bibliotheque`
--

-- --------------------------------------------------------

--
-- Structure de la table `auteur`
--

DROP TABLE IF EXISTS `auteur`;
CREATE TABLE IF NOT EXISTS `auteur` (
  `num_aut` int(11) NOT NULL AUTO_INCREMENT,
  `nom_aut` varchar(255) NOT NULL,
  PRIMARY KEY (`num_aut`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `auteur_secondaire`
--

DROP TABLE IF EXISTS `auteur_secondaire`;
CREATE TABLE IF NOT EXISTS `auteur_secondaire` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cod_ouv` int(11) NOT NULL,
  `num_aut` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `num_aut` (`num_aut`),
  KEY `cod_ouv` (`cod_ouv`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `date_parution`
--

DROP TABLE IF EXISTS `date_parution`;
CREATE TABLE IF NOT EXISTS `date_parution` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cod_ouv` int(11) NOT NULL,
  `cod_lang` int(11) NOT NULL,
  `dat_par` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cod_ouv` (`cod_ouv`),
  KEY `cod_lang` (`cod_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `date_retour`
--

DROP TABLE IF EXISTS `date_retour`;
CREATE TABLE IF NOT EXISTS `date_retour` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `num_emp` int(11) NOT NULL,
  `cod_ouv` int(11) NOT NULL,
  `dat_ret` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `num_emp` (`num_emp`),
  KEY `cod_ouv` (`cod_ouv`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `domaine`
--

DROP TABLE IF EXISTS `domaine`;
CREATE TABLE IF NOT EXISTS `domaine` (
  `cod_dom` int(11) NOT NULL AUTO_INCREMENT,
  `lib_dom` varchar(255) NOT NULL,
  PRIMARY KEY (`cod_dom`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `domaine_ouvrage`
--

DROP TABLE IF EXISTS `domaine_ouvrage`;
CREATE TABLE IF NOT EXISTS `domaine_ouvrage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cod_ouv` int(11) NOT NULL,
  `cod_dom` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cod_ouv` (`cod_ouv`),
  KEY `cod_dom` (`cod_dom`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `emprumt`
--

DROP TABLE IF EXISTS `emprumt`;
CREATE TABLE IF NOT EXISTS `emprumt` (
  `num_emp` int(11) NOT NULL AUTO_INCREMENT,
  `dat_emp` datetime NOT NULL,
  `num_mem` int(11) NOT NULL,
  PRIMARY KEY (`num_emp`),
  KEY `num_mem` (`num_mem`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `langue`
--

DROP TABLE IF EXISTS `langue`;
CREATE TABLE IF NOT EXISTS `langue` (
  `cod_lang` int(11) NOT NULL AUTO_INCREMENT,
  `lib_lang` varchar(255) NOT NULL,
  PRIMARY KEY (`cod_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `membre`
--

DROP TABLE IF EXISTS `membre`;
CREATE TABLE IF NOT EXISTS `membre` (
  `num_mem` int(11) NOT NULL AUTO_INCREMENT,
  `nom_mem` varchar(255) NOT NULL,
  `adr` varchar(255) NOT NULL,
  PRIMARY KEY (`num_mem`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `ouvrage`
--

DROP TABLE IF EXISTS `ouvrage`;
CREATE TABLE IF NOT EXISTS `ouvrage` (
  `cod_ouv` int(11) NOT NULL AUTO_INCREMENT,
  `titre` varchar(255) NOT NULL,
  `nb_ex` int(11) NOT NULL,
  `num_aut` int(11) NOT NULL,
  PRIMARY KEY (`cod_ouv`),
  KEY `num_aut` (`num_aut`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `auteur_secondaire`
--
ALTER TABLE `auteur_secondaire`
  ADD CONSTRAINT `auteur_secondaire_auteur_num_aut` FOREIGN KEY (`num_aut`) REFERENCES `auteur` (`num_aut`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `auteur_secondaire_ouvrage_cod_ouv` FOREIGN KEY (`cod_ouv`) REFERENCES `ouvrage` (`cod_ouv`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `date_parution`
--
ALTER TABLE `date_parution`
  ADD CONSTRAINT `date_parution_langue_cod_lang` FOREIGN KEY (`cod_lang`) REFERENCES `langue` (`cod_lang`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `date_parution_ouvrage_cod_ouv` FOREIGN KEY (`cod_ouv`) REFERENCES `ouvrage` (`cod_ouv`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `date_retour`
--
ALTER TABLE `date_retour`
  ADD CONSTRAINT `date_retour_emprumt_num_emp` FOREIGN KEY (`num_emp`) REFERENCES `emprumt` (`num_emp`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `date_retour_ouvrage_cod_ouv` FOREIGN KEY (`cod_ouv`) REFERENCES `ouvrage` (`cod_ouv`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `domaine_ouvrage`
--
ALTER TABLE `domaine_ouvrage`
  ADD CONSTRAINT `domaine_ouvrage_cod_ouv` FOREIGN KEY (`cod_ouv`) REFERENCES `ouvrage` (`cod_ouv`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `domaine_ouvrage_domaine_cod_dom` FOREIGN KEY (`cod_dom`) REFERENCES `domaine` (`cod_dom`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `emprumt`
--
ALTER TABLE `emprumt`
  ADD CONSTRAINT `emprumt_membre_num_mem` FOREIGN KEY (`num_mem`) REFERENCES `membre` (`num_mem`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `ouvrage`
--
ALTER TABLE `ouvrage`
  ADD CONSTRAINT `ouvrage_auteur_num_aut` FOREIGN KEY (`num_aut`) REFERENCES `auteur` (`num_aut`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
