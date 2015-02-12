<?php

$MetaDescription="This website is about Thomas Preece, a graduate in Mathematics who produces bespoke programming and design work. This page shows you previous work that he has made for various clients.";
$MetaKeywords="thomas,preece,technology,volunteers,A4S,scratch,arduino,software,development,design,websites";
$MetaTitle="Portfolio - ThomasPreece.com";
$PageName="work.php";
include("includes/Header.php");

?>

<div class='PortfolioDiv Colour2'>
	<div class='InsidePortfolioDiv'>
		<h1 class='PortfolioH1'>Software Development</h1>
		<h2 class='PortfolioH2'>Bespoke software developed for customers needs</h2>	
		<p class='PortfolioP'>Over the years I have programmed in many different languages and produced various bespoke programs for clients. Below are the programs I work on in my spare time. My best single piece of software is Photon GameManager which has a small but happy base of users many of whom have complemented me on how wonderful the software is. Place your mouse over the tiles to view more about each piece of software and click on the tile to view even more information.</p>
		<div class='PortfolioTilesContainer'>
			<div class='mosaic-block fadeMosaic'>
				<a style='text-decoration:none;' onclick="$.nmManual('/portfolio/photon-soft.php',{ sizes: { minW: $(window).width()*0.8, minH: $(window).height()*0.8} });" class='mosaic-overlay'>
					<div class='mosaicdetails'>
						<h4>Photon GameManager</h4>
						<p>Game Manager is an advanced game launcher that is designed to have as many useful game related features as possible. It has been through many revisions and currently is on version 4. </p><p style='text-align:center;'><br/><br/>Click for more information</p>
					</div>
				</a>
				<div class='mosaic-backdrop'><img width='100%' src='Resources/gamemanager.jpg'/></div>
			</div>

			<div class='mosaic-block fadeMosaic'>
				<a style='text-decoration:none;' onclick="$.nmManual('portfolio/A4S.php',{ sizes: { minW: $(window).width()*0.8, minH: $(window).height()*0.8} });" class='mosaic-overlay'>
					<div class='mosaicdetails'>
						<h4>A4S Helper application</h4>
						<p>This is a program I developed to make it as simple as possible to hook an Arduino up to Scratch V2. It removes the need to use the Arduino IDE, Arduino code and command-line tools and basically requires the user to press 3 buttons in turn.</p><p style='text-align:center;'><br/>Click for more information</p>
					</div>
				</a>
				<div class='mosaic-backdrop'><img width='100%' src='Resources/A4S.jpg'/></div>
			</div>				
			
			<div class='mosaic-block fadeMosaic'>
				<a style='text-decoration:none;' onclick="$.nmManual('portfolio/turrets.php',{ sizes: { minW: $(window).width()*0.8, minH: $(window).height()*0.8} });" target='_blank' class='mosaic-overlay'>
					<div class='mosaicdetails'>
						<h4>Turrets</h4>
						<p>A interesting and fun game that was produced many years ago.</p><p style='text-align:center;'><br/><br/><br/><br/><br/>Click for more information</p>
					</div>
				</a>
				<div class='mosaic-backdrop'><img width='100%' src='Resources/turrets.jpg'/></div>
			</div>	
		
		</div>
	</div>
</div>

<div class='PortfolioDiv Colour1'>
	<div class='InsidePortfolioDiv'>
		<h1 class='PortfolioH1'>Website Development</h1>
		<h2 class='PortfolioH2'>Unique websites hand coded for clients</h2>
		<p class='PortfolioP'>Over the years I have developed a lot of websites. Most of my websites are hand coded in a text editor and are not based on templates. Some of my websites are also build around existing platforms such as phpBB and Joomla while others are built in PHP from the ground up. Below is a selection of websites that I have made. Place your mouse over the tiles to view more about each website and click on the tile to view even more information.</p>
	
		<div class='PortfolioTilesContainer'>

			<div class='mosaic-block fadeMosaic'>
				<a style='text-decoration:none;' onclick="$.nmManual('portfolio/andrew.php',{ sizes: { minW: $(window).width()*0.8, minH: $(window).height()*0.8} });" class='mosaic-overlay'>
					<div class='mosaicdetails'>
						<h4>AndrewForPostgrad.co.uk</h4>
						<p>A website designed for a University of Warwick SU election candidate.</p><p style='text-align:center;'><br/><br/><br/><br/><br/>Click for more information</p>
					</div>
				</a>
				<div class='mosaic-backdrop'><img width='100%' src='Resources/andrewforpostgrad.jpg'/></div>
			</div>		
	
			<div class='mosaic-block fadeMosaic'>
				<a style='text-decoration:none;' onclick="$.nmManual('portfolio/tfgdb.php',{ sizes: { minW: $(window).width()*0.8, minH: $(window).height()*0.8} });" class='mosaic-overlay'>
					<div class='mosaicdetails'>
						<h4>TFGdb.com</h4>
						<p>TFGdb.com is designed to be an open database of free games for PC where any user can add content. It features an extensive backend for administrators to monitor and moderate content and users.</p><p style='text-align:center;'><br/><br/>Click for more information</p>
					</div>
				</a>
				<div class='mosaic-backdrop'><img width='100%' src='Resources/tfgdb.jpg'/></div>
			</div>	

			<div class='mosaic-block fadeMosaic'>
				<a style='text-decoration:none;' onclick="$.nmManual('portfolio/photon-web.php',{ sizes: { minW: $(window).width()*0.8, minH: $(window).height()*0.8} });" class='mosaic-overlay'>
					<div class='mosaicdetails'>
						<h4>PhotonGameManager.com</h4>
						<p>PhotonGameManager.com was designed to show off the Photon Game Manager program.</p><p style='text-align:center;'><br/><br/><br/><br/><br/>Click for more information</p>
					</div>
				</a>
				<div class='mosaic-backdrop'><img width='100%' src='Resources/photongamemanager.jpg'/></div>
			</div>				





			<div class='mosaic-block fadeMosaic'>
				<a style='text-decoration:none;' onclick="$.nmManual('portfolio/Bowater.php',{ sizes: { minW: $(window).width()*0.8, minH: $(window).height()*0.8} });" class='mosaic-overlay'>
					<div class='mosaicdetails'>
						<h4>HopeIsBowater.co.uk</h4>
						<p>A website designed for a University of Warwick SU election candidate. It had to be simple to use and update due to the client not being very technologically literate.</p><p style='text-align:center;'><br/><br/><br/>Click for more information</p>
					</div>
				</a>
				<div class='mosaic-backdrop'><img width='100%' src='Resources/hopeisbowater.jpg'/></div>
			</div>	
			
			<div class='mosaic-block fadeMosaic'>
				<a style='text-decoration:none;' onclick="$.nmManual('portfolio/Volunteers.php',{ sizes: { minW: $(window).width()*0.8, minH: $(window).height()*0.8} });" class='mosaic-overlay'>
					<div class='mosaicdetails'>
						<h4>Technology Volunteers</h4>
						<p>While volunteering with the Warwick Technology Volunteers, one of my responsibilities was to maintain and update the website. As this is the first thing new volunteers see I had to update it to make it as user friendly as possible.</p><p style='text-align:center;'><br/>Click for more information</p>
					</div>
				</a>
				<div class='mosaic-backdrop'><img width='100%' src='Resources/techvols.jpg'/></div>
			</div>				

			<div class='mosaic-block fadeMosaic'>
				<a style='text-decoration:none;' onclick="$.nmManual('portfolio/D-Preece.php',{ sizes: { minW: $(window).width()*0.8, minH: $(window).height()*0.8} });" class='mosaic-overlay'>
					<div class='mosaicdetails'>
						<h4>DavidPreeceBuilder.com</h4>
						<p>A fairly basic website designed for a client. Many meeting between the client and myself took place and after many different designs, the client decided to choose the plain one that is currently in use.</p><p style='text-align:center;'><br/><br/>Click for more information</p>
					</div>
				</a>
				<div class='mosaic-backdrop'><img width='100%' src='Resources/davidpreecebuilders.jpg'/></div>
			</div>		
		
		</div>
		
	</div>
</div>

<div class='PortfolioDiv Colour2'>
	<div class='InsidePortfolioDiv'>
		<h1 class='PortfolioH1'>Video Editing</h1>
		<h2 class='PortfolioH2'>A promotional video for Photon GameManager</h2>
		<p class='PortfolioP'>The following is a video that I designed and edited to show off the full potential of my software release Photon GameManager. It is simple but effective and has helped me to increase sales of the software. Feel free to watch the finished video below.</p>
		<div class='Video'>
			<iframe width="100%" height="315" src="//www.youtube.com/embed/oKSDIxzU7f8" frameborder="0" allowfullscreen></iframe>
		</div>
	</div>
</div>



<?php
include("includes/Footer.php");
?>