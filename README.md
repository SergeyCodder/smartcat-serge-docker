# Serge

[Serge](https://serge.io/) _(String Extraction and Resource Generation Engine)_ is a cross-platform command-line tool that allows you to quickly set up scalable continuous localization processes. It allows developers to concentrate on maintaining resource files in a source language, and will take care of keeping all localized resource files in sync, delivered right into your version control system.

This repository provides a Docker file for Serge that is preconfigured to work with [Smartcat](https://smartcat.ai/) — an all-in-one localization platform.

Initially you can run Serge on your own computer to setup your localization projects. Once the configuration files are ready, run it on a dedicated server to enable continuous synchronization between Smartcat and your code repositories and other data sources.

## Installation

1. [Install Docker](https://www.docker.com/products/docker-desktop) for your Windows, Mac, or Linux.

2. Run this command to install Serge for the first time, or to update it to a latest version:

       $ docker pull smartcatcom/serge:v2

## Getting Started

[Use our bootstrap localization project](https://github.com/smartcatai/smartcat-serge-bootstrap) for a quick start. By the same link you will find a Getting Started guide.