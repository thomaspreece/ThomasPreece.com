<?php

$MetaDescription="This website is about Thomas Preece, a graduate in Mathematics who produces bespoke programming and design work. This page gives details about how to contact Thomas Preece.";
$MetaKeywords="thomas,preece,contact,job,hire,design,work";
$MetaTitle="Contact Me - ThomasPreece.com";
$Title="Contact Me";
$PageName="contact.php";
include("includes/Header.php");

?>

<div class='PortfolioDiv Colour2'>
	<div class='InsidePortfolioDiv'>


<?php
 
    $email_to = "Website@thomaspreece.com";
 
    $email_subject = "Website Contact Form Submitted";

	$name = "";
	$email_from = "";
	$message = "";
      
 
    // validation expected data exists
 
    if(!isset($_POST['name']) || !isset($_POST['email']) || !isset($_POST['message']) ){
      
	}else{
	 
		 
	 
		$name = $_POST['name']; // required
	 
		$email_from = $_POST['email']; // required
	 
		$message = $_POST['message']; // required
	 
		 
	 
		$error_message = "";
	 
		$email_exp = '/^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/';
	 
		if(!preg_match($email_exp,$email_from)) {
			$error_message = 'The Email Address you entered does not appear to be valid.<br />';
		}
	 
		$string_exp = "/^[A-Za-z .'-]+$/";
	 
		if(!preg_match($string_exp,$name)) {
			$error_message = 'The Name you entered does not appear to be valid.<br />';
		}
	 
		if(strlen($message) < 1) {
			$error_message = 'The message you entered does not appear to be valid.<br />';
	 
		}
	 

	if(strlen($error_message) == 0){

		$email_message = "Form details below.\n\n";
	 
		function clean_string($string) {
	 
		  $bad = array("content-type","bcc:","to:","cc:","href");
	 
		  return str_replace($bad,"",$string);
	 
		}
	 
		$email_message .= "Name: ".clean_string($name)."
		\n";
	 
		$email_message .= "Email: ".clean_string($email_from)."
		\n";
	 
		$email_message .= "Message: ".clean_string($message)."
		\n";
	 
		// create email headers
		 
		$headers = 'From: '.$email_from."\r\n".
		 
		'Reply-To: '.$email_from."\r\n" .
		 
		'X-Mailer: PHP/' . phpversion();
		 
		@mail($email_to, $email_subject, $email_message, $headers); 
		
		echo "
		<div id='ContactSuccessful'>
		Message Sent
		</div>
		<br/>
		";		

	}else{

		echo "
		<div id='ContactError'>
		".$error_message."
		</div>
		<br/>
		";
	}
 
}
?>


<form id='ContactForm' method="post" action="contact.php">
        
    <label>Name</label>
    <input id='ContactName' name="name" value='<?php echo $name;?>' placeholder="Type Your Name Here" required>
            
    <label>Email</label>
    <input id='ContactEmail' name="email" value='<?php echo $email_from;?>' type="email" placeholder="Type Your Email Address Here" required>
            
    <label>Message</label>
    <textarea id='ContactMessage' name="message" placeholder="Type Your Message Here" required><?php echo $message;?></textarea>
            
    <input id="ContactSubmit" name="submit" type="submit" value="Send">
        
</form>

	</div>
</div>

<?php
include("includes/Footer.php");
?>