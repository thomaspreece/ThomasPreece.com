<?php
function ConnectToDatabase(){
	try {
		$Gamedb = new PDO('mysql:host=localhost;dbname=gamesdbc_chess;', 'gamesdbc_chess_u', 'William20');
		$Gamedb->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
		$Gamedb->setAttribute(PDO::ATTR_EMULATE_PREPARES, false); 
	} catch(PDOException $e) {
		return null;
	}
	return $Gamedb;
}
?>