<?php
#Required file for chess computations
include_once("Game.class.php");
include_once("includes/database.php");

#Check Action isn't empty
if(ISSET($_GET['Action'])==0){
	echo 'Error: No Action submitted';
	die();
}

#All games are password protected, check password isn't empty
if (ISSET($_GET['Password'])==0){
	echo 'Error: No Password submitted';
	die();
}

#ID of game must be provided for all existing games
if($_GET['Action']!="NewGame"){
	if(ISSET($_GET['ID'])==0 ){
		echo 'Error: No ID submitted';
		die();
	}
}

#If a move is being made or queried, must provide the Move Get variable as well and it must be length 4 and be two pairs of a valid letter and number
if($_GET['Action']=="MakeMove" || $_GET['Action']=="QueryMove"){
	if(ISSET($_GET['Move'])==0 || strlen($_GET['Move'])!=4 || preg_match('/[a-h][0-8][a-h][0-8]/',$_GET['Move'])!=1 ){
		echo 'Error: Incorrect Move submitted';
		die();
	}
}

#If checking available moves and Piece is set, check it is length 2 and a valid chess square
if($_GET['Action']=="AvailableMoves"){
	if (ISSET($_GET['Piece'])==1 && $_GET['Piece']!=""){
		if(strlen($_GET['Piece'])!=2 || preg_match('/[a-h][0-8]/',$_GET['Piece'])!=1 ){
			echo 'Error: Incorrect Piece submitted';
			die();
		}
	}
}

#Try to connect to database or show error message
$Gamedb = ConnectToDatabase();
if ($Gamedb==null){
    echo 'Error: Connecting to Database';
	die();
}

if($_GET['Action']=="NewGame"){
	#Create a new chess game and save game to database
	$game = new Game();
	SaveGame($Gamedb,null,$game,$_GET['Password']);
}else{
	#Retrieve old game from database
	$stmt = $Gamedb->prepare("SELECT * FROM games WHERE ID=:id AND Password=:pass");
	$stmt->bindValue(':id', $_GET['ID'], PDO::PARAM_INT);
	$stmt->bindValue(':pass', $_GET['Password'], PDO::PARAM_STR);
	$stmt->execute();
	#If old game retrieved from database load it, otherwise throw error
	if ($stmt->rowCount()) {
		$gameRow = $stmt->fetch(PDO::FETCH_ASSOC);
		$game = unserialize($gameRow['Game']);
	}else{
		echo "Error: No game with that ID and Password in database";
		die();
	}

	if($_GET['Action']=="MakeMove"){
		#Make move in game and if it is valid save it
		$validMove = $game->make_move(substr($_GET['Move'],0,2),substr($_GET['Move'],2,2));
		if ($validMove == null){
			#Returns Invalid and reason it is invalid
			echo "Invalid
			";
			echo $game->get_message();
		}else{
			#Returns Valid and saves game
			echo "Valid";
			SaveGame($Gamedb,$_GET['ID'],$game,$_GET['Password']);
		}
	}elseif($_GET['Action']=="GetMoveCount"){
		#Return total number of moves made
		echo $game->movelist->get_total_move_num();
	}elseif($_GET['Action']=="QueryMove"){
		#Query move
		$validMove = $game->is_move_legal(substr($_GET['Move'],0,2),substr($_GET['Move'],2,2));
		if ($validMove == null || $validMove == false){
			#Returns Invalid and reason it is invalid
			echo "Invalid
			";
			echo $game->get_message();
		}else{
			#Returns Valid
			echo "Valid";
		}
	}elseif($_GET['Action']=="GetLastMove"){
		#Gets players last move in A0B1 notation
		$Move = $game->movelist->get_last_move();
		if($Move!=false){
			echo $Move->get_start_square().$Move->get_dest_square();
		}else{
			echo "Error: No last move";
		}
	}elseif($_GET['Action']=="AvailableMoves"){
		#Return a list of available moves. If optional 'Piece' is specified, only return available moves for that piece
		$Moves = $game->legal_moves();
		foreach ($Moves as $Move){
			$Start=substr($Move,0,2);
			$Finish=substr($Move,3,2);
			if (ISSET($_GET['Piece'])==0){
				echo $Start.$Finish."
";
			}else{
				if($_GET['Piece']==$Start){
					echo $Start.$Finish."
";
				}
			}
		}
	}elseif($_GET['Action']=="UndoMove"){
		#Undo last move taken and save game
		$game->take_back_move();
		SaveGame($Gamedb,$_GET['ID'],$game,$_GET['Password']);
		echo "Done";
	}elseif($_GET['Action']=="Player"){
		#Return current players go
		if($game->movelist->get_last_moved()=="white"){
			echo "black";
		}else{
			echo "white";
		}
	}elseif($_GET['Action']=="Status"){
		#Returns various status info about the game
		if($game->player_checkmated("black")){
			echo "Black Checkmated";
		}elseif($game->player_checkmated("white")){
			echo "White Checkmated";
		}elseif($game->player_stalemated("black")){
			echo "Black Stalemated";
		}elseif($game->player_stalemated("white")){
			echo "White Stalemated";
		}elseif($game->player_in_check("black")){
			echo "Black In Check";
		}elseif($game->player_in_check("white")){
			echo "White In Check";
		}else{
			echo "Fine";
		}
	}elseif($_GET['Action']=="Delete"){
		#Delete game from database
		$stmt = $Gamedb->prepare("DELETE FROM games WHERE ID=:id AND Password=:pass");
		$stmt->bindValue(':id', $_GET['ID'], PDO::PARAM_INT);
		$stmt->bindValue(':pass', $_GET['Password'], PDO::PARAM_STR);
		$stmt->execute();
		
		#Search for game, if found throw an error
		$stmt = $Gamedb->prepare("SELECT * FROM games WHERE ID=:id AND Password=:pass");
		$stmt->bindValue(':id', $_GET['ID'], PDO::PARAM_INT);
		$stmt->bindValue(':pass', $_GET['Password'], PDO::PARAM_STR);
		$stmt->execute();
		if ($stmt->rowCount()) {
			echo "Error: Failed to delete game";
		}else{
			echo "Deleted";
		}
	}else{
		echo "Error: Invalid Action";
	}
}

function SaveGame($db,$ID,$game,$Pass){
	#If ID is null then request is asking for new game otherwise update old game
	if ($ID == null){
		$stmt = $db->prepare("INSERT INTO `games`(`ID`, `Game`, `Password`) VALUES (null,:data,:pass);");
		$stmt->bindValue(':data', serialize($game), PDO::PARAM_INT);
		$stmt->bindValue(':pass', $Pass, PDO::PARAM_STR);
		$stmt->execute();	
		#Return the ID of the new game
		echo $db->lastInsertId(); 
	}else{
		$stmt = $db->prepare("UPDATE games SET Game=:data WHERE ID=:id AND Password=:pass");
		$stmt->bindValue(':id', $ID, PDO::PARAM_INT);
		$stmt->bindValue(':data', serialize($game), PDO::PARAM_INT);
		$stmt->bindValue(':pass', $Pass, PDO::PARAM_STR);
		$stmt->execute();		
	}
}

?>