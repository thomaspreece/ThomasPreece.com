
<?php

$MetaDescription="";
$MetaKeywords="";
$MetaTitle="Portfolio - ThomasPreece.com";
$PageName="photon-web.php";
include("../includes/HeaderInside.php");

?>


<div style='width:1000px;margin-left:auto;margin-right:auto;padding-bottom:10px;'>
	<h1 class='PortfolioH1'>About</h1>
	<p class='PortfolioP' >
	PhotonGameManager.com was designed to show off the Photon Game Manager program. It is a fairly simple website with very little server-side scripting and user-side scripting but does exactly what it was designed for and does it well. It's main notable feature is PayPal integration along with discount codes. The site also implements PayPals Instant Payment Notification to validate payments.</p>
	<p class='PortfolioP' style='text-align:center;'><a href='http://photongamemanager.com'>Click Here to Visit Website</a></p>
	<h1 class='PortfolioH1'>Website</h1>
</div>


<iframe class='iframe' src="http://photongamemanager.com" style='width:100%;'></iframe>

<script type="text/javascript">
var cw = window.innerHeight;
$('.iframe').css({ 'height': ((cw)*75)/100 + 'px' });
</script>

<?php
//include("../includes/Footer.php");
?>