<?php

$MetaDescription="";
$MetaKeywords="";
$MetaTitle="Portfolio - ThomasPreece.com";
$PageName="A4S.php";
include("../includes/HeaderInside.php");

?>


<div class='PortfolioPopup'>
	<h1 class='PortfolioH1'>About</h1>
	<p class='PortfolioP' >A4S is a program I developed to make it as simple as possible to hook an Arduino up to Scratch V2. It removes the need to use the Arduino IDE, Arduino code and command-line tools and basically requires the user to press 3 buttons in turn. The A4S program works as a launcher for a couple of different command line programs, the first is a program that compiles and uploads program code to Arduinos. The second is an extension for Scratch 2 that allows it to communicate with Arduino boards using Firmata. It consists of a Java server that Scratch connects to over HTTP and which communicates with an Arduino board over (USB) serial. The program was designed because the end user can find using the command line difficult, may not know how to find which COM port a Arduino board is installed as and has no idea about how to upload code to an Arduino. The program effectively allows users who are not very technologically literate to use an Arduino with very little effort.</p>
	<p class='PortfolioP' style='text-align:center;'><a href='resources.php'>Click Here to Visit Download Page</a></p>
</div>

<?php
//include("../includes/Footer.php");
?>